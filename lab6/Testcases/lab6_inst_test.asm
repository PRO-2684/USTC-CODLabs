addi t0, zero, 1
addi t1, zero, 1
slli t0, t0, 31
slli t1, t1, 31
srli t0, t0, 4
srai t1, t1, 4
addi t0, zero, 4
sra t1, t1, t0
addi t2, zero, 4
addi t3, zero, 7
and t4, t3, t2
andi t5, t3, 4
or t4, t4, t3
ori t5, t5, 7
addi t0, zero, 10 # 0b1010
addi t1, zero, 13 # 0b1101
xor t2, t1, t0 # Expect: 0b0111
xori t3, t0, 13 # Expect: 0b0111
addi t4, zero, 3 # 0b11
slli t5, t4, 30 # 0b1100 0000 0000 0000 0000 0000 0000 0000
slt t0, t5, zero # Expect: 1
slti t1, t5, 14 # Expect: 1
sltu t2, t5, zero # Expect: 0
sltiu t3, t5, 14 # Expect: 0
