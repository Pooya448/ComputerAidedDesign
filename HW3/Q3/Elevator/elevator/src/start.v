module start (input clk,
                  input reset,
                  input [4:0] in,	// indicates a new floor button that is pushed					
                  output reg out );	// 1 goes up, 0 goes down
  	parameter off 	= 0,
  			  on 	= 1;
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
	if(in != 0) begin
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
			assign out = 1;
		end
		else if(dir < 0) begin
			assign out = 0;
		end
		else begin
			if(up_min_dist < down_min_dist) begin
				assign out = 1;
			end
			else begin
				assign out = 0;
			end
		end
			
		next_state = on;				
	end	 
  end
  
endmodule	  
 