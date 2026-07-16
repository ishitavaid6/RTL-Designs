`timescale 1ns/1ps

module stimulus;

reg  [7:1] in;
wire [3:1] out;


encoder DUT (
    .in(in),
    .out(out)
);

initial begin
    $display("Time\tInput\t\tOutput");
    $monitor("%0t\t%b\t%b", $time, in, out);

   
    in = 7'b0000000;
    #10;
    in = 7'b0000001;  
    #10;

    in = 7'b0000010; 
    #10;

    in = 7'b0000100; 
    #10;

    in = 7'b0001000;  
    #10;

    in = 7'b0010000; 
    #10;

    in = 7'b0100000; 
    #10;

    in = 7'b1000000;
    #10;
    in = 7'b1010000;  
    #10;

    $finish;
end

endmodule
endmodule
