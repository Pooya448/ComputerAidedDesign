//-----------------------------------------------------------------------------
//
// Title       : LDLD_MST_protein_det_tb
// Design      : protein_detector
// Author      : alireza
// Company     : a
//
//-----------------------------------------------------------------------------
//
// File        : LDLD_MST_protein_det_TB.v
// Generated   : Thu Dec 31 19:51:00 2020
// From        : C:\Users\alireza\Desktop\CAD\HW3\Q2\cad_hw3_q2\protein_detector\src\TestBench\LDLD_MST_protein_det_TB_settings.txt
// By          : tb_verilog.pl ver. ver 1.2s
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------

`timescale 1ps / 1ps
module LDLD_MST_protein_det_tb;
//Parameters declaration: 
defparam UUT.Start = 0;
parameter Start = 0;
defparam UUT.L = 1;
parameter L = 1;
defparam UUT.LD = 2;
parameter LD = 2;
defparam UUT.LDL = 3;
parameter LDL = 3;
defparam UUT.M = 4;
parameter M = 4;
defparam UUT.MS = 5;
parameter MS = 5;
defparam UUT.Detected = 6;
parameter Detected = 6;

//Internal signals declarations:
reg [7:0]x;
reg clk;
reg rst;
wire y;

always #10 clk = ~clk;

// Unit Under Test port map
	LDLD_MST_protein_det UUT (
		.x(x),
		.clk(clk),
		.rst(rst),
		.y(y));

initial	begin
		$monitor($realtime,,"ps %h %h %h %h ",x,clk,rst,y);
		clk <= 0;
	    rst <= 1;
	    x <= "A";
	    repeat (2) @ (posedge clk);
		rst <= 0;
		
		//@(posedge clk) x <= "L";	
//		@(posedge clk) x <= "D";	  
//		@(posedge clk) x <= "L";	
//		@(posedge clk) x <= "D"; 
//		repeat (1) @ (posedge clk);
		
		@(posedge clk) x <= "M";	
		@(posedge clk) x <= "S";	  
		@(posedge clk) x <= "T";
		repeat (1) @ (posedge clk);
//		
//		@(posedge clk) x <= "M";	
//		@(posedge clk) x <= "S";	  
//		@(posedge clk) x <= "L";	
//		@(posedge clk) x <= "D"; 
//		@(posedge clk) x <= "L";	
//		@(posedge clk) x <= "D"; 
//		repeat (1) @ (posedge clk);
		#20 $finish;
	end
endmodule
