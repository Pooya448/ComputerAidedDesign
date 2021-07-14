SetActiveLib -work
#Compiling UUT module design files
comp -include $dsn\src\CLA_4bit-gate.v
comp -include "$dsn\src\TestBench\cla_TB.v"
asim +access +r cla_tb

wave
wave -noreg a
wave -noreg b
wave -noreg cin
wave -noreg sum
wave -noreg cout

run

#End simulation macro
