# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/Cole/FULL_FT_CNTR/FULL_FT_CNTR.cache/wt [current_project]
set_property parent.project_path C:/Users/Cole/FULL_FT_CNTR/FULL_FT_CNTR.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/Cole/FULL_FT_CNTR/FULL_FT_CNTR.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  C:/Users/Cole/FULL_FT_CNTR/FULL_FT_CNTR.srcs/sources_1/new/FSM_CNTR.vhd
  C:/Users/Cole/FULL_FT_CNTR/FULL_FT_CNTR.srcs/sources_1/new/clk_div_fs.vhd
  C:/Users/Cole/FULL_FT_CNTR/FULL_FT_CNTR.srcs/sources_1/new/FULL_FT_CNTR.vhd
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/Cole/FULL_FT_CNTR/FULL_FT_CNTR.srcs/constrs_1/new/FULL_FT_CNTR_constr.xdc
set_property used_in_implementation false [get_files C:/Users/Cole/FULL_FT_CNTR/FULL_FT_CNTR.srcs/constrs_1/new/FULL_FT_CNTR_constr.xdc]


synth_design -top FULL_FT_CNTR -part xc7a35tcpg236-1


write_checkpoint -force -noxdef FULL_FT_CNTR.dcp

catch { report_utilization -file FULL_FT_CNTR_utilization_synth.rpt -pb FULL_FT_CNTR_utilization_synth.pb }
