addi t0, zero, 162
slli t0, t0, 8
addi t0, t0, 51
slli t0, t0, 8
addi t0, t0, 169
slli t0, t0, 8
addi t0, t0, 91
# t0 = 0xa233a95b
sw t0, 0(zero)
lw t1, 0(zero) # 0xa233a95b
lh t2, 0(zero) # 0xffffa95b
lh t3, 2(zero) # 0xffffa233
lhu t4, 0(zero) # 0x0000a95b
lhu t5, 2(zero) # 0x0000a233
lb a0, 0(zero) # 0x0.5b
lb a1, 1(zero) # 0xf.a9
lb a2, 2(zero) # 0x0.33
lb a3, 3(zero) # 0xf.a2
lbu a4, 0(zero) # 0x0.5b
lbu a5, 1(zero) # 0x0.a9
lbu a6, 2(zero) # 0x0.33
lbu a7, 3(zero) # 0x0.a2
sh t0, 4(zero)
sh t0, 6(zero)
# M[0x4]: 0xa95ba95b
sb t0, 8(zero)
sb t0, 9(zero)
sb t0, 10(zero)
sb t0, 11(zero)
# M[0x8]: 0x5b5b5b5b
lw t0, 4(zero) # Expect: t0 = 0xa95ba95b
lw t1, 8(zero) # Expect: t1 = 0x5b5b5b5b
