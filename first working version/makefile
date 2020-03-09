
DIRS=+incdir+${PWD}/agent \
     +incdir+${PWD}/env \
	+incdir+${PWD}/test \
	+incdir+${PWD}/interface \
	+incdir+${PWD}/rtl \
	+incdir+${PWD}/top \
	+incdir+${PWD}/tb \


compile :
	mkdir -p work 
	qrsh -V -cwd -verbose vlogan -full64 -sverilog -ntb_opts uvm-1.2 +define+SYNOPSYS -l uvm_compile.log 
	qrsh -V -cwd -verbose vlogan -full64 -sverilog -ntb_opts uvm-1.2 +define+SYNOPSYS -timescale=1ns/1ps +define+SYNOPSYS ${DIRS} -f list.f -w work -l compile.log

elab :
	qrsh -V -cwd -verbose -q medium vcs -licqueue -full64 -debug_all -ntb_opts uvm-1.2 -timescale=1ns/1ps tb -l elab.log

sim :   elab
	qrsh -V -cwd -verbose  ./simv -full64 +vpdfile+ish.vpd -do run.do +define+SYNOPSYS -ucli tb -l sim.log
#+vpdfilepluslab02.vpd

clean :
	rm -rf *.log work simv.daidir ucli.key ./simv AN.DB csrc *.vpd vc_hdrs.h transcript
