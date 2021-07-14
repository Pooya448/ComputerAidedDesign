//-----------------------------------------------------------------------------
//
// Title       : cla_tb
// Design      : CLA_4bit_gate
// Author      : alireza
// Company     : a
//
//-----------------------------------------------------------------------------
//
// File        : cla_TB.v
// Generated   : Wed Dec 30 19:13:15 2020
// From        : C:\Users\alireza\Desktop\CAD\HW3\Q1\CAD_HW3_Q1\CLA_4bit_gate\src\TestBench\cla_TB_settings.txt
// By          : tb_verilog.pl ver. ver 1.2s
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------

`timescale 1ns / 1ps
module cla_tb;


//Internal signals declarations:
reg [3:0]a;
reg [3:0]b;
reg cin;
wire [3:0]sum;
wire cout;



// Unit Under Test port map
	cla UUT (
		.a(a),
		.b(b),
		.cin(cin),
		.sum(sum),
		.cout(cout));

initial begin
		$monitor($realtime,,"ps %h %h %h %h %h ",a,b,cin,sum,cout);
		#100;
		a = 5;
		b = 6;
		cin = 0;  
		#100;
		
		a = 1;
		b = 7;
		cin = 1;  
		#100;
		
		a = 5;
		b = 9;
		cin = 1;  
		#100;
		
		a = 10;
		b = 6;
		cin = 0;  
		#100 $finish;
	end
endmodule
