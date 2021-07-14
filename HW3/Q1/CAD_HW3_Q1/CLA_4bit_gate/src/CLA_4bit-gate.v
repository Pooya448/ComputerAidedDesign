module cla(
	input [3:0] a,
	input [3:0] b,
	input cin,
	output [3:0] sum,
	output cout);	 
	
	wire [3:1] c;
	wire [3:0] pc;
	wire [5:0] gp;
	wire [3:0] G,P;
	
	and #(10) (G[0], a[0], b[0]);  
	and #(10) (G[1], a[1], b[1]);
	and #(10) (G[2], a[2], b[2]);
	and #(10) (G[3], a[3], b[3]);
	or #(10) (P[0], a[0], b[0]);
	or #(10) (P[1], a[1], b[1]);
	or #(10) (P[2], a[2], b[2]);
	or #(10) (P[3], a[3], b[3]);  
	
	and #(10) (pc[0], P[0], cin); 
	and #(10) (pc[1], P[1], P[0], cin);
	and #(10) (pc[2], P[2], P[1], P[0], cin);
	and #(10) (pc[3], P[3], P[2], P[1], P[0], cin);	
	
	and #(10) (gp[0], G[0], P[1]);	 
	and #(10) (gp[1], G[0], P[1], P[2]);
	and #(10) (gp[2], G[0], P[1], P[2], P[3]);
	and #(10) (gp[3], G[1], P[2]);
	and #(10) (gp[4], G[1], P[2], P[3]);
	and #(10) (gp[5], G[2], P[3]);
	
	or #(10) (c[1], G[0], pc[0]); 
	or #(10) (c[2], G[1], gp[0], pc[1]);
	or #(10) (c[3], G[2], gp[1], gp[3], pc[2]);
	or #(10) (cout, G[3], gp[2], gp[4], gp[5], pc[3]);
	
	xor #(30) (sum[0], a[0], b[0], cin);
	xor #(30) (sum[1], a[1], b[1], c[1]);
	xor #(30) (sum[2], a[2], b[2], c[2]);
	xor #(30) (sum[3], a[3], b[3], c[3]);
endmodule