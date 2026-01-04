#!/usr/bin/env bash
set -e

MSG="$1"
TIME=$(date "+%Y-%m-%d %H:%M:%S")
BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [[ -z "${MSG}" ]]; then
    MSG="auto commit @ ${TIME}"
fi

if [[ -z "$(git status --porcelain)" ]]; then
    echo "[INFO] Clean working tree. Nothing to do."
    exit 0
fi

echo "[INFO] Branch     : ${BRANCH}"
echo "[INFO] Commit msg : ${MSG}"

git add -A
git commit -m "${MSG}"

if git push origin "${BRANCH}"; then
    echo "[SUCCESS] Push succeeded."
else
    echo "[ERROR] Push failed. Rollback commit."
    git reset --hard HEAD~1
    exit 1
fi
