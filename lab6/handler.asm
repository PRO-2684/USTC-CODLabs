ENTER:
# TODO: Save used registers
lui a0, 8
addi a0, a0, 0xffffff00 # a0 = 0x7f00
lui t0, 0xfff88810
addi t0, t0, 0xfffff888 # t0 = 0x8880F888
sw t0, 8(a0) # Segment display
sw zero, 0(a0) # Reset button status
POLLING:
lw t0, 0(a0)
beqz t0, POLLING
sw zero, 8(a0)
ret