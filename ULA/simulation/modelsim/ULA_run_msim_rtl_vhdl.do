transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/Gabriel Crespo/Desktop/oac_c_trabalho2/ULA/ULA.vhd}

vcom -93 -work work {C:/Users/Gabriel Crespo/Desktop/oac_c_trabalho2/ULA/ULA_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneiv_hssi -L cycloneiv_pcie_hip -L cycloneiv -L rtl_work -L work -voptargs="+acc"  ULA_tb

add wave *
view structure
view signals
run 64 ps
