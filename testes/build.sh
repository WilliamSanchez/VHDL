TOP_MODULE="src/teste.vhd"
DEVICE="xc6slx16-2-ftg256" #"xc3s250e-ft256-4" # 

#Set up Xilinx environment
source /opt/Xilinx/14.7/ISE_DS/settings64.sh

if [ -d "output" ]; then
    rm -rf output
fi
mkdir output

xflow -wd ./output -p "$DEVICE" -synth xst_vhdl -implement balanced -config bitgen $TOP_MODULE

echo "Bitstream genration complete: $TOP_MODULE_par.bit"


# Command Line: xst -intstyle ise -ifn "/home/william/Documents/Embedded_Systems/FPGA/code/teste/teste.xst" -ofn "/home/william/Documents/Embedded_Systems/FPGA/code/teste/teste.syr"


# Command Line: ngdbuild -intstyle ise -dd _ngo -nt timestamp -uc netlist.ucf -p xc6slx16-ftg256-2 teste.ngc teste.ngd
# Command Line: /opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/unwrapped/ngdbuild -intstyle
#               ise -dd _ngo -nt timestamp -uc netlist.ucf -p xc6slx16-ftg256-2 teste.ngc
#               teste.ngd


# Command Line: bitgen -intstyle ise -f teste.ut teste.ncd

#Release 14.7 - Xflow P.20131013 (lin64)
#Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
#Usage: xflow [-p <partname>] [-filter <filter_file_name>] [-implement
#<option_file[.opt]>] [-fit <option_file[.opt]>] [-config <option_file[.opt]>]
#[-tsim <option_file[.opt]>] [-fsim <option_file[.opt]>] [-ecn
#<option_file[.opt]>] [-sta <option_file[.opt]>] [-wd <work_dir>] [-ed
#<export_dir>] [-rd <report_dir>] [-o <output_file>] [-log <log_file>] {-g
#<setting_value>} [-synth <option_file[.opt]>] [-initial <option_file[.opt]>]
#[-module <option_file[.opt]>] [-active <module_name>] [-assemble
#<option_file[.opt]>] [-pd <pim_dir>] [-norun] <design_name>
#
#   -p           : Xilinx Part to use. Example: xcv300-4-pq240
#
#   -filter      : Message Filter file name (for example "filter.filter").
#                  If specified, the contents of this file will be used to
#                  filter messages from this application. The filter file
#                  can be created using Xreport.
#                  If file does not exist, the switch will be ignored
#
#   -implement   : Option File for FPGA implementation phase
#                  Available Option Files: 
#                  fast_runtime.opt balanced.opt high_effort.opt
#                  Default: fast_runtime.opt
#
#   -fit         : Option File for CPLD implementation phase
#                  Available Option Files: 
#                  balanced.opt  speed.opt  density.opt
#                  Default: balanced.opt
#
#   -config      : Option File for FPGA configuration phase 
#                  Available Option Files: bitgen.opt 
#
#   -tsim        : Option File for FPGA/CPLD Timing Simulation phase 
#   -fsim        : Option File for FPGA/CPLD Functional Simulation phase 
#                  -tsim and -fsim switches share the same option files. 
#                  Available Option Files: 
#
#                  generic_verilog.opt       generic_vhdl.opt
#                  modelsim_verilog.opt      modelsim_vhdl.opt
#                  nc_verilog.opt            nc_vhdl.opt
#                  scirocco_vhdl.opt
#                  verilog_xl.opt
#                  vcs_verilog.opt 
#
#   -ecn        : Option File for FPGA Equivalence Checking phase 
#                  Available Option Files: 
#
#                  conformal_verilog.opt     formality_verilog.opt
#
#   -sta        : Option File for FPGA Static Timing Analysis phase 
#                  Available Option Files: 
#
#                  primetime_verilog.opt    
#
#   -synth       : Option File for FPGA/CPLD Synthesis phase 
#                  Available Option File: 
#                  xst_verilog.opt               xst_vhdl.opt
#                  synplicity_verilog.opt        synplicity_vhdl.opt
#
#   -wd          : Working Directory. 
#                  Default: Current Directory
#
#   -ed          : Export Directory for program outputs 
#                  Default: Working Directory
#
#   -rd          : Report Directory for program reports 
#                  Default: Working Directory
#
#   -o           : Change output file base name to <outputfile> 
#
#   -log         : Specify log filename <log_file> 
#                  Default: xflow.log
#
#   -norun       : Create/Test flow and option files and stop 
#
#   -f <cmdfile> : Read command line arguments from <cmdfile>
#
#   -g <var:val> : Set variable to value
#
#  <design_name> : Design Name with or without extension.
#                  If no extension is specified, netlist is assumed
#
#The following switches are intended for Modular Design:
#
#   -initial     : Perform Initial Budgeting using <option_file>
#                  Available Option Files: budget.opt
#
#   -module      : Perform Active Implementation using <option_file>
#                  Available Option Files: 
#                  fast_runtime.opt balanced.opt high_effort.opt
#
#   -active      : Specify active <module_name> 
#                  This switch should be used along with -module.
#                  Example: 
#                  xflow -module balanced -active <module_name> <design_name>
#
#   -assemble    : Perform Final Assembly using <option_file> 
#                  Available Option Files: 
#                  fast_runtime.opt balanced.opt high_effort.opt
#                  Example: 
#                  xflow -assemble balanced -pd <pim_dir> <design_name>
#
#   -pd          : Specify the Pims directory <pim_dir>
#                  This switch should be used along with -assemble. 
#                  Default: Working Directory.
