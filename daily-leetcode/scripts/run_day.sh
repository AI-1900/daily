#!/usr/bin/env bash
set -e

DAY=$(date +%F)
BASE=days/${DAY}
mkdir -p build

for lvl in easy medium hard; do
    echo "▶ ${lvl} C++"
    g++ -std=c++17 -O2 ${BASE}/${lvl}/solution.cpp -o build/${lvl}
    ./build/${lvl}

    echo "▶ ${lvl} Python"
    python3 ${BASE}/${lvl}/solution.py
done
