module stimulus;
reg clk;
reg reset;
wire [3:0] count;

up_counter DUT(
.clk(clk),
.reset(reset),
.count(count));

always #5 clk = ~clk;
initial begin
clk = 0;
reset= 1;

$display("Time\tReset\tCount");
$monitor("%0t\t%b\t%b",$time,reset,count);
#10;
reset = 0;
#100;
reset =1;
#10;
reset = 0;
#50;
$finish;
end
endmodule
