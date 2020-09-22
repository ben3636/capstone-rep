#!/bin/bash
target=$(cat target.txt)
mkdir -p "Final_Report/Report-$target"
cp *-$target.html Final_Report/Report-$target
cp services.txt Final_Report/Report-$target && mv Final_Report/Report-$target/services.txt Final_Report/Report-$target/services-$target.txt
cp cve.txt Final_Report/Report-$target && mv Final_Report/Report-$target/cve.txt Final_Report/Report-$target/cve-$target.txt
cp shells.txt Final_Report/Report-$target && mv Final_Report/Report-$target/shells.txt Final_Report/Report-$target/shells-$target.txt
cp brute-scan-results-$target.txt Final_Report/Report-$target
