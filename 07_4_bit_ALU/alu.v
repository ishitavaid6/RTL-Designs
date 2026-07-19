module bit_alu(
input [3:0]a,
input [3:0]b,
input[2:0] sel,
output reg[3:0] result,
output reg carry,
output reg zero );
always@(*)begin
result =4'b0000;
carry =1'b0;
case(sel)
3'b000:{carry, result}=a+b;
3'b001:{carry, result}=a-b;
3'b010:result=a&b;
3'b011:result=a|b;
3'b100:result=a^b;
3'b101:result=~a;
3'b110:result=a<<1;
3'b111:result=a>>1;
default:result=4'b0000;
endcase
if(result == 4'b0000)
zero = 1'b1;  
else
zero = 1'b0;
end
endmodule

