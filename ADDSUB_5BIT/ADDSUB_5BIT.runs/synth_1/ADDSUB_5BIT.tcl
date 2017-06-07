# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/Cole/ADDSUB_5BIT/ADDSUB_5BIT.cache/wt [current_project]
set_property parent.project_path C:/Users/Cole/ADDSUB_5BIT/ADDSUB_5BIT.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/Cole/ADDSUB_5BIT/ADDSUB_5BIT.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  C:/Users/Cole/ADDSUB_5BIT/ADDSUB_5BIT.srcs/sources_1/new/RCA_8bit.vhd
  C:/Users/Cole/ADDSUB_5BIT/ADDSUB_5BIT.srcs/sources_1/new/sseg_dec.vhd
  C:/Users/Cole/ADDSUB_5BIT/ADDSUB_5BIT.srcs/sources_1/new/ADDSUB_5BIT.vhd
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/Cole/ADDSUB_5BIT/ADDSUB_5BIT.srcs/constrs_1/new/ADDSUB_5BIT_constrs.xdc
set_property used_in_implementation false [get_files C:/Users/Cole/ADDSUB_5BIT/ADDSUB_5BIT.srcs/constrs_1/new/ADDSUB_5BIT_constrs.xdc]


synth_design -top ADDSUB_5BIT -part xc7a35tcpg236-1


write_checkpoint -force -noxdef ADDSUB_5BIT.dcp

catch { report_utilization -file ADDSUB_5BIT_utilization_synth.rpt -pb ADDSUB_5BIT_utilization_synth.pb }
