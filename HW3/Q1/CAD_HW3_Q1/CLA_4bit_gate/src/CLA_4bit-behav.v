module cla_behav(  
	input [3:0] a,  
	input [3:0] b,  
	input cin,  
	output reg [3:0] sum,
	output reg cout); 
	
   wire [3:0] P;
   wire [3:0] G;
   reg [4:0] c;
   reg [4:0] temp;
   assign P[3:0] = a[3:0] ^ b[3:0];
   assign G[3:0] = a[3:0] & b[3:0];
   
   always @*
		begin
		   c[0] = cin;
		
		   c[1] = G[0] | (P[0] & c[0]);
		
		   c[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & c[0]);
		
		   c[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0])
		                               | (P[2] & P[1] & P[0] & cin);
		
		   c[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1])
		                        | (P[3] & P[2] & P[1] & G[0])
		                        | (P[3] & P[2] & P[1] & P[0] & cin);
		
		   temp[4:0] = {1'b0, P[3:0]} ^ c[4:0];
		   sum = temp[3:0];
		   cout = temp[4];  
		end
endmodule  