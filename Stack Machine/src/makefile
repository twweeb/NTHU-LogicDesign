HEAD	=header.v

VLOG	=ncverilog

BON =SM.v\
     SM_tb.v

BON_syn	=SM_syn.v\
		 SM_tb.v\
		 -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v

SRC		=SM.v\
		 SM_tb.v

SRC_syn	=SM_syn.v\
		 SM_tb.v\
		 -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v

SDF		=+define+SDF

TMPFILE	=*.log\
		 INCA_libs

RM		=-rm -rf

VLOGARG =+access+r\

TEST1 =+define+TEST1
TEST2 =+define+TEST2
TEST3 =+define+TEST3
BON_def =+define+BON



all :: sim
sim1:
	$(VLOG) $(HEAD) $(SRC) $(TEST1) $(VLOGARG)
sim2:
	$(VLOG) $(HEAD) $(SRC) $(TEST2) $(VLOGARG)
sim3:
	$(VLOG) $(HEAD) $(SRC) $(TEST3) $(VLOGARG)
syn1:
	$(VLOG) $(HEAD) $(SRC_syn) $(SDF) $(TEST1) $(VLOGARG)
syn2:
	$(VLOG) $(HEAD) $(SRC_syn) $(SDF) $(TEST2) $(VLOGARG)
syn3:
	$(VLOG) $(HEAD) $(SRC_syn) $(SDF) $(TEST3) $(VLOGARG)
bon:
	$(VLOG) $(HEAD) $(BON) $(VLOGARG)
bon_syn:
	$(VLOG) $(HEAD) $(BON_syn) $(SDF) $(BON_def) $(VLOGARG)
check:
	$(VLOG) -c $(SRC)
clean:
	$(RM) $(TMPFILE)
