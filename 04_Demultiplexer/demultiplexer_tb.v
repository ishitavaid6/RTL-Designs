module stimulus;
reg data;
reg enable;
reg [2:0] sel;
wire [7:0] out;

demultiplexer DUT(
.data(data),
.sel(sel),
.enable(enable),
.out(out) );

initial begin
$display("Time\tEnable\tData\tSel\tOutput");
$monitor("%0t\t%b\t%b\t%b\t%b",$time, enable, data, sel, out);

    
enable = 0;
data = 1;
sel = 3'b000;
#10;

  
enable = 1;
 data = 1;

sel = 3'b000; #10;
sel = 3'b001; #10;
sel = 3'b010; #10;
sel = 3'b011; #10;
sel = 3'b100; #10;
sel = 3'b101; #10;
sel = 3'b110; #10;
sel = 3'b111; #10;

data = 0;
sel = 3'b000; #10;
sel = 3'b011; #10;
sel = 3'b111; #10;

$finish;
end

endmodule
