#!/usr/bin/env bash
set -e

chmod +x init.sh
./init.sh
cd daily-leetcode

./scripts/new_day.sh
./scripts/run_day.sh
python3 scripts/stats.py
python3 scripts/tag_stats.py
./scripts/weekly_review.sh
