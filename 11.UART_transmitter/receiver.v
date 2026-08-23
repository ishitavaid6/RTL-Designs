`timescale 1ns / 1ps


module uart_rx #(
    parameter CLKS_PER_BIT = 5208
)(
    input  wire       clk,
    input  wire       rst,
    input  wire       rx,
    output reg [7:0]  rx_data,
    output reg        rx_done,
    output reg        rx_busy,
    output reg        rx_error   
);

    localparam IDLE  = 2'b00;
    localparam START = 2'b01;
    localparam DATA  = 2'b10;
    localparam STOP  = 2'b11;

    reg [1:0]  state;
    reg [12:0] clk_count;
    reg [2:0]  bit_index;
    reg [7:0]  data_reg;

    reg rx_sync_0, rx_sync_1;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rx_sync_0 <= 1'b1;
            rx_sync_1 <= 1'b1;
        end else begin
            rx_sync_0 <= rx;
            rx_sync_1 <= rx_sync_0;
        end
    end
    wire rx_in = rx_sync_1;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state     <= IDLE;
            rx_data   <= 8'd0;
            rx_done   <= 1'b0;
            rx_busy   <= 1'b0;
            rx_error  <= 1'b0;
            clk_count <= 0;
            bit_index <= 0;
            data_reg  <= 8'd0;
        end
        else begin
            rx_done  <= 1'b0;
            rx_error <= 1'b0;

            case(state)
                
                IDLE: begin
                    rx_busy   <= 1'b0;
                    clk_count <= 0;
                    bit_index <= 0;
                    if (rx_in == 1'b0) begin
                        rx_busy <= 1'b1;
                        state   <= START;
                    end
                end

               
                START: begin
                    if (clk_count < (CLKS_PER_BIT-1)/2) begin
                        clk_count <= clk_count + 1;
                    end
                    else begin
                        if (rx_in == 1'b0) begin
                            clk_count <= 0;
                            state     <= DATA;
                        end
                        else begin
                           
                            state   <= IDLE;
                            rx_busy <= 1'b0;
                        end
                    end
                end

                DATA: begin
                    if (clk_count < CLKS_PER_BIT-1) begin
                        clk_count <= clk_count + 1;
                        if (clk_count == (CLKS_PER_BIT-1)/2)
                            data_reg[bit_index] <= rx_in;
                    end
                    else begin
                        clk_count <= 0;
                        if (bit_index < 7)
                            bit_index <= bit_index + 1;
                        else begin
                            bit_index <= 0;
                            state     <= STOP;
                        end
                    end
                end

                STOP: begin
                    if (clk_count < (CLKS_PER_BIT-1)/2) begin
                        clk_count <= clk_count + 1;
                    end
                    else begin
                        clk_count <= 0;
                        rx_busy   <= 1'b0;
                        if (rx_in == 1'b1) begin
                            rx_data <= data_reg;
                            rx_done <= 1'b1;
                        end
                        else begin
                            rx_error <= 1'b1;  
                        end
                        state <= IDLE;
                    end
                end

                default:
                    state <= IDLE;
            endcase
        end
    end

endmodule
