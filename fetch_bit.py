from pathlib import Path

p = Path("./")
max_lab = -1
for d in p.iterdir():
    if d.is_dir() and d.name.startswith("lab"):
        try:
            lab = int(d.name[-1:])
        except:
            continue
        if lab > max_lab:
            max_lab = lab

if max_lab >= 0:
    src = Path("./vivado_proj/") / f"lab{max_lab}/lab{max_lab}.runs/impl_1/"
    dst = Path(f"./lab{max_lab}/")
    for bit in src.glob("*.bit"):
        print(f"{bit.resolve()} -> {(dst / bit.name).resolve()}")
        (dst / bit.name).write_bytes(bit.read_bytes())
