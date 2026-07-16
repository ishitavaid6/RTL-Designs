module encoder(
    input  [7:1] in,
    output reg [3:1] out
);

always @(*) begin
    case (in)
        7'b0000001: out = 3'b001; 
        7'b0000010: out = 3'b010; 
        7'b0000100: out = 3'b011; 
        7'b0001000: out = 3'b100; 
        7'b0010000: out = 3'b101;
        7'b0100000: out = 3'b110; 
        7'b1000000: out = 3'b111; 
        default:    out = 3'b000; 
    endcase
end

endmodule



