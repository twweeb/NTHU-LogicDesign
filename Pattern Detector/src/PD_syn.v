/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Tue Apr 30 03:27:23 2019
/////////////////////////////////////////////////////////////


module DFF_n4 ( clk, init_out, next_out, out, rst_n );
  input [3:0] init_out;
  input [3:0] next_out;
  output [3:0] out;
  input clk, rst_n;
  wire   n10, n12, n14, n16, n1, n2, n3, n4, n5, n6, n7, n8, n9;

  DFFSRX1 \out_reg[2]  ( .D(next_out[2]), .CK(clk), .SN(n8), .RN(n3), .Q(
        out[2]) );
  DFFSRX1 \out_reg[3]  ( .D(next_out[3]), .CK(clk), .SN(n9), .RN(n4), .Q(
        out[3]) );
  DFFSRX1 \out_reg[1]  ( .D(next_out[1]), .CK(clk), .SN(n7), .RN(n2), .Q(
        out[1]) );
  DFFSRX1 \out_reg[0]  ( .D(next_out[0]), .CK(clk), .SN(n6), .RN(n1), .Q(
        out[0]) );
  CLKBUFX3 U3 ( .A(rst_n), .Y(n5) );
  CLKINVX1 U4 ( .A(n10), .Y(n6) );
  NOR2BX1 U5 ( .AN(init_out[0]), .B(n5), .Y(n10) );
  CLKINVX1 U6 ( .A(n12), .Y(n7) );
  NOR2BX1 U7 ( .AN(init_out[1]), .B(n5), .Y(n12) );
  CLKINVX1 U8 ( .A(n14), .Y(n8) );
  NOR2BX1 U9 ( .AN(init_out[2]), .B(n5), .Y(n14) );
  CLKINVX1 U10 ( .A(n16), .Y(n9) );
  NOR2BX1 U11 ( .AN(init_out[3]), .B(n5), .Y(n16) );
  OR2X1 U12 ( .A(n5), .B(init_out[0]), .Y(n1) );
  OR2X1 U13 ( .A(n5), .B(init_out[1]), .Y(n2) );
  OR2X1 U14 ( .A(n5), .B(init_out[2]), .Y(n3) );
  OR2X1 U15 ( .A(n5), .B(init_out[3]), .Y(n4) );
endmodule


module DFF_n10 ( clk, init_out, next_out, out, rst_n );
  input [9:0] init_out;
  input [9:0] next_out;
  output [9:0] out;
  input clk, rst_n;
  wire   n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n1, n2, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n23;

  DFFSRX1 \out_reg[9]  ( .D(next_out[9]), .CK(clk), .SN(n23), .RN(n10), .Q(
        out[9]) );
  DFFSRX1 \out_reg[8]  ( .D(next_out[8]), .CK(clk), .SN(n21), .RN(n9), .Q(
        out[8]) );
  DFFSRX1 \out_reg[7]  ( .D(next_out[7]), .CK(clk), .SN(n20), .RN(n8), .Q(
        out[7]) );
  DFFSRX1 \out_reg[5]  ( .D(next_out[5]), .CK(clk), .SN(n18), .RN(n6), .Q(
        out[5]) );
  DFFSRX1 \out_reg[6]  ( .D(next_out[6]), .CK(clk), .SN(n19), .RN(n7), .Q(
        out[6]) );
  DFFSRX1 \out_reg[4]  ( .D(next_out[4]), .CK(clk), .SN(n17), .RN(n5), .Q(
        out[4]) );
  DFFSRX1 \out_reg[3]  ( .D(next_out[3]), .CK(clk), .SN(n16), .RN(n4), .Q(
        out[3]) );
  DFFSRX1 \out_reg[2]  ( .D(next_out[2]), .CK(clk), .SN(n15), .RN(n3), .Q(
        out[2]) );
  DFFSRX1 \out_reg[1]  ( .D(next_out[1]), .CK(clk), .SN(n14), .RN(n2), .Q(
        out[1]) );
  DFFSRX1 \out_reg[0]  ( .D(next_out[0]), .CK(clk), .SN(n13), .RN(n1), .Q(
        out[0]) );
  CLKBUFX3 U3 ( .A(rst_n), .Y(n11) );
  CLKBUFX3 U4 ( .A(rst_n), .Y(n12) );
  CLKINVX1 U5 ( .A(n22), .Y(n13) );
  NOR2BX1 U6 ( .AN(init_out[0]), .B(n11), .Y(n22) );
  CLKINVX1 U7 ( .A(n24), .Y(n14) );
  NOR2BX1 U8 ( .AN(init_out[1]), .B(n11), .Y(n24) );
  CLKINVX1 U9 ( .A(n26), .Y(n15) );
  NOR2BX1 U10 ( .AN(init_out[2]), .B(n11), .Y(n26) );
  CLKINVX1 U11 ( .A(n38), .Y(n21) );
  NOR2BX1 U12 ( .AN(init_out[8]), .B(n11), .Y(n38) );
  CLKINVX1 U13 ( .A(n40), .Y(n23) );
  NOR2BX1 U14 ( .AN(init_out[9]), .B(n11), .Y(n40) );
  CLKINVX1 U15 ( .A(n28), .Y(n16) );
  NOR2BX1 U16 ( .AN(init_out[3]), .B(n12), .Y(n28) );
  CLKINVX1 U17 ( .A(n30), .Y(n17) );
  NOR2BX1 U18 ( .AN(init_out[4]), .B(n12), .Y(n30) );
  CLKINVX1 U19 ( .A(n32), .Y(n18) );
  NOR2BX1 U20 ( .AN(init_out[5]), .B(n12), .Y(n32) );
  CLKINVX1 U21 ( .A(n34), .Y(n19) );
  NOR2BX1 U22 ( .AN(init_out[6]), .B(n12), .Y(n34) );
  CLKINVX1 U23 ( .A(n36), .Y(n20) );
  NOR2BX1 U24 ( .AN(init_out[7]), .B(n12), .Y(n36) );
  OR2X1 U25 ( .A(n11), .B(init_out[0]), .Y(n1) );
  OR2X1 U26 ( .A(n11), .B(init_out[1]), .Y(n2) );
  OR2X1 U27 ( .A(n11), .B(init_out[2]), .Y(n3) );
  OR2X1 U28 ( .A(n11), .B(init_out[3]), .Y(n4) );
  OR2X1 U29 ( .A(n11), .B(init_out[4]), .Y(n5) );
  OR2X1 U30 ( .A(n11), .B(init_out[5]), .Y(n6) );
  OR2X1 U31 ( .A(n11), .B(init_out[6]), .Y(n7) );
  OR2X1 U32 ( .A(n11), .B(init_out[7]), .Y(n8) );
  OR2X1 U33 ( .A(n11), .B(init_out[8]), .Y(n9) );
  OR2X1 U34 ( .A(n11), .B(init_out[9]), .Y(n10) );
endmodule


module PD_DW01_inc_0 ( A, SUM );
  input [9:0] A;
  output [9:0] SUM;

  wire   [9:2] carry;

  ADDHXL U1_1_8 ( .A(A[8]), .B(carry[8]), .CO(carry[9]), .S(SUM[8]) );
  ADDHXL U1_1_7 ( .A(A[7]), .B(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  ADDHXL U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHXL U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHXL U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHXL U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHXL U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHXL U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  CLKINVX1 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[9]), .B(A[9]), .Y(SUM[9]) );
endmodule


module PD ( clk, rst_n, data, flag, addr, fin );
  input [9:0] data;
  output [9:0] addr;
  input clk, rst_n;
  output flag, fin;
  wire   N15, N16, N17, N18, N19, N20, N21, N22, N23, N24, N79, n11, n12, n13,
         n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27,
         n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n41, n42,
         n43, n44, n45, n46, n47;
  wire   [3:0] next_state;
  wire   [3:0] state;
  wire   [9:0] next_addr;
  wire   [9:0] length;

  DFF_n4 DFF1 ( .clk(clk), .init_out({1'b1, 1'b1, 1'b1, 1'b1}), .next_out(
        next_state), .out(state), .rst_n(rst_n) );
  DFF_n10 DFF2 ( .clk(clk), .init_out({1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 
        1'b1, 1'b1, 1'b1, 1'b1}), .next_out(next_addr), .out(addr), .rst_n(
        rst_n) );
  PD_DW01_inc_0 add_44 ( .A(addr), .SUM({N24, N23, N22, N21, N20, N19, N18, 
        N17, N16, N15}) );
  TLATX1 \length_reg[9]  ( .G(n41), .D(data[9]), .Q(length[9]) );
  TLATX1 \length_reg[8]  ( .G(N79), .D(data[8]), .Q(length[8]) );
  TLATX1 \length_reg[7]  ( .G(n41), .D(data[7]), .Q(length[7]) );
  TLATX1 \length_reg[5]  ( .G(n41), .D(data[5]), .Q(length[5]) );
  TLATX1 \length_reg[0]  ( .G(N79), .D(data[0]), .Q(length[0]) );
  TLATX1 \length_reg[6]  ( .G(N79), .D(data[6]), .Q(length[6]) );
  TLATX1 \length_reg[4]  ( .G(N79), .D(data[4]), .Q(length[4]) );
  TLATX1 \length_reg[3]  ( .G(n41), .D(data[3]), .Q(length[3]) );
  TLATX1 \length_reg[2]  ( .G(N79), .D(data[2]), .Q(length[2]) );
  TLATX1 \length_reg[1]  ( .G(n41), .D(data[1]), .Q(length[1]) );
  NOR2X1 U55 ( .A(n44), .B(n46), .Y(n26) );
  NAND2X1 U56 ( .A(n26), .B(n47), .Y(n16) );
  NOR2BX1 U57 ( .AN(N16), .B(N79), .Y(next_addr[1]) );
  NOR2BX1 U58 ( .AN(N17), .B(n41), .Y(next_addr[2]) );
  NOR2BX1 U59 ( .AN(N18), .B(N79), .Y(next_addr[3]) );
  NOR2BX1 U60 ( .AN(N19), .B(n41), .Y(next_addr[4]) );
  NOR2BX1 U61 ( .AN(N20), .B(N79), .Y(next_addr[5]) );
  NOR2BX1 U62 ( .AN(N21), .B(n41), .Y(next_addr[6]) );
  NOR2BX1 U63 ( .AN(N22), .B(N79), .Y(next_addr[7]) );
  NOR2BX1 U64 ( .AN(N23), .B(n41), .Y(next_addr[8]) );
  OR4X1 U65 ( .A(n11), .B(n12), .C(flag), .D(fin), .Y(next_state[3]) );
  CLKINVX1 U66 ( .A(n21), .Y(n45) );
  CLKINVX1 U67 ( .A(n11), .Y(n42) );
  NOR2BX1 U68 ( .AN(N24), .B(N79), .Y(next_addr[9]) );
  XNOR2X1 U69 ( .A(length[7]), .B(addr[7]), .Y(n35) );
  XNOR2X1 U70 ( .A(length[5]), .B(addr[5]), .Y(n36) );
  NOR4X1 U71 ( .A(n31), .B(n32), .C(n33), .D(n34), .Y(n30) );
  NAND2X1 U72 ( .A(n35), .B(n36), .Y(n31) );
  XOR2X1 U73 ( .A(length[3]), .B(addr[3]), .Y(n32) );
  XOR2X1 U74 ( .A(length[1]), .B(addr[1]), .Y(n33) );
  NAND3X1 U75 ( .A(n26), .B(n43), .C(state[0]), .Y(n22) );
  NOR2X1 U76 ( .A(state[2]), .B(data[0]), .Y(n21) );
  OAI33X1 U77 ( .A0(n44), .A1(state[0]), .A2(n43), .B0(n47), .B1(n26), .B2(n43), .Y(n11) );
  AND3X2 U78 ( .A(n26), .B(state[3]), .C(state[0]), .Y(n41) );
  AND3X2 U79 ( .A(n26), .B(state[3]), .C(state[0]), .Y(N79) );
  NOR3X1 U80 ( .A(n17), .B(state[0]), .C(n43), .Y(fin) );
  AND4X1 U81 ( .A(n27), .B(n28), .C(n29), .D(n30), .Y(n12) );
  XNOR2X1 U82 ( .A(length[9]), .B(addr[9]), .Y(n27) );
  XNOR2X1 U83 ( .A(length[8]), .B(addr[8]), .Y(n28) );
  NOR3X1 U84 ( .A(n37), .B(n38), .C(n39), .Y(n29) );
  CLKINVX1 U85 ( .A(state[0]), .Y(n47) );
  NAND2X1 U86 ( .A(state[1]), .B(n44), .Y(n17) );
  XOR2X1 U87 ( .A(length[4]), .B(addr[4]), .Y(n34) );
  NOR2X1 U88 ( .A(n22), .B(data[0]), .Y(flag) );
  CLKINVX1 U89 ( .A(state[1]), .Y(n46) );
  XOR2X1 U90 ( .A(length[2]), .B(addr[2]), .Y(n37) );
  XOR2X1 U91 ( .A(length[0]), .B(addr[0]), .Y(n38) );
  XOR2X1 U92 ( .A(length[6]), .B(addr[6]), .Y(n39) );
  CLKINVX1 U93 ( .A(state[3]), .Y(n43) );
  CLKINVX1 U94 ( .A(state[2]), .Y(n44) );
  AOI2BB1X1 U95 ( .A0N(n13), .A1N(n14), .B0(n12), .Y(next_state[2]) );
  OAI31XL U96 ( .A0(n44), .A1(state[1]), .A2(n15), .B0(n16), .Y(n13) );
  OAI31XL U97 ( .A0(n45), .A1(n46), .A2(n47), .B0(n42), .Y(n14) );
  XNOR2X1 U98 ( .A(data[0]), .B(state[0]), .Y(n15) );
  NOR2BX1 U99 ( .AN(N15), .B(n41), .Y(next_addr[0]) );
  NOR2X1 U100 ( .A(n12), .B(n23), .Y(next_state[0]) );
  AOI211X1 U101 ( .A0(data[0]), .A1(n24), .B0(n11), .C0(n25), .Y(n23) );
  NOR4X1 U102 ( .A(state[3]), .B(state[0]), .C(n46), .D(n45), .Y(n25) );
  OAI221XL U103 ( .A0(n17), .A1(n47), .B0(state[1]), .B1(state[0]), .C0(n16), 
        .Y(n24) );
  OAI211X1 U104 ( .A0(state[0]), .A1(n17), .B0(n42), .C0(n18), .Y(
        next_state[1]) );
  AOI211X1 U105 ( .A0(data[0]), .A1(n19), .B0(n12), .C0(n20), .Y(n18) );
  NOR3X1 U106 ( .A(n47), .B(state[1]), .C(n21), .Y(n20) );
  NAND2X1 U107 ( .A(n16), .B(n22), .Y(n19) );
endmodule

