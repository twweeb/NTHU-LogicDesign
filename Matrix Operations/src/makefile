HEAD	=header.v

VLOG	=ncverilog

SRC		=MO.v\
		 MO_tb.v
BON =SA.v\
     SA_tb.v
     
BON_syn	=SA_syn.v\
		 SA_tb.v\
		 -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v

SRC_syn	=MO_syn.v\
		 MO_tb.v\
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
check:
	$(VLOG) -c $(SRC)
clean:
	$(RM) $(TMPFILE)
 
bon:
	$(VLOG) $(HEAD) $(BON) $(VLOGARG)

bon_syn:
	$(VLOG) $(HEAD) $(BON_syn) $(SDF) $(VLOGARG)