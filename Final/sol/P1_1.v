module Clock_divider(clock_in, clock_out1, clock_out2, clock_out3);

input clock_in;
output reg clock_out1;
output reg clock_out2;
output reg clock_out3;

reg[1:0] counter2 = 0;
reg[2:0] counter3 = 0;

always @(posedge clock_in)
begin

    counter1 <= counter2 + 1;
    counter1 <= counter3 + 1;
clock_out1 = clock_in;
 if(counter2 >= (1))
    clock_out2 <= ~clock_out2;
 if(counter3 >= (2))
    clock_out3 <= ~clock_out3;

end
endmodule
