module comparator(
input [3:0] a,
input [3:0] b,
output reg a_gt_b,
output reg a_lt_b,
output reg a_eq_b
 );
 
reg x3,x2,x1,x0;
always@(*)begin    
 x3 = (a[3]&b[3]) | (~a[3]&~b[3]);
 x2 = (a[2]&b[2]) | (~a[2]&~b[2]);
 x1 = (a[1]&b[1]) | (~a[1]&~b[1]);
 x0 = (a[0]&b[0]) | (~a[0]&~b[0]);

a_eq_b = x3 & x2 & x1 &x0;
a_gt_b = (a[3]&~b[3]) | (x3 & a[2] & ~b[2]) | ( x3 & x2 & a[1] & ~b[1]) | (x3 & x2 & x1 & a[0] & ~b[0]);
a_lt_b = (~a[3]&b[3]) | (x3 & ~a[2] & b[2]) | (x3 & x2 & ~a[1] & b[1]) | (x3 & x2 & x1 & ~a[0] & b[0]);
end   
endmodule
