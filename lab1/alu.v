module alu #(parameter WIDTH = 6) // 数据宽度
(
    input [WIDTH-1:0] a, b,       // 两操作数（对于减运算，a是被减数）
    input [3:0] func,             // 操作功能（加、减、与、或、异或等）
    output reg [WIDTH-1:0] y,         // 运算结果（和、差 …）
    output reg of                     // 溢出标志of，加减法结果溢出时置1
);
    always @(*) begin
        // assign `y`
        case (func)
            4'b0000: y = a + b;
            4'b0001: y = a - b;
            4'b0010: y = a == b;
            4'b0011: y = a < b; // Unsigned a < b
            4'b0100: y = ($signed(a)) < ($signed(b)); // Signed a < b
            4'b0101: y = a & b;
            4'b0110: y = a | b;
            4'b0111: y = a ^ b;
            4'b1000: y = a >> b;
            4'b1001: y = a << b;
            default: y = 0;
        endcase
        // assign `of`
        if (|func[3:1]) of = 0; // `of` not used
        else if (func[0]) of = a[WIDTH-1] == b[WIDTH-1] ? 0 : a[WIDTH-1] != y[WIDTH-1]; // a - b
        else of = a[WIDTH-1] == b[WIDTH-1] ? a[WIDTH-1] != y[WIDTH-1] : 0; // a + b
    end
endmodule