def inst(src: str):
    module = src.split("/")[-1][:-2]
    name = module.lower()
    print(f"{module} {name}(", end="")
    with open(src) as f:
        for line in f.readlines():
            if "input" in line or "output" in line:
                line = line.strip(" ,\n")
                tokens = line.split()
                name = tokens[-1]
                print(f".{name}({name})", end=", ")
    print(");")
# inst("./CPU_src/Hazard.v")
# inst("./CPU_src/Check_Data_SEL_HZD.v")
inst("./CPU_src/Check_Data_SEG_SEL.v")