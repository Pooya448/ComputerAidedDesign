SetActiveLib -work
#Compiling UUT module design files

comp -include "$dsn\src\TestBench\four_bit_LAC_adder_TB.v"
asim +access +r four_bit_LAC_adder_tb

wave
wave -noreg a
wave -noreg b
wave -noreg cin
wave -noreg sum
wave -noreg cout

run

#End simulation macro
