SetActiveLib -work
#Compiling UUT module design files
comp -include $dsn\src\medicine.v
comp -include "$dsn\src\TestBench\medicine_machine_TB.v"
asim +access +r medicine_machine_tb

wave
wave -noreg button
wave -noreg clk
wave -noreg rst
wave -noreg shouldEat
wave -noreg notify

run

#End simulation macro
