module ac (input clk,
                  input reset,
                  input in,	// 0: 1degree colder, 1: 1 degree hotter				
                  output reg out );	// 1: between 24,26
  	parameter normal = 0,
			  cold 	= 1,
			  hot = 2;
	reg [1:0] cur_state, next_state;
	integer temp = 25;
			
  always @ (posedge clk) begin
    if (reset) begin
      	cur_state = normal;
		out = 1;
	end
	else cur_state <= next_state;		
  end

  always @ (cur_state or in) begin
	case(cur_state)
		normal: begin
			if(temp > 26) begin
				next_state = hot;
				assign out = 0;
			end
			else if(temp < 24) begin
				next_state = cold;
				assign out = 0;
			end
		end	 
		hot: begin
			repeat(3) @(posedge	clk);
			temp--;
			if(temp <= 26) begin
				next_state = normal;
				assign out = 1;
			end
		end
		cold: begin
			repeat(3) @(posedge	clk);
			temp++;
			if(temp <= 24) begin
				next_state = normal;
				assign out = 1;
			end
		end
	endcase
		
	if(in == 1) begin
		temp++;
	end
	else begin
		temp--;
	end
  end
  
endmodule	  
 