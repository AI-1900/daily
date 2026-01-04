#!/usr/bin/env bash
set -e

DAY=$(date +%F)
BASE=days/${DAY}

for lvl in easy medium hard; do
    mkdir -p ${BASE}/${lvl}
    cp templates/cpp/${lvl}.cpp ${BASE}/${lvl}/solution.cpp
    cp templates/python/${lvl}.py ${BASE}/${lvl}/solution.py
    cp templates/problem.md ${BASE}/${lvl}/problem.md
done

echo "✅ Created daily tasks: ${BASE}"
