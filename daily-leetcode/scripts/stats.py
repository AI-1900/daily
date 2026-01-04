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
