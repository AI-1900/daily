#!/usr/bin/env bash
set -e
WEEK=$(date +%G-W%V)
OUT=reviews/weekly/${WEEK}.md
mkdir -p reviews/weekly

cat > ${OUT} <<EOT
# Weekly Review ${WEEK}

## 完成情况
- Easy:
- Medium:
- Hard:

## 难点
-

## 下周计划
-
EOT

echo "📝 ${OUT}"
