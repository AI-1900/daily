#!/usr/bin/env bash
set -e

TYPE=$1
DAY=$(date +%F)

if [ -z "$TYPE" ]; then
    echo "Usage: ./hard_focus.sh dp|graph|math|data-structure"
    exit 1
fi

BASE=hard-focus/${TYPE}/${DAY}
mkdir -p ${BASE}

cp templates/cpp/hard.cpp ${BASE}/solution.cpp
cp templates/python/hard.py ${BASE}/solution.py
cp templates/problem.md ${BASE}/problem.md

echo "🔥 Hard focus created: ${BASE}"
