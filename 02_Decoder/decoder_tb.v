module stimulus;
reg [3:1] in;
wire [7:0] out;

decoder DUT(
.in(in),
.out(out));

initial begin
$display("time\tInput\tOutput");
$monitor("%0t\t%b\t%b",$time,in,out);
in=3'b000;
#10;
in=3'b001;
#10;
in=3'b010;
#10;
in=3'b011;
#10;
in=3'b100;
#10;
in=3'b101;
#10;
in=3'b110;
#10;
in=3'b111;
#10;
$finish;
end
endmodule


