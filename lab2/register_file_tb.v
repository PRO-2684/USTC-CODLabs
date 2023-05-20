module register_file_tb ();
    parameter WIDTH = 8;
    reg clk;
    reg [4: 0] ra0;
    wire [WIDTH - 1: 0] rd0;
    reg [4: 0] ra1;
    wire [WIDTH - 1: 0] rd1;
    reg [4: 0] wa;
    reg we;
    reg [WIDTH - 1: 0] wd;

    initial begin
        clk = 0;
        ra0 = 0;
        ra1 = 7;
        wa = 0;
        we = 0;
        wd = 0;

        forever begin
            #10 clk = ~clk;
        end
    end

    initial begin
        repeat (8) begin
            #40
            ra0 = ra0 + 1;
            ra1 = ra1 - 1;
        end
        $finish;
    end

    initial begin
        #40 wa = 5;
            wd = 6;
            we = 1;
        #20 we = 0;
        #40 wa = 0;
            wd = 9;
            we = 1;
        #20 we = 0;
    end

    register_file #(WIDTH) rf_inst(
        clk, ra0, rd0, ra1, rd1, wa, we, wd
    );

endmodule
