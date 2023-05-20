print("Hazard hazard(", end="")
with open("./CPU_src/Hazard.v") as f:
    for line in f.readlines():
        if "input" in line or "output" in line:
            line = line.strip(" ,\n")
            tokens = line.split()
            name = tokens[-1]
            print(f".{name}({name})", end=", ")
print(");")