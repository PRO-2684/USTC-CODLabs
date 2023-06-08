ENTER:
li a0, 0x7f00
# li a0, 0 # DEBUG
sw zero, 0(a0) # Reset button status
li t0, 0x8880F888
add t0, t0, zero
add t0, t0, zero
sw t0, 8(a0) # Segment display
# sw t0, 0(a0) # DEBUG
add t0, zero, zero
add t0, zero, zero
POLLING:
lw t0, 0(a0)
beqz t0, POLLING
add x1, x1, x0
addi x1, x1, 0
# sw zero, 8(a0)
csrrs a0, 0x0, zero
csrrs t0, 0x1, zero
add x1, x1, x0
addi x1, x1, 0
csrrs x1, 0x341, zero
addi x1, x1, 4
add x1, x1, x0
add x1, x1, x0
addi x1, x1, 0
ret
