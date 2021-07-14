SetActiveLib -work
#Compiling UUT module design files

comp -include "$dsn\src\TestBench\LDLD_MST_protein_det_TB.v"
asim +access +r LDLD_MST_protein_det_tb

wave
wave -noreg x
wave -noreg clk
wave -noreg rst
wave -noreg y

run

#End simulation macro
