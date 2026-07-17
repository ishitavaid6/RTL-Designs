module demultiplexer(
input data,
input [2:0] sel,
input enable,
output reg [7:0] out
 );
 always@(*)begin
 out = 8'b00000000;     
 if (enable) begin
 case (sel)
 3'b000: out={7'b0000000,data};
 3'b001: out={6'b000000,data,1'b0};
 3'b010: out={5'b00000,data,2'b00};
 3'b011: out={4'b0000,data,3'b000};
 3'b100: out={3'b000,data,4'b0000};
 3'b101: out={2'b00,data,5'b00000};
 3'b110: out={1'b0,data,6'b000000};
 3'b111: out={data,7'b0000000};
 default:out=8'b00000000;
 endcase
 end
 end 
endmodule
