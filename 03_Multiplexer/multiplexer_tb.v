module stimulus;
reg [1:0] sel;
reg i0,i1,i2,i3;
wire out;

multiplexer DUT(
.sel(sel),
.i0(i0),
.i1(i1),
.i2(i2),
.i3(i3),
.out(out));

initial begin
i0 = 0;
i1 = 1;
i2 = 0;
 i3 = 1;

$display("Time\tSel\ti0 i1 i2 i3\tOut");
 $monitor("%0t\t%b\t%b %b %b %b\t%b", $time, sel, i0, i1, i2, i3, out);
sel=2'b00;
#10;
sel=2'b01;
#10;
sel=2'b10;
#10;
sel=2'b11;
#10;
$finish;
end
endmodule
