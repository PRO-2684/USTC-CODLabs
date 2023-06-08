addi t1, zero, 1
slli t1, t1, 31
addi t2, t1, 1
add t3, t1, t2
# Expect:
#   t1(x06) = 0x80000000 "ck1 06;"
#   t2(x07) = 0x80000001 "add;"
#   t3(x1c) = 0x1 "ck1 1c;"
