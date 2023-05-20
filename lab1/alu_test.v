module alu_test(
    input clk,
    input en,
    input [1:0]sel,
    input [5:0] x,
    output [5:0] y,
    output of
);
    parameter WIDTH = 6;
    reg [WIDTH-1:0] a = 0;
    reg [WIDTH-1:0] b = 0;
    reg [3:0] func = 0;
    alu alu_inst(a, b, func, y, of);
    always @(posedge clk) begin
        if (en) begin
            case (sel)
                0: a <= x;
                1: b <= x;
                2: func <= x[3:0];
                default: ;
            endcase
        end else ;
    end
endmodule
