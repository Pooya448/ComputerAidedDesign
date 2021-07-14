module LDLD_MST_protein_det(
	input [7:0] x,
	input clk,
	input rst,
	output reg y);
	
	reg [2:0] curSt, nextSt;
	
	parameter Start = 0,
	L = 1, LD = 2, LDL = 3,
	M = 4, MS = 5,
	Detected = 6; 
	
	always@(posedge clk) begin
		if (rst) begin
			curSt = Start;
			y = 0;
		end
		else curSt = nextSt;
	end
	
	always@(curSt or x) begin
		case(curSt)
			Start: begin
				y = 0;
				if (x == "L") nextSt = L;	  
				else if (x == "M") nextSt = M;
				else nextSt = Start;
			end
			
			L: begin
				y = 0;
				if (x == "D") nextSt = LD;
				else if (x == "L") nextSt = L;
				else if (x == "M") nextSt = M;
				else nextSt = Start;
			end
			
			LD: begin
				y = 0;
				if (x == "L") nextSt = LDL;
				else if (x == "D") nextSt = Start;
				else if (x == "M") nextSt = M;
				else nextSt = Start;
			end	 
			
			LDL: begin
				y = 0;
				if (x == "L") nextSt = L;
				else if (x == "D") nextSt = Detected;
				else if (x == "M") nextSt = M;
				else nextSt = Start;
			end	   
			
			Detected: begin
				y = 1;
				if (x == "L") nextSt = L;	 
				else if (x == "M") nextSt = M;
				else nextSt = Start;
			end
			
			M: begin
				y = 0;
				if (x == "L") nextSt = L;			
				else if (x == "S") nextSt = MS;
				else if (x == "M") nextSt = M;
				else nextSt = Start;
			end	  
			
			MS: begin
				y = 0;
				if (x == "L") nextSt = L;
				else if (x == "T") nextSt = Detected;
				else if (x == "M") nextSt = M;
				else nextSt = Start;
			end	 
		endcase
	end	
endmodule