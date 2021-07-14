module start (input clk,
                  input reset,
                  input [4:0] in,	// indicates a new floor button that is pushed					
                  output reg [1:0] out );	// 00 stops, 01 goes down, 10 goes up
  	parameter off 	= 0,
  			  active 	= 1;
	reg [1:0] cur_state, next_state;
	integer buttons [20:0];
	integer dir, i, up_min_dist, down_min_dist = 0;
	integer cur_floor = 1;
	
	// zero out buttons array
	initial
    begin
      for(i=0;i<=20;i=i+1)
        buttons[i]=0;
    end
			
  always @ (posedge clk) begin
    if (reset) begin
      	cur_state = off;
		out = 0;
	end
	else cur_state <= next_state;		
  end

  always @ (cur_state or in) begin
	if(cur_state == off) begin
		if(in != 0) begin
			next_state = active;
			
			// Iterate over pressed buttons
			for(i=0; i<=20; i++)
				if(buttons[i] ==0) begin
					buttons[i] = in; 
					break;
				end
				else begin
					if(buttons[i] < cur_floor) begin
						dir--;
						if(cur_floor - buttons[i] < down_min_dist) begin
							down_min_dist = cur_floor - buttons[i];
						end
					end
					else begin
						dir++;
						if(buttons[i] - cur_floor < up_min_dist) begin
							up_min_dist = buttons[i] - cur_floor;
						end
					end	
				end
					
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
		for(i=0; i<=20; i++)
			if(buttons[i] != 0) begin 
				break;
			end
		if(i == 21) begin
			out = 2'b00;
			next_state = off;
		end	
	end
  end 
endmodule	  
 