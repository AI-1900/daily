#!/usr/bin/env bash
set -e
MONTH=$(date +%Y-%m)
OUT=reviews/monthly/${MONTH}.md
mkdir -p reviews/monthly

cat > ${OUT} <<EOT
# Monthly Review ${MONTH}

## 数据
-

## 最难题
-

## 下月目标
-
EOT

echo "📝 ${OUT}"
