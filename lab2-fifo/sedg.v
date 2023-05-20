// 出/入队使能信号处理 - 异步信号同步和取边沿
module sedg (
    input clk,      // 时钟信号
    input a,       // 待处理使能信号
    output reg s,   // 同步使能信号
    output p        // 取边沿信号
);
    reg st, pt;
    always @(posedge clk) begin
        st <= a;
        s <= st;
        pt <= s;
    end
    assign p = s & ~pt;
endmodule