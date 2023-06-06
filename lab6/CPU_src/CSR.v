module CSR (
    input clk,
    input we,
    input [11:0] ra,
    output reg [31:0] rd,
    input [11:0] wa,
    input [31:0] wd
);
    reg [31:0] mepc = 0;
    reg [31:0] mcause = 0;
    always @(*) begin
        if ((ra == wa) && we && (wa == 12'h341 || wa == 12'h342)) rd = wd; // Write-first
        else case (ra)
            12'h341: rd = mepc;
            12'h342: rd = mcause;
            default: rd = 0;
        endcase
    end
    // Write
    always @(posedge clk) begin
        if (we)
            case (wa)
                12'h341: mepc <= wd;
                12'h342: mcause <= wd;
                default: ;
            endcase
    end
endmodule
