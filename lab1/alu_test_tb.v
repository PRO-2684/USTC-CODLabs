`timescale 1ns / 1ps

module alu_test_tb;
    reg clk = 0;
    reg en = 0;
    reg [5:0] x;
    reg [1:0] sel = 0;
    wire [5:0] y;
    wire of;

    alu_test alu_test_inst(clk, en, sel, x, y, of);

    // Clock
    initial begin
        forever begin
            #10 clk = ~clk;
        end
    end
    initial begin
        forever begin
            #40 en = ~en;
        end
    end
    initial begin
        forever begin
            #80 sel = sel + 1;
        end
    end

    initial begin
        //     {a, b, func} = 16'b000000_000000_0000;
        // #10 {a, b, func} = 16'b000001_000001_0000;
        // #10 {a, b, func} = 16'b011111_011111_0000;
        // #10 {a, b, func} = 16'b000001_011111_0001;
        // #10 {a, b, func} = 16'b011111_000001_0001;
        // #10 {a, b, func} = 16'b000001_000001_0010;
        // #10 {a, b, func} = 16'b000001_000010_0010;
        // #10 {a, b, func} = 16'b000010_000001_0011;
        // #10 {a, b, func} = 16'b000001_000010_0011;
        // #10 {a, b, func} = 16'b100010_100001_0100;
        // #10 {a, b, func} = 16'b100001_100010_0100;
        // #10 {a, b, func} = 16'b011111_100000_0100;
        // #10 {a, b, func} = 16'b100000_011111_0100;
        repeat(4) begin
            // Test add
                x <= 1;
            #80 x <= 1;
            #80 x <= 0;
            #80 x <= 6'b011111;
            #80 x <= 6'b011111;
            #80 x <= 0;
            // Test sub
            #80 x <= 1;
            #80 x <= 6'b011111;
            #80 x <= 1;
            #80 x <= 6'b011111;
            #80 x <= 1;
            #80 x <= 1;
        end
        #80 $finish; // 结束测试
    end

endmodule