"""Revisa un exporte de transacciones de QuickBooks Online (CSV) y lista hallazgos.
Solo biblioteca estándar. Uso: python auditar_qbo.py archivo.csv [--desde AAAA-MM-DD] [--hasta AAAA-MM-DD]
Autoprueba: python auditar_qbo.py --test
"""
import argparse, csv, io, re, sys
from collections import defaultdict
from datetime import datetime

ALIAS = {
    "date": ["date", "transaction date", "fecha"],
    "type": ["transaction type", "type", "tipo"],
    "num": ["num", "no.", "number"],
    "name": ["name", "payee", "customer", "vendor", "nombre"],
    "memo": ["memo/description", "memo", "description", "descripcion"],
    "account": ["account", "account name", "full name", "cuenta", "distribution account"],
    "split": ["split", "split account"],
    "amount": ["amount", "monto", "importe"],
    "debit": ["debit", "debito"],
    "credit": ["credit", "credito"],
}
UNCAT = re.compile(r"uncategorized|ask my accountant|suspense|opening balance|sin clasificar", re.I)
OWNER = re.compile(r"owner|member|shareholder|contribution|draw|distribution|loan from|due (to|from)|aporte|retiro|socio|due\s*to", re.I)


def num(s):
    s = (s or "").strip().replace("$", "").replace(",", "").replace(" ", "")
    if not s:
        return None
    neg = s.startswith("(") and s.endswith(")")
    s = s.strip("()")
    try:
        v = float(s)
    except ValueError:
        return None
    return -v if neg else v


def pdate(s):
    for f in ("%m/%d/%Y", "%Y-%m-%d", "%m/%d/%y", "%d/%m/%Y"):
        try:
            return datetime.strptime((s or "").strip(), f).date()
        except ValueError:
            pass
    return None


def load(text):
    rows = list(csv.reader(io.StringIO(text)))
    for i, r in enumerate(rows):
        low = [c.strip().lower() for c in r]
        if any(c in ALIAS["date"] for c in low) and any(c in ALIAS["amount"] + ALIAS["debit"] for c in low):
            hdr = low
            col = {}
            for k, names in ALIAS.items():
                for j, c in enumerate(hdr):
                    if c in names:
                        col[k] = j
                        break
            return col, rows[i + 1:]
    raise SystemExit("No encontré la fila de encabezados (Date y Amount). Exporta 'Transaction List by Date' con todas las columnas.")


def audit(text, desde=None, hasta=None):
    col, body = load(text)
    tx = []
    for n, r in enumerate(body, 1):
        g = lambda k: (r[col[k]].strip() if k in col and col[k] < len(r) else "")
        d = pdate(g("date"))
        if not d:
            continue  # totales y subtítulos
        amt = num(g("amount"))
        if amt is None and ("debit" in col or "credit" in col):
            amt = (num(g("debit")) or 0) - (num(g("credit")) or 0)
        tx.append(dict(d=d, type=g("type"), num=g("num"), name=g("name"), memo=g("memo"),
                       account=g("account"), split=g("split"), amt=amt or 0.0, row=n))
    out = defaultdict(list)
    seen = defaultdict(list)
    for t in tx:
        seen[(t["d"], round(t["amt"], 2), t["name"].lower(), t["type"].lower())].append(t)
        acc = f'{t["account"]} {t["split"]}'
        if not t["account"].strip() or UNCAT.search(acc):
            out["Sin clasificar o en cuenta de paso"].append(t)
        if OWNER.search(f'{acc} {t["name"]} {t["memo"]}'):
            out["Movimientos del dueño o partes relacionadas (revisar para el 5472)"].append(t)
        if desde and t["d"] < desde or hasta and t["d"] > hasta:
            out["Fuera del período"].append(t)
        if t["amt"] == 0:
            out["Monto cero"].append(t)
        elif abs(t["amt"]) >= 5000 and abs(t["amt"]) % 1000 == 0:
            out["Montos redondos grandes (confirmar soporte)"].append(t)
    for k, v in seen.items():
        if len(v) > 1 and k[1] != 0:
            out["Posibles duplicados"].extend(v)
    return len(tx), out


def report(n, out):
    lines = [f"# Hallazgos del exporte ({n} transacciones leídas)", ""]
    if not out:
        lines.append("Sin hallazgos automáticos. Falta la revisión manual con Balance Sheet y Trial Balance.")
    for k, v in out.items():
        lines += [f"## {k} ({len(v)})", "", "| Fecha | Tipo | Nombre | Cuenta | Monto |", "|---|---|---|---|---|"]
        for t in v[:40]:
            lines.append(f'| {t["d"]} | {t["type"]} | {t["name"]} | {t["account"] or "(vacía)"} | {t["amt"]:,.2f} |')
        if len(v) > 40:
            lines.append(f"| ... | {len(v) - 40} más | | | |")
        lines.append("")
    return "\n".join(lines)


def selftest():
    csv_text = ("Transaction List by Date\nJanuary 2026\n\n"
                "Date,Transaction Type,Num,Name,Memo/Description,Account,Split,Amount\n"
                "01/05/2026,Expense,1,Adobe,Suscripcion,Software,Checking,-54.99\n"
                "01/05/2026,Expense,2,Adobe,Suscripcion,Software,Checking,-54.99\n"
                "01/10/2026,Deposit,,Cliente A,Pago,Services,Checking,5000.00\n"
                "01/12/2026,Expense,,Juan Perez,Retiro,Owner's Draws,Checking,-2000.00\n"
                "01/15/2026,Expense,,Tienda,,Uncategorized Expense,Checking,-80.00\n"
                "02/03/2026,Expense,,Zoom,,Software,Checking,-15.00\n")
    n, out = audit(csv_text, desde=datetime(2026, 1, 1).date(), hasta=datetime(2026, 1, 31).date())
    assert n == 6
    assert len(out["Posibles duplicados"]) == 2
    assert len(out["Sin clasificar o en cuenta de paso"]) == 1
    assert len(out["Movimientos del dueño o partes relacionadas (revisar para el 5472)"]) == 1
    assert len(out["Fuera del período"]) == 1
    assert len(out["Montos redondos grandes (confirmar soporte)"]) == 1
    print(report(n, out))
    print("autoprueba OK")


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8")
    ap = argparse.ArgumentParser()
    ap.add_argument("archivo", nargs="?")
    ap.add_argument("--desde")
    ap.add_argument("--hasta")
    ap.add_argument("--test", action="store_true")
    a = ap.parse_args()
    if a.test:
        selftest()
        sys.exit(0)
    if not a.archivo:
        ap.error("falta el archivo CSV")
    text = open(a.archivo, encoding="utf-8-sig", errors="replace").read()
    f = lambda s: datetime.strptime(s, "%Y-%m-%d").date() if s else None
    print(report(*audit(text, f(a.desde), f(a.hasta))))
