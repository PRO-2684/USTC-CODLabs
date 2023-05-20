module fifo (
    input clk, rst,     //时钟（上升沿有效）、同步复位（高电平有效）
    input [3:0] in,     //入队列数据
    input enq,          //入队列使能，高电平有效
    input deq,          //出队列使能，高电平有效
    output [3:0] out,   //出队列数据
    output full, empty, //队列满和空标志
    output [2:0] an,    //数码管选择
    output [3:0] seg    //数码管数据
);
    // 内部信号
    wire [2:0] ra0;
    wire [3:0] rd0;
    wire [2:0] ra1;
    wire [3:0] rd1;
    wire [2:0] wa;
    wire we;
    wire [3:0] wd;
    wire [7:0] valid;

    // 实例化模块
    lcu lcu_inst(clk, rst, in, enq, deq, rd0, wa, out, full, empty, ra0, wd, we, valid);
    register_file rf_inst(clk, ra0, rd0, ra1, rd1, wa, we, wd);
    sdu sdu_inst(clk, rd1, valid, ra1, an, seg);

endmodule