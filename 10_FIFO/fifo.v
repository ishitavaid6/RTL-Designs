module fifo(
input clk,
input reset,
input wr_en,
input rd_en,
input [7:0] data_in,
output reg [7:0] data_out,
output reg full,
output reg empty
);
reg [7:0] mem [7:0];
reg [2:0] wr_ptr;
reg [2:0] rd_ptr;
reg [3:0] count;
always @(posedge clk or posedge reset)
begin
if(reset)
begin
wr_ptr   <= 3'b000;
rd_ptr   <= 3'b000;
count    <= 4'b0000;
full     <= 1'b0;
empty    <= 1'b1;
data_out <= 8'b00000000;
end
else
begin
if(wr_en && !full)
begin
mem[wr_ptr] <= data_in;
wr_ptr <= wr_ptr + 1;
count <= count + 1;
end
if(rd_en && !empty)
begin
data_out <= mem[rd_ptr];
rd_ptr <= rd_ptr + 1;
count <= count - 1;
end
full  <= (count == 7);
empty <= (count == 0);
end
end

endmodule
