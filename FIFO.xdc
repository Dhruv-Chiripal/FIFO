##################################
## CLOCK (100 MHz onboard)
##################################
# Rename clk → clk_100MHZ
set_property PACKAGE_PIN W5 [get_ports clk_100MHZ]
create_clock -name sys_clk -period 10.00 -waveform {0 5} [get_ports clk_100MHZ]

##################################
## RESET (BTN0 / Center Button)
##################################
# Using button as reset
set_property PACKAGE_PIN U18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

##################################
## LEDs (only 3 needed)
##################################
set_property PACKAGE_PIN U16 [get_ports {led[0]}]
set_property PACKAGE_PIN E19 [get_ports {led[1]}]
set_property PACKAGE_PIN U19 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports led[*]]
