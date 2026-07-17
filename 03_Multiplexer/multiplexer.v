module multiplexer(
input [1:0] sel,
input i0,i1,i2,i3,
output reg out
);

always@(*)begin
case(sel)
2'b00:out=i0;
2'b01:out=i1;
2'b10:out=i2;
2'b11:out=i3;
default:out=1'b0;
endcase
end
endmodule
