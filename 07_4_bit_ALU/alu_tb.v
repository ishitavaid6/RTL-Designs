module stimulus;
reg [3:0] a;
reg [3:0] b;
reg [2:0] sel;
wire [3:0] result;
wire carry;
wire zero;

bit_alu DUT(
.a(a),
.b(b),
.sel(sel),
.result(result),
.carry(carry),
.zero(zero));

initial begin
$display("Time\tsel\ta\tb\tResult\tCarry\tZero");
$monitor("%0t\t%b\t%b\t%b\t%b\t%b\t%b",$time,sel,a,b,result,carry,zero);
a = 4'b0101; b = 4'b0011; sel = 3'b000;
#10;
a = 4'b1001; b = 4'b0011; sel = 3'b001;
#10;
a = 4'b1100; b = 4'b1010; sel = 3'b010;
#10;
a = 4'b1100; b = 4'b1010; sel = 3'b011;
#10;
a = 4'b1100; b = 4'b1010; sel = 3'b100;
#10;
a = 4'b1100; b = 4'b0000; sel = 3'b101;
#10;
a = 4'b0101; b = 4'b0000; sel = 3'b110;
#10;
a = 4'b1010; b = 4'b0000; sel = 3'b111;
#10;
a = 4'b0101; b = 4'b0101; sel = 3'b001;
#10;
a = 4'b1111; b = 4'b0001; sel = 3'b000;
#10;
$finish;
end
endmodule
