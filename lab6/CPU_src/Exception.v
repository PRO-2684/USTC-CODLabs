module Exception (
    input clk,
    input alu_overflow,
    input [31:0] pc_next_ne,
    input [31:0] current_pc,
    output [31:0] pc_next,
    output reg csr_we,
    output [11:0] csr_wa,
    output [31:0] csr_wd
);
    assign csr_wa = 12'h341;
    assign csr_wd = current_pc;
    always @(posedge clk) begin
        if (alu_overflow) begin
            csr_we <= 1;
        end else csr_we <= 0;
    end
    assign pc_next = alu_overflow ? 32'h4000 : pc_next_ne;
endmodule
