module Exception (
    input alu_overflow,
    input pc_next_ne,
    output pc_next
);
    reg [31:0] mepc = 0;
    reg csr = 0;
endmodule
