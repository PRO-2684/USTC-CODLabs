module CSR (
    input clk,
    input we,
    input [11:0] ra,
    output reg [31:0] rd,
    input [31:0] wdpc,
    input [31:0] wda0,
    input [31:0] wdt0
);
    reg [31:0] mepc = 0;
    reg [31:0] save_a0 = 0;
    reg [31:0] save_t0 = 0;
    always @(*) begin
        if (we) rd = wdpc; // Write-first
        else case (ra)
            12'h341: rd = mepc;
            12'h000: rd = save_a0;
            12'h001: rd = save_t0;
            default: rd = 0;
        endcase
    end
    // Write
    always @(posedge clk) begin
        if (we) begin
            mepc <= wdpc;
            save_a0 <= wda0;
            save_t0 <= wdt0;
        end
    end
endmodule
