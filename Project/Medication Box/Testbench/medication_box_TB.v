
`timescale 1ps / 1ps
module medicine_machine_tb;
//Parameters declaration:
defparam UUT.CheckTime = 0;
parameter CheckTime = 0;
defparam UUT.DrugAlarm = 1;
parameter DrugAlarm = 1;
defparam UUT.Done = 2;
parameter Done = 2;
defparam UUT.Notify = 3;
parameter Notify = 3;

//Internal signals declarations:
reg [3:0]button;
reg clk;
reg rst;
wire [3:0]shouldEat;
wire [3:0]notify;

always #10 clk = ~clk;

// Unit Under Test port map
	medicine_machine UUT (
		.button(button),
		.clk(clk),
		.rst(rst),
		.shouldEat(shouldEat),
		.notify(notify));

initial begin
	$monitor($realtime,,"ps %h %h %h %h %h ",button,clk,rst,shouldEat,notify);
		clk <= 1;
	    rst <= 1;
		button <= 4'b1101;
	    repeat (2) @ (posedge clk);
		rst <= 0;
		button <= 4'b0000;

		repeat (21) @ (posedge clk);
		rst <= 1;
		repeat (1) @ (posedge clk);
		rst <= 0;

		repeat (3) @ (posedge clk);
		@(posedge clk) button <= 4'b0010;
		repeat (2) @ (posedge clk);
		@(posedge clk) button <= 4'b1000;
		@(posedge clk) button <= 4'b0000;
		repeat (2) @ (posedge clk);
		@(posedge clk) button <= 4'b0001;
		@(posedge clk) button <= 4'b0000;
		repeat (1) @ (posedge clk);
		@(posedge clk) button <= 4'b0100;


		#40 $finish;
	end
endmodule
