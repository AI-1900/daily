#!/usr/bin/env bash
set -e

ROOT="daily-leetcode"

echo "🚀 Initializing advanced daily-leetcode ..."

# ============================================================
# 目录结构
# ============================================================
mkdir -p ${ROOT}/scripts
mkdir -p ${ROOT}/templates/cpp
mkdir -p ${ROOT}/templates/python
mkdir -p ${ROOT}/days
mkdir -p ${ROOT}/build
mkdir -p ${ROOT}/reviews/weekly
mkdir -p ${ROOT}/reviews/monthly
mkdir -p ${ROOT}/hard-focus/{dp,graph,math,data-structure}

touch ${ROOT}/build/.gitkeep

# ============================================================
# README.md
# ============================================================
printf "%s\n" \
"# daily-leetcode (Advanced)" \
"" \
"目标：每日 3 题（Easy / Medium / Hard）+ Hard 专项训练" \
"" \
"## 使用" \
"./scripts/new_day.sh" \
"./scripts/run_day.sh" \
"python3 scripts/stats.py" \
"python3 scripts/tag_stats.py" \
"" \
"## 能力矩阵" \
"- Easy / Medium：熟练度" \
"- Hard：算法建模能力" \
> ${ROOT}/README.md

# ============================================================
# .gitignore
# ============================================================
printf "%s\n" \
"build/*" \
"*.o" \
"*.out" \
"__pycache__/" \
> ${ROOT}/.gitignore

# ============================================================
# problem 模板（关键）
# ============================================================
printf "%s\n" \
"# LeetCode XXX - Title" \
"" \
"## 难度" \
"Easy / Medium / Hard" \
"" \
"## 算法标签" \
"- array" \
"- dp" \
"- graph" \
"" \
"## 题意" \
"-" \
"" \
"## 解法" \
"- 核心思路：" \
"- 边界条件：" \
"" \
"## 复杂度" \
"- 时间：" \
"- 空间：" \
"" \
"## 复盘" \
"- 为何第一次没想到？" \
> ${ROOT}/templates/problem.md

# ============================================================
# C++ 模板
# ============================================================
for lvl in easy medium hard; do
printf "%s\n" \
"#include <bits/stdc++.h>" \
"using namespace std;" \
"" \
"class Solution {" \
"public:" \
"    void solve() {" \
"        // TODO" \
"    }" \
"};" \
"" \
"int main() {" \
"    Solution s;" \
"    s.solve();" \
"    return 0;" \
"}" \
> ${ROOT}/templates/cpp/${lvl}.cpp
done

# ============================================================
# Python 模板
# ============================================================
for lvl in easy medium hard; do
printf "%s\n" \
"class Solution:" \
"    def solve(self):" \
"        pass" \
"" \
"if __name__ == '__main__':" \
"    Solution().solve()" \
> ${ROOT}/templates/python/${lvl}.py
done

# ============================================================
# new_day.sh
# ============================================================
cat > ${ROOT}/scripts/new_day.sh <<'EOF'
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
EOF

# ============================================================
# run_day.sh
# ============================================================
cat > ${ROOT}/scripts/run_day.sh <<'EOF'
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
EOF

# ============================================================
# stats.py
# ============================================================
cat > ${ROOT}/scripts/stats.py <<'EOF'
import os

cnt = {"easy":0,"medium":0,"hard":0}

if not os.path.exists("days"):
    exit(0)

for d in os.listdir("days"):
    for k in cnt:
        if os.path.exists(f"days/{d}/{k}/solution.cpp"):
            cnt[k] += 1

print("📊 Progress")
for k,v in cnt.items():
    print(f"{k}: {v}")
print("total:", sum(cnt.values()))
EOF

# ============================================================
# tag_stats.py
# ============================================================
cat > ${ROOT}/scripts/tag_stats.py <<'EOF'
import os
from collections import Counter

tags = Counter()

for root, _, files in os.walk("days"):
    for f in files:
        if f == "problem.md":
            with open(os.path.join(root, f), encoding="utf-8") as fp:
                for line in fp:
                    if line.strip().startswith("- "):
                        tags[line.strip()[2:]] += 1

print("📊 Algorithm Tags")
for k,v in tags.most_common():
    print(f"{k:20} {v}")
EOF

# ============================================================
# weekly / monthly review
# ============================================================
cat > ${ROOT}/scripts/weekly_review.sh <<'EOF'
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
EOF

cat > ${ROOT}/scripts/monthly_review.sh <<'EOF'
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
EOF

# ============================================================
# hard_focus.sh
# ============================================================
cat > ${ROOT}/scripts/hard_focus.sh <<'EOF'
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
EOF

# ============================================================
# 权限
# ============================================================
chmod +x ${ROOT}/scripts/*.sh

echo "🎉 Advanced daily-leetcode initialized successfully"
