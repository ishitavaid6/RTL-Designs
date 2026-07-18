module stimulus;
reg [7:0] in;
wire [2:0] out;

priority_encoder DUT(
.in(in),
.out(out));

initial begin
$display("Time\tInput\tOutput");
$monitor("%0t\t%b\t%b",$time,in,out);
in=8'b00000000;
#10;
in=8'b11100000;
#10;
in=8'b01011000;
#10;
in=8'b00110101;
#10;
in=8'b00011000;
#10;
in=8'b00001110;
#10;
in=8'b00000111;
#10;
in=8'b00000011;
#10;
in=8'b00000001;
#10;
$finish;
end
endmodule
