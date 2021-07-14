module start (input clk,
                  input reset,
                  input [4:0] in,	// 0 for no button, 1-10 inside buttons, 11-20 up buttons, 21-30 down buttons	
				  input move_dir,	// indicates the direction of the pressed button
                  output reg [1:0] out );	// 00 stops, 01 goes down, 10 goes up
  	parameter off 		= 0,
  			  active 	= 1;
	reg [1:0] cur_state, next_state;
	integer up_btns [9:0];	
	integer down_btns [9:0]; 
	integer inside_btns [9:0];
	integer dir, sum, i, up_min_dist, down_min_dist = 0;
	integer cur_floor = 0;
	
	// zero out buttons array
	initial
    begin
      for(i=0;i<=9;i=i+1)
        up_btns[i] = 0;
		down_btns[i] = 0;
		inside_btns[i] = 0;
    end
	
	always @(posedge clk) begin
		if(reset) begin
		  	cur_state = off;
			out = 0'b00;
		end
		else begin
			cur_state = next_state;
			if(cur_state == active)	begin
				if(dir < 0 && cur_floor > 0)
					cur_floor = cur_floor - 1;
				else if(dir > 0 && cur_floor < 10)
					cur_floor = cur_floor + 1;
			end	
		end
	end
  
	always @(cur_state or in) begin
		if(cur_state == off) begin
			if(in != 0) begin
				next_state = active;
				
				if(in > 20)
					down_btns[i-21] = 1;
				else if(in > 10)
					up_btns[i-11] = 1;
				else
					inside_btns[i-1] = 1;
				
				down_min_dist = 100;
				up_min_dist = 100; // A random big number	
				
				// Iterate over pressed buttons
				for(i=cur_floor-1; i>=0; i--)
					sum = inside_btns[i] + down_btns[i] + up_btns[i];
					dir = dir - sum;
					if(sum > 0 && (cur_floor-i) < down_min_dist)
						down_min_dist = (cur_floor-i);
				for(i=cur_floor+1; i<=9; i++)
					sum = inside_btns[i] + down_btns[i] + up_btns[i];
					dir = dir + sum;
					if(sum > 0 && (i-cur_floor) < up_min_dist)
						up_min_dist = (cur_floor-i);
					
				// Decide the directon
				if(dir > 0) begin
					assign out = 2'b10;
				end
				else if(dir < 0) begin
					assign out = 2'b01;
				end
				else begin				
					if(up_min_dist < down_min_dist) begin
						assign out = 2'b10;
					end
					else begin
						assign out = 2'b01;
					end
				end
								
			end	
		end
		else begin 
			// Check where elevator should stop
			if(dir > 0) begin
				if(up_btns[cur_floor] == 1 || inside_btns[cur_floor] == 1) begin
					out = 2'b00;
					up_btns[cur_floor] = 0;
					inside_btns[cur_floor] = 0;
				end
				if(cur_floor == 9)
					dir = -1;
			end
			else if(dir < 0) begin
				if(down_btns[cur_floor] == 1 || inside_btns[cur_floor] == 1) begin
					out = 2'b00;
					down_btns[cur_floor] = 0;
					inside_btns[cur_floor] = 0;
				end
				if(cur_floor == 0)
					dir = 1;
			end
			
			// Check if elevator should turn off
			for(i=0; i<=9; i++) 
			if(inside_btns[i] + down_btns[i] + up_btns[i] > 0)
				break; 
			
			if(i == 10) begin
				out = 2'b00;
				next_state = off;
				dir = 0;
			end	
		end
	end 
endmodule	  
 