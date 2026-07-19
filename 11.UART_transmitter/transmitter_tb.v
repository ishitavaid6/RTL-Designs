`timescale 1ns/1ps

module uart_tx_tb;
    reg clk;
    reg rst;
    reg tx_start;
    reg [7:0] tx_data;
    wire tx;
    wire tx_busy;
    wire tx_done;

    uart_tx #(
        .CLKS_PER_BIT(10)    
    ) DUT (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy),
        .tx_done(tx_done)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        tx_start = 0;
        tx_data = 8'h00;
        #20;
        rst = 0;
        #20;
        tx_data = 8'hA5;
        tx_start = 1;

        #10;
        tx_start = 0;
        wait(tx_done);

        $display("Transmission of %h completed at time %t",
                 tx_data, $time);
        #50;
        tx_data = 8'h3C;
        tx_start = 1;

        #10;
        tx_start = 0;
        wait(tx_done);

        $display("Transmission of %h completed at time %t",
                 tx_data, $time);

        #100;
        $finish;
    end

    
    initial begin
        $monitor("Time=%0t | tx_start=%b | tx=%b | tx_busy=%b | tx_done=%b",$time, tx_start, tx, tx_busy, tx_done);
    end

endmodule
