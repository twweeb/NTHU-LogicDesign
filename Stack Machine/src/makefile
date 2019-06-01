HEAD	=header.v

VLOG	=ncverilog

SRC		=SM.v\
		 SM_tb.v

SRC_syn	=SM_syn.v\
		 SM_tb.v\
		 -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v

SDF		=+define+SDF

BON     =+define+BON

TMPFILE	=*.log\
		 INCA_libs

RM		=-rm -rf

VLOGARG =+access+r

all :: sim
sim:
	$(VLOG) $(HEAD) $(SRC) $(VLOGARG)
syn:
	$(VLOG) $(HEAD) $(SRC_syn) $(SDF) $(VLOGARG)
bon:
	$(VLOG) $(HEAD) $(SRC) $(BON) $(VLOGARG)
bon_syn:
	$(VLOG) $(HEAD) $(SRC_syn) $(BON) $(SDF) $(VLOGARG)
check:
	$(VLOG) -c $(SRC)
clean:
	$(RM) $(TMPFILE)
