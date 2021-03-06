# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/ccummi08/Desktop/Comp_4_Magnitude/Comp_4_Magnitude.cache/wt [current_project]
set_property parent.project_path C:/Users/ccummi08/Desktop/Comp_4_Magnitude/Comp_4_Magnitude.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_vhdl -library xil_defaultlib {
  C:/Users/ccummi08/Desktop/Comp_4_Magnitude/Comp_4_Magnitude.srcs/sources_1/new/RCA_4_Bits.vhd
  C:/Users/ccummi08/Desktop/Comp_4_Magnitude/Comp_4_Magnitude.srcs/sources_1/new/Comp_4.vhd
  C:/Users/ccummi08/Desktop/Comp_4_Magnitude/Comp_4_Magnitude.srcs/sources_1/new/BCD_LED.vhd
  C:/Users/ccummi08/Desktop/Comp_4_Magnitude/Comp_4_Magnitude.srcs/sources_1/new/Abs_4.vhd
  C:/Users/ccummi08/Desktop/Comp_4_Magnitude/Comp_4_Magnitude.srcs/sources_1/new/Comp_4_Magnitude.vhd
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/ccummi08/Desktop/Comp_4_Magnitude/Comp_4_Magnitude.srcs/constrs_1/new/Comp_4_Magnitude_constrs.xdc
set_property used_in_implementation false [get_files C:/Users/ccummi08/Desktop/Comp_4_Magnitude/Comp_4_Magnitude.srcs/constrs_1/new/Comp_4_Magnitude_constrs.xdc]


synth_design -top Comp_4_Magnitude -part xc7a35tcpg236-1


write_checkpoint -force -noxdef Comp_4_Magnitude.dcp

catch { report_utilization -file Comp_4_Magnitude_utilization_synth.rpt -pb Comp_4_Magnitude_utilization_synth.pb }
