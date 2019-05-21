HEAD	=header.v

VLOG	=ncverilog

SRC		=PD.v\
		 PD_tb.v

SRC_syn	=PD_syn.v\
		 PD_tb.v\
		 -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v
SRC_bon =LPD.v\
		 LPD_tb.v
SRC_bon_syn = LPD_syn.v\
			  LPD_tb.v\
   			  -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v
SDF		=+define+SDF

TMPFILE	=*.log\
		 INCA_libs

RM		=-rm -rf

VLOGARG =+access+r\

all :: sim
sim:
	$(VLOG) $(HEAD) $(SRC) $(VLOGARG)
syn:
	$(VLOG) $(HEAD) $(SRC_syn) $(SDF) $(VLOGARG)
bon:
	$(VLOG) $(HEAD) $(SRC_bon) $(VLOGARG)
bon_syn:
	$(VLOG) $(HEAD) $(SRC_bon_syn) $(SDF) $(VLOGARG)
check:
	$(VLOG) -c $(SRC)
clean:
	$(RM) $(TMPFILE)
