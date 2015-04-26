@echo off
if not exist build md build
tools\pBlazASM.exe -v -3 -cbuild\%~nx1.mem -sbuild\%~nx1_data.mem -lbuild\%~nx1.lst %~nx1
tools\pBlazMRG.exe -v -cbuild\%~nx1.mem -ttools\ROM_form.vhd -einstruction_mem hw\instruction_mem.vhd
pause
