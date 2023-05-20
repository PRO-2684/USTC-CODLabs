stages = ["if", "id", "ex", "mem", "wb"]
names = []
with open("./CPU_src/Check_Data_SEL.v") as f:
    for line in f.readlines():
        if "input" in line or "output" in line:
            line = line.strip(" ,\n")
            tokens = line.split()
            names.append(tokens[-1])

def inst(stage: str):
    print(f"Check_Data_SEL check_data_sel_{stage}(", end="")
    for name in names:
        print(f".{name}({name}_{stage})", end=", ")
    print(");")

for stage in stages:
    inst(stage)