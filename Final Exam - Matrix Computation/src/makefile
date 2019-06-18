HEAD	=header.v

VLOG	=ncverilog

SRC		=Final.v\
		 Final_tb.v

SRC_syn	=Final_syn.v\
		 Final_tb.v\
		 -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v

SDF		=+define+SDF

TMPFILE	=*.log\
		 INCA_libs

RM		=-rm -rf

VLOGARG =+access+r\

CASE1		=+define+CASE1

TEST1 		=+define+TEST1
TEST2 		=+define+TEST2
TEST3 		=+define+TEST3

all :: sim
sim1_1:
	$(VLOG) $(HEAD) $(SRC) $(TEST1) $(VLOGARG)$(CASE1)
sim1_2:
	$(VLOG) $(HEAD) $(SRC) $(TEST1) $(VLOGARG)
sim2_1:
	$(VLOG) $(HEAD) $(SRC) $(TEST2) $(VLOGARG)$(CASE1)
sim2_2:
	$(VLOG) $(HEAD) $(SRC) $(TEST2) $(VLOGARG)
sim3_1:
	$(VLOG) $(HEAD) $(SRC) $(TEST3) $(VLOGARG)$(CASE1)
sim3_2:
	$(VLOG) $(HEAD) $(SRC) $(TEST3) $(VLOGARG)
syn1_1:
	$(VLOG) $(HEAD) $(SRC_syn) $(SDF) $(TEST1) $(VLOGARG)$(CASE1)
syn1_2:
	$(VLOG) $(HEAD) $(SRC_syn) $(SDF) $(TEST1) $(VLOGARG)
syn2_1:
	$(VLOG) $(HEAD) $(SRC_syn) $(SDF) $(TEST2) $(VLOGARG)$(CASE1)
syn2_2:
	$(VLOG) $(HEAD) $(SRC_syn) $(SDF) $(TEST2) $(VLOGARG)
syn3_1:
	$(VLOG) $(HEAD) $(SRC_syn) $(SDF) $(TEST3) $(VLOGARG)$(CASE1)
syn3_2:
	$(VLOG) $(HEAD) $(SRC_syn) $(SDF) $(TEST3) $(VLOGARG)
check:
	$(VLOG) -c $(SRC)
clean:
	$(RM) $(TMPFILE)