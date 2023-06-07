module Exception (
    input clk,
    input alu_overflow,
    input [31:0] pc_next_ne,
    input [31:0] current_pc,
    input [31:0] rf_a0,
    input [31:0] rf_t0,
    output [31:0] pc_next,
    output csr_we,
    output [31:0] csr_wdpc,
    output [31:0] csr_wda0,
    output [31:0] csr_wdt0
);
    assign csr_wdpc = current_pc;
    assign csr_wda0 = rf_a0;
    assign csr_wdt0 = rf_t0;
    assign csr_we = alu_overflow;
    assign pc_next = alu_overflow ? 32'h4000 : pc_next_ne;
endmodule
