module medicine_machine(button,clk,rst,shouldEat,notify);

	input [3:0] button;
	input clk, rst;
	output reg [3:0] shouldEat, notify;

	reg [1:0] curSt, nextSt;

	integer drugs [3:0] = {1,2,3,4};
	integer times [3:0] = {3,6,2,5};
	integer ticks [3:0] = {0,0,0,0};
	integer curTime = 0, ii = 0;
	integer isClear = 0;
	parameter CheckTime = 0, DrugAlarm = 1, Done = 2, Notify = 3;

	always@(posedge clk) begin
		if (rst) begin
			curSt = CheckTime;
			shouldEat = 4'b0000;
			notify = 4'b0000;
			curTime = 0;
		end
		else begin
			curSt = nextSt;
			if (curTime == 24) begin
				curTime = 0;
			end
			for(ii=0; ii<4; ii=ii+1) begin
					if (button[ii] == 1) begin
						shouldEat[ii] = 0;
					end
				end
		end
	end

	always@(posedge clk or button) begin
		case(curSt)
			CheckTime: begin
				nextSt = DrugAlarm;
			end

			DrugAlarm: begin


				for(ii=0; ii<4; ii=ii+1) begin
        			if (curTime == times[ii] && shouldEat[ii] != 1) begin
						shouldEat[ii] = 1;
						nextSt = Done;
					end
					else if (shouldEat[ii] == 1) begin
						ticks[ii] = ticks[ii] + 1;
					end
					if (ticks[ii] == 3) begin
						ticks[ii] = 0;
						shouldEat[ii] = 0;
						notify[ii] = 1;
						nextSt = Notify;
					end
				end

				curTime = curTime + 1;
			end

			Done: begin
				nextSt = CheckTime;
			end

			Notify: begin
				for(ii=0; ii<4; ii=ii+1) begin
					notify[ii] = 0;
				end
				nextSt = CheckTime;
			end
		endcase
	end
endmodule
