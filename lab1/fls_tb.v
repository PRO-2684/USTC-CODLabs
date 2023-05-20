module fls_tb;
    reg clk = 0;
    reg rst = 0;
    reg en = 0;
    reg [6:0] d = 0;
    wire [6:0] f;
    // Clock
    initial begin
        forever begin
            #10 clk = ~clk;
        end
    end
    fls fls_inst(
        clk, rst, en, d, f
    );
    initial begin
            rst <= 1;
        #40 rst <= 0;
        #60 d <= 0;
        #40 en <= 1;
        #40 en <= 0;
            d <= 1;
        #40 en <= 1;
        #40 en <= 0;
            d <= 2;
        #40 en <= 1;
        #40 en <= 0;
        repeat (10) begin
            #40 en <= 1;
            #40 en <= 0;
        end
    end
endmodule