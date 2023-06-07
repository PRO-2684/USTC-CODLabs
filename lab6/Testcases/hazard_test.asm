addi a0, zero, 0
sw t0, 8(a0)
addi t0, zero, 114
sw zero, 0(a0)
add t0, zero, zero
add t0, zero, zero
POLLING:
lw t0, 0(a0)
beqz t0, POLLING
sw zero, 8(a0)
