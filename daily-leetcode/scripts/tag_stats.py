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
