module stop (input clk,
                  input reset,
                  input [1:0] in,	// 0 stop, 1 up, 2 down					
                  output reg out );	// 1 stops, 0 moves
  	parameter off 	= 0,
  			  on 	= 1;
	reg [1:0] cur_state, next_state;
			
  always @ (posedge clk) begin
    if (reset) begin
      	cur_state = on;
		out = 0;
	end
	else cur_state <= next_state;		
  end

  always @ (cur_state or in) begin
	if(cur_state == on) begin
		if(in == 0) begin
			next_state = off;
			assign out = 1;
		end
	end	 
  end
  
endmodule	  
 