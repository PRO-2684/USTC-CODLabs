def format(s:str):
    l = [_.strip() for _ in s.strip().split('\n')]
    d = {}
    for p in l:
        if p.endswith(" l"):
            p = p[:-2]
            n = 32
        elif " " in p:
            p, n = p.split(" ")
            n = int(n)
        else:
            n = 1
        d[p] = n
    return d
def line(prefix:str, k:str, v:int):
    if v == 1:
        print(f"    {prefix} {k},")
    else:
        print(f"    {prefix} [{v-1}:0] {k},")
def output(d: dict):
    for k, v in d.items():
        line("input", k, v)
    for k, v in d.items():
        line("output", k, v)
    print("{", end="")
    for k in d.keys():
        print(k + "_in", end=", ")
    print("}")
    print("{", end="")
    for k in d.keys():
        print(k + "_out", end=", ")
    print("}")
    for k, v in d.items():
        print(f"    .{k}_in({v}'h0),")
    for k, v in d.items():
        print(f"    .{k}_out({v}'h0),")
def gen(s:str):
    d = format(s)
    output(d)
    cnt = 0
    for v in d.values():
        cnt += v
    print(f"Width: {cnt}")



gen("""
    pc_cur l
    inst l
    rf_ra0 5
    rf_ra1 5
    rf_re0
    rf_re1
    rf_rd0_raw l
    rf_rd1_raw l
    rf_rd0 l
    rf_rd1 l
    rf_wa 5
    rf_wd_sel 2
    rf_we
    imm_type 3
    imm l
    alu_src1_sel
    alu_src2_sel
    alu_src1 l
    alu_src2 l
    alu_func 4
    alu_ans l
    pc_add4 l
    pc_br l
    pc_jal l
    pc_jalr l
    jal
    jalr
    br_type 3
    br
    pc_sel 2
    pc_next l
    dm_addr l
    dm_din l
    dm_dout l
    dm_we
""")