read_file -format verilog {./Final.v}
Current design is 'Final'
analyze -library WORK -format verilog {./Final.v}
elaborate Final -architecture verilog -library WORK
create_clock -name "clk" -period 100 -waveform{0 50} {clk}
compile -exact_map
write -hierarchy -format verilog -output ./Final_syn.v
write_sdf -version 1.0 -context verilog Final.sdf
