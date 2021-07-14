module Clock_divider_tb;

reg clock_in;
reg clock_out1;
reg clock_out2;
reg clock_out3;

Clock_divider uut (
  .clock_in(clock_in),
  .clock_out1(clock_out1),
  .clock_out2(clock_out2),
  .clock_out3(clock_out3)
 );

 initial begin
  clock_in = 0;
        forever #10 clock_in = ~clock_in;
 end
endmodule
