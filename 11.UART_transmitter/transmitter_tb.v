`timescale 1ns/1ps
module uart_tx_tb;

    localparam CLKS_PER_BIT = 10;   
    localparam BIT_PERIOD   = CLKS_PER_BIT * 10;

    reg clk;
    reg rst;
    reg tx_start;
    reg [7:0] tx_data;
    wire tx;
    wire tx_busy;
    wire tx_done;

    integer error_count;
    integer check_count;
    reg [7:0] captured_byte;
    integer   i;

    uart_tx #(
        .CLKS_PER_BIT(CLKS_PER_BIT)
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
    task send_and_check(input [7:0] expected_data);
        begin
          
            tx_data  = expected_data;
            tx_start = 1;
            @(posedge clk);
            tx_start = 0;

            @(negedge tx); // tx falls low as soon as START state begins
            #(BIT_PERIOD/2);
            check_count = check_count + 1;
            if (tx !== 1'b0) begin
                error_count = error_count + 1;
                $display("[%0t] MISMATCH: start bit expected 0, got %b", $time, tx);
            end else begin
                $display("[%0t] PASS: start bit = 0 as expected", $time);
            end
            captured_byte = 8'h00;
            for (i = 0; i < 8; i = i + 1) begin
                #(BIT_PERIOD);              
                captured_byte[i] = tx;
            end

            check_count = check_count + 1;
            if (captured_byte !== expected_data) begin
                error_count = error_count + 1;
                $display("[%0t] MISMATCH: data expected %h, got %h",
                          $time, expected_data, captured_byte);
            end else begin
                $display("[%0t] PASS: data byte = %h as expected", $time, captured_byte);
            end

            #(BIT_PERIOD);
            check_count = check_count + 1;
            if (tx !== 1'b1) begin
                error_count = error_count + 1;
                $display("[%0t] MISMATCH: stop bit expected 1, got %b", $time, tx);
            end else begin
                $display("[%0t] PASS: stop bit = 1 as expected", $time);
            end

            wait(tx_done === 1'b1);
            check_count = check_count + 1;
            if (tx_busy !== 1'b0) begin
                error_count = error_count + 1;
                $display("[%0t] MISMATCH: tx_busy expected 0 when tx_done asserts, got %b",
                          $time, tx_busy);
            end else begin
                $display("[%0t] PASS: tx_busy correctly low when tx_done asserts", $time);
            end

            $display("[%0t] Transmission of %h completed", $time, expected_data);
        end
    endtask

    initial begin
        clk      = 0;
        rst      = 1;
        tx_start = 0;
        tx_data  = 8'h00;
        error_count = 0;
        check_count = 0;

        #20;
        rst = 0;
        #20;

        check_count = check_count + 1;
        if (tx !== 1'b1 || tx_busy !== 1'b0) begin
            error_count = error_count + 1;
            $display("[%0t] MISMATCH: post-reset idle state wrong (tx=%b, tx_busy=%b)",
                      $time, tx, tx_busy);
        end else begin
            $display("[%0t] PASS: post-reset idle state correct (tx=1, tx_busy=0)", $time);
        end
        send_and_check(8'hA5);

        #50;

        send_and_check(8'h3C);

        #50;

     
        send_and_check(8'h00);

        #50;
        send_and_check(8'hFF);

        #100;

        
        if (error_count == 0)
            $display("TEST PASSED: %0d checks run, 0 mismatches", check_count);
        else
            $display("TEST FAILED: %0d checks run, %0d mismatches", check_count, error_count);
    
        $finish;
    end

    initial begin
        $monitor("Time=%0t | tx_start=%b | tx=%b | tx_busy=%b | tx_done=%b",
                  $time, tx_start, tx, tx_busy, tx_done);
    end

endmodule
