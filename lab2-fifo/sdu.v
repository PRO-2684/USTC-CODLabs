// 数码管显示单元 SDU (Segment Display Unit) - 显示队列数据和出入状态
module sdu (
    input clk,
    input [3:0] rd1,
    input [7:0] valid,
    output [2:0] ra1,
    output reg [2:0] an,
    output reg [3:0] seg
);
    // reg [7:0] cnt = 0;
    reg [7:0] cnt = 0;
    reg [2:0] pos = 0;
    assign ra1 = pos;

    initial begin
        an = 0;
        seg = 0;
    end

    always @(posedge clk) begin
        if (&cnt) begin
            if (~|valid) begin
                an <= 0;
                seg <= 0;
            end else if (valid[pos]) begin
                an <= pos;
                seg <= rd1;
            end
            pos <= pos + 1;
        end
        cnt <= cnt + 1;
    end
endmodule