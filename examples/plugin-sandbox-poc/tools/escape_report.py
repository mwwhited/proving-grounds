#!/usr/bin/env python3
"""Builds the per-OS escape result table from test results.

usage: escape_report.py [--run-windows] [--trx windows=FILE] [--trx linux=FILE] [--out docs/poc/escape-results.md]

--run-windows runs the Windows escape tests here (Windows only). --trx reads a TRX file from a run made elsewhere
(for Linux: sh linux-test/run-docker.sh writes linux-test/out/linux.trx).

A row is HELD when every deny test passed and every control passed, FAILED when a deny test failed,
CONTROL FAILED when the denial passed but its control did not (the denial proves nothing), and UNVERIFIED when no
test covers it or there is no result for that OS.
"""
import argparse
import datetime
import json
import os
import platform
import subprocess
import sys
import xml.etree.ElementTree as ET

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
NS = {"t": "http://microsoft.com/schemas/VisualStudio/TeamTest/2010"}


def read_trx(path):
    out = {}
    for r in ET.parse(path).getroot().iterfind(".//t:UnitTestResult", NS):
        name = r.get("testName").split(".")[-1].split("(")[0]
        out[name] = r.get("outcome")   # Passed, Failed, NotExecuted ...
    return out


def run_windows():
    trx = os.path.join(ROOT, "docs", "poc", ".windows.trx")
    if os.path.exists(trx):
        os.remove(trx)
    subprocess.run(["dotnet", "test", os.path.join(ROOT, "src", "OoBDev.Plugins.Launchers.Windows.Tests"),
                    "--logger", f"trx;LogFileName={trx}"], check=False)
    return trx


def judge(cell, results):
    if cell.get("na"):
        return "n/a", ""
    deny, control = cell.get("deny", []), cell.get("control", [])
    if results is None:
        return "UNVERIFIED", "no results for this OS"
    if not deny:
        return "UNVERIFIED", "no test"
    missing = [n for n in deny + control if n not in results]
    if missing:
        return "UNVERIFIED", "not run: " + ", ".join(missing)
    skipped = [n for n in deny + control if results[n] not in ("Passed", "Failed")]
    if skipped:
        return "UNVERIFIED", "skipped: " + ", ".join(skipped)
    failed = [n for n in deny if results[n] == "Failed"]
    if failed:
        return "FAILED", ", ".join(failed)
    cfail = [n for n in control if results[n] == "Failed"]
    if cfail:
        return "CONTROL FAILED", ", ".join(cfail)
    return "HELD", f"{len(deny)} denied, {len(control)} control"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--run-windows", action="store_true")
    ap.add_argument("--trx", action="append", default=[])
    ap.add_argument("--out", default=os.path.join(ROOT, "docs", "poc", "escape-results.md"))
    a = ap.parse_args()
    matrix = json.load(open(os.path.join(ROOT, "docs", "poc", "escape-matrix.json"), encoding="utf-8"))
    files = dict(x.split("=", 1) for x in a.trx)
    if a.run_windows:
        if platform.system() != "Windows":
            sys.exit("--run-windows only works on Windows")
        files["windows"] = run_windows()
    results = {os_: read_trx(f) for os_, f in files.items() if os.path.exists(f)}
    oses = list(matrix["os"])
    lines = ["# Escape results", "",
             f"Generated {datetime.date.today()} by `tools/escape_report.py` from `escape-matrix.json`. Do not edit by hand.", "",
             "HELD means every denial test passed and so did its control. Read the notes at the bottom before quoting it.", "",
             "| Capability | " + " | ".join(matrix["os"][o]["title"] for o in oses) + " |",
             "|:--|" + ":-:|" * len(oses)]
    notes = []
    held = {o: 0 for o in oses}
    applicable = {o: 0 for o in oses}
    for row in matrix["rows"]:
        cells = []
        for o in oses:
            verdict, why = judge(row.get(o, {}), results.get(o))
            cells.append(verdict)
            if verdict != "n/a":
                applicable[o] += 1
            if verdict == "HELD":
                held[o] += 1
            elif verdict != "n/a":
                notes.append(f"- **{row['what']}** on {o}: {verdict}" + (f" ({why})" if why else ""))
        lines.append(f"| {row['what']} | " + " | ".join(cells) + " |")
    lines += ["", "Held: " + ", ".join(f"{o} {held[o]}/{applicable[o]}" for o in oses), ""]
    if notes:
        lines += ["## Not held or not verified", ""] + notes + [""]
    lines += ["## Read this before quoting the table", "",
              "- One machine per OS. Linux ran in Docker on a Windows host with the container's seccomp and AppArmor relaxed so bubblewrap can create namespaces (see `findings.md`).",
              "- Linux has a filter against creating processes only, not a general syscall allow-list.",
              "- A HELD row is as strong as its tests, which the matrix lists. An attack the tests did not think of is not covered.",
              "- macOS has no launcher, so it has no column.", ""]
    with open(a.out, "w", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(lines))
    print("\n".join(lines))
    return 1 if any(" FAILED" in n for n in notes) else 0


if __name__ == "__main__":
    sys.exit(main())
