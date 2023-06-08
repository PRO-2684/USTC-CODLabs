li a0, 0x7f00
sw zero, 0(a0) # Reset button status
li t0, 0x8880F888
add t0, t0, zero
add t0, t0, zero
sw t0, 8(a0) # Segment display
add t0, zero, zero
add t0, zero, zero
POLLING:
lw t0, 0(a0)
beqz t0, POLLING
