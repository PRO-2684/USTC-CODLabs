ENTER:
li a0, 0x7f00
sw zero, 0(a0) # Reset button status
li t0, 0x8880F888
add t0, t0, zero
add t0, t0, x0
sw t0, 8(a0) # Segment display
addi t0, zero, 0
add t0, zero, zero
POLLING:
lw t0, 0(a0)
beqz t0, POLLING
csrrs a0, 0x0, zero
csrrs t0, 0x1, zero
csrrs x1, 0x341, zero
addi x1, x1, 4
ret
