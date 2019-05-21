/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Tue Apr 30 03:22:25 2019
/////////////////////////////////////////////////////////////


module DFF_n4_0 ( clk, init_out, next_out, out, rst_n );
  input [3:0] init_out;
  input [3:0] next_out;
  output [3:0] out;
  input clk, rst_n;
  wire   n10, n12, n14, n16, n1, n2, n3, n4, n5, n6, n7, n8, n9;

  DFFSRX1 \out_reg[2]  ( .D(next_out[2]), .CK(clk), .SN(n7), .RN(n3), .Q(
        out[2]) );
  DFFSRX1 \out_reg[1]  ( .D(next_out[1]), .CK(clk), .SN(n6), .RN(n2), .Q(
        out[1]) );
  DFFSRX1 \out_reg[3]  ( .D(next_out[3]), .CK(clk), .SN(n8), .RN(n4), .Q(
        out[3]) );
  DFFSRX1 \out_reg[0]  ( .D(next_out[0]), .CK(clk), .SN(n9), .RN(n1), .Q(
        out[0]) );
  CLKBUFX3 U3 ( .A(rst_n), .Y(n5) );
  CLKINVX1 U4 ( .A(n10), .Y(n9) );
  NOR2BX1 U5 ( .AN(init_out[0]), .B(n5), .Y(n10) );
  CLKINVX1 U6 ( .A(n12), .Y(n6) );
  NOR2BX1 U7 ( .AN(init_out[1]), .B(n5), .Y(n12) );
  CLKINVX1 U8 ( .A(n14), .Y(n7) );
  NOR2BX1 U9 ( .AN(init_out[2]), .B(n5), .Y(n14) );
  CLKINVX1 U10 ( .A(n16), .Y(n8) );
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
  CLKINVX1 U11 ( .A(n28), .Y(n16) );
  NOR2BX1 U12 ( .AN(init_out[3]), .B(n11), .Y(n28) );
  CLKINVX1 U13 ( .A(n40), .Y(n23) );
  NOR2BX1 U14 ( .AN(init_out[9]), .B(n11), .Y(n40) );
  CLKINVX1 U15 ( .A(n30), .Y(n17) );
  NOR2BX1 U16 ( .AN(init_out[4]), .B(n12), .Y(n30) );
  CLKINVX1 U17 ( .A(n32), .Y(n18) );
  NOR2BX1 U18 ( .AN(init_out[5]), .B(n12), .Y(n32) );
  CLKINVX1 U19 ( .A(n34), .Y(n19) );
  NOR2BX1 U20 ( .AN(init_out[6]), .B(n12), .Y(n34) );
  CLKINVX1 U21 ( .A(n36), .Y(n20) );
  NOR2BX1 U22 ( .AN(init_out[7]), .B(n12), .Y(n36) );
  CLKINVX1 U23 ( .A(n38), .Y(n21) );
  NOR2BX1 U24 ( .AN(init_out[8]), .B(n12), .Y(n38) );
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


module DFF_n4_2 ( clk, init_out, next_out, out, rst_n );
  input [3:0] init_out;
  input [3:0] next_out;
  output [3:0] out;
  input clk, rst_n;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n11, n13, n14, n15;

  DFFSRX1 \out_reg[3]  ( .D(next_out[3]), .CK(clk), .SN(n9), .RN(n4), .Q(
        out[3]) );
  DFFSRX1 \out_reg[2]  ( .D(next_out[2]), .CK(clk), .SN(n8), .RN(n3), .Q(
        out[2]) );
  DFFSRX1 \out_reg[1]  ( .D(next_out[1]), .CK(clk), .SN(n7), .RN(n2), .Q(
        out[1]) );
  DFFSRX1 \out_reg[0]  ( .D(next_out[0]), .CK(clk), .SN(n6), .RN(n1), .Q(
        out[0]) );
  CLKBUFX3 U3 ( .A(rst_n), .Y(n5) );
  CLKINVX1 U4 ( .A(n15), .Y(n6) );
  NOR2BX1 U5 ( .AN(init_out[0]), .B(n5), .Y(n15) );
  CLKINVX1 U6 ( .A(n14), .Y(n7) );
  NOR2BX1 U7 ( .AN(init_out[1]), .B(n5), .Y(n14) );
  CLKINVX1 U8 ( .A(n13), .Y(n8) );
  NOR2BX1 U9 ( .AN(init_out[2]), .B(n5), .Y(n13) );
  CLKINVX1 U10 ( .A(n11), .Y(n9) );
  NOR2BX1 U11 ( .AN(init_out[3]), .B(n5), .Y(n11) );
  OR2X1 U12 ( .A(n5), .B(init_out[0]), .Y(n1) );
  OR2X1 U13 ( .A(n5), .B(init_out[1]), .Y(n2) );
  OR2X1 U14 ( .A(n5), .B(init_out[2]), .Y(n3) );
  OR2X1 U15 ( .A(n5), .B(init_out[3]), .Y(n4) );
endmodule


module DFF_n4_1 ( clk, init_out, next_out, out, rst_n );
  input [3:0] init_out;
  input [3:0] next_out;
  output [3:0] out;
  input clk, rst_n;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n11, n13, n14, n15;

  DFFSRX1 \out_reg[3]  ( .D(next_out[3]), .CK(clk), .SN(n9), .RN(n4), .Q(
        out[3]) );
  DFFSRX1 \out_reg[1]  ( .D(next_out[1]), .CK(clk), .SN(n7), .RN(n2), .Q(
        out[1]) );
  DFFSRX1 \out_reg[2]  ( .D(next_out[2]), .CK(clk), .SN(n8), .RN(n3), .Q(
        out[2]) );
  DFFSRX1 \out_reg[0]  ( .D(next_out[0]), .CK(clk), .SN(n6), .RN(n1), .Q(
        out[0]) );
  CLKBUFX3 U3 ( .A(rst_n), .Y(n5) );
  CLKINVX1 U4 ( .A(n15), .Y(n6) );
  NOR2BX1 U5 ( .AN(init_out[0]), .B(n5), .Y(n15) );
  CLKINVX1 U6 ( .A(n14), .Y(n7) );
  NOR2BX1 U7 ( .AN(init_out[1]), .B(n5), .Y(n14) );
  CLKINVX1 U8 ( .A(n13), .Y(n8) );
  NOR2BX1 U9 ( .AN(init_out[2]), .B(n5), .Y(n13) );
  CLKINVX1 U10 ( .A(n11), .Y(n9) );
  NOR2BX1 U11 ( .AN(init_out[3]), .B(n5), .Y(n11) );
  OR2X1 U12 ( .A(n5), .B(init_out[0]), .Y(n1) );
  OR2X1 U13 ( .A(n5), .B(init_out[1]), .Y(n2) );
  OR2X1 U14 ( .A(n5), .B(init_out[2]), .Y(n3) );
  OR2X1 U15 ( .A(n5), .B(init_out[3]), .Y(n4) );
endmodule


module LPD_DW01_inc_0 ( A, SUM );
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


module LPD ( clk, rst_n, data, flag, addr, fin, count );
  input [9:0] data;
  output [9:0] addr;
  output [3:0] count;
  input clk, rst_n;
  output flag, fin;
  wire   N21, N22, N23, N24, N25, N26, N27, N28, N29, N30, N104, N107, n22,
         n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36,
         n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50,
         n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64,
         n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78,
         n79, n80, n81, n83, n84, n85, n86, n87, n88, n89, n90;
  wire   [3:0] next_state;
  wire   [3:0] state;
  wire   [9:0] next_addr;
  wire   [3:0] next_cnt;
  wire   [3:0] cnt;
  wire   [3:0] next_total;
  wire   [3:0] total;
  wire   [9:0] length;
  assign fin = N107;

  DFF_n4_0 DFF1 ( .clk(clk), .init_out({1'b1, 1'b1, 1'b1, 1'b0}), .next_out(
        next_state), .out(state), .rst_n(rst_n) );
  DFF_n10 DFF2 ( .clk(clk), .init_out({1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 
        1'b1, 1'b1, 1'b1, 1'b1}), .next_out(next_addr), .out(addr), .rst_n(
        rst_n) );
  DFF_n4_2 DFF3 ( .clk(clk), .init_out({1'b0, 1'b0, 1'b0, 1'b0}), .next_out(
        next_cnt), .out(cnt), .rst_n(rst_n) );
  DFF_n4_1 DFF4 ( .clk(clk), .init_out({1'b0, 1'b0, 1'b0, 1'b0}), .next_out(
        next_total), .out(total), .rst_n(rst_n) );
  LPD_DW01_inc_0 add_54 ( .A(addr), .SUM({N30, N29, N28, N27, N26, N25, N24, 
        N23, N22, N21}) );
  TLATX1 \length_reg[7]  ( .G(n72), .D(data[7]), .Q(length[7]) );
  TLATX1 \length_reg[5]  ( .G(n72), .D(data[5]), .Q(length[5]) );
  TLATX1 \length_reg[8]  ( .G(n73), .D(data[8]), .Q(length[8]) );
  TLATX1 \length_reg[9]  ( .G(N104), .D(data[9]), .Q(length[9]) );
  TLATX1 \length_reg[0]  ( .G(n72), .D(data[0]), .Q(length[0]) );
  TLATX1 \length_reg[4]  ( .G(n72), .D(data[4]), .Q(length[4]) );
  TLATX1 \length_reg[1]  ( .G(n72), .D(data[1]), .Q(length[1]) );
  TLATX1 \length_reg[6]  ( .G(N104), .D(data[6]), .Q(length[6]) );
  TLATX1 \length_reg[3]  ( .G(N104), .D(data[3]), .Q(length[3]) );
  TLATX1 \length_reg[2]  ( .G(N104), .D(data[2]), .Q(length[2]) );
  CLKINVX1 U98 ( .A(state[2]), .Y(n87) );
  CLKINVX1 U99 ( .A(n49), .Y(n85) );
  CLKINVX1 U100 ( .A(N107), .Y(n81) );
  CLKINVX1 U101 ( .A(n71), .Y(flag) );
  AND4X1 U102 ( .A(n34), .B(n49), .C(n68), .D(n69), .Y(n67) );
  NOR2X1 U103 ( .A(N107), .B(n25), .Y(n68) );
  NOR3BX1 U104 ( .AN(n45), .B(n87), .C(n80), .Y(n72) );
  NOR3BX1 U105 ( .AN(n45), .B(n87), .C(n80), .Y(n73) );
  NOR3BX1 U106 ( .AN(n45), .B(n87), .C(n80), .Y(N104) );
  NOR3X1 U107 ( .A(n88), .B(n89), .C(n47), .Y(n33) );
  NOR2X1 U108 ( .A(n44), .B(n87), .Y(N107) );
  NOR2BX1 U109 ( .AN(n45), .B(n47), .Y(n28) );
  NAND2X1 U110 ( .A(n45), .B(n70), .Y(n32) );
  NAND3X1 U111 ( .A(n89), .B(n88), .C(n70), .Y(n49) );
  NAND2X1 U112 ( .A(n83), .B(n90), .Y(n71) );
  NOR2X1 U113 ( .A(n78), .B(n24), .Y(n23) );
  NAND2X1 U114 ( .A(n87), .B(n80), .Y(n47) );
  NOR2BX1 U115 ( .AN(N23), .B(n72), .Y(next_addr[2]) );
  NOR2BX1 U116 ( .AN(N26), .B(n72), .Y(next_addr[5]) );
  NOR2BX1 U117 ( .AN(N29), .B(n72), .Y(next_addr[8]) );
  NOR2BX1 U118 ( .AN(N24), .B(n73), .Y(next_addr[3]) );
  NOR2BX1 U119 ( .AN(N27), .B(n73), .Y(next_addr[6]) );
  NOR2BX1 U120 ( .AN(N22), .B(N104), .Y(next_addr[1]) );
  NOR2BX1 U121 ( .AN(N25), .B(N104), .Y(next_addr[4]) );
  NOR2BX1 U122 ( .AN(N28), .B(N104), .Y(next_addr[7]) );
  NOR2BX1 U123 ( .AN(n46), .B(n89), .Y(n29) );
  CLKINVX1 U124 ( .A(n69), .Y(n83) );
  XOR2X1 U125 ( .A(n78), .B(n24), .Y(next_total[1]) );
  CLKINVX1 U126 ( .A(n38), .Y(n86) );
  OAI22XL U127 ( .A0(n78), .A1(n81), .B0(n76), .B1(n71), .Y(count[1]) );
  NOR2BX1 U128 ( .AN(n46), .B(state[0]), .Y(n25) );
  NOR3X1 U129 ( .A(state[1]), .B(state[2]), .C(n80), .Y(n46) );
  CLKINVX1 U130 ( .A(state[3]), .Y(n80) );
  OA21XL U131 ( .A0(cnt[1]), .A1(n32), .B0(n66), .Y(n65) );
  NOR2BX1 U132 ( .AN(N30), .B(n73), .Y(next_addr[9]) );
  OA21XL U133 ( .A0(cnt[0]), .A1(n32), .B0(n67), .Y(n66) );
  OAI32X1 U134 ( .A0(n75), .A1(cnt[3]), .A2(n63), .B0(n64), .B1(n74), .Y(
        next_cnt[3]) );
  CLKINVX1 U135 ( .A(cnt[3]), .Y(n74) );
  OA21XL U136 ( .A0(cnt[2]), .A1(n32), .B0(n65), .Y(n64) );
  NOR4X1 U137 ( .A(n54), .B(n55), .C(n56), .D(n57), .Y(n53) );
  NAND2X1 U138 ( .A(n58), .B(n59), .Y(n54) );
  XOR2X1 U139 ( .A(length[3]), .B(addr[3]), .Y(n55) );
  XOR2X1 U140 ( .A(length[1]), .B(addr[1]), .Y(n56) );
  XNOR2X1 U141 ( .A(length[7]), .B(addr[7]), .Y(n58) );
  XNOR2X1 U142 ( .A(length[5]), .B(addr[5]), .Y(n59) );
  NAND3X1 U143 ( .A(n70), .B(n88), .C(state[0]), .Y(n34) );
  NOR2X1 U144 ( .A(n87), .B(state[3]), .Y(n70) );
  NOR2X1 U145 ( .A(n88), .B(state[0]), .Y(n45) );
  XNOR2X1 U146 ( .A(total[3]), .B(n22), .Y(next_total[3]) );
  NAND2X1 U147 ( .A(total[2]), .B(n23), .Y(n22) );
  OAI22XL U148 ( .A0(n65), .A1(n75), .B0(cnt[2]), .B1(n63), .Y(next_cnt[2]) );
  OAI22XL U149 ( .A0(cnt[0]), .A1(n32), .B0(n67), .B1(n77), .Y(next_cnt[0]) );
  NAND3X1 U150 ( .A(state[0]), .B(n70), .C(state[1]), .Y(n69) );
  NAND3X1 U151 ( .A(state[3]), .B(n87), .C(n45), .Y(n38) );
  NAND3X1 U152 ( .A(state[0]), .B(state[3]), .C(state[1]), .Y(n44) );
  NAND4X1 U153 ( .A(n50), .B(n51), .C(n52), .D(n53), .Y(n41) );
  XNOR2X1 U154 ( .A(length[9]), .B(addr[9]), .Y(n50) );
  XNOR2X1 U155 ( .A(length[8]), .B(addr[8]), .Y(n51) );
  NOR3X1 U156 ( .A(n60), .B(n61), .C(n62), .Y(n52) );
  CLKINVX1 U157 ( .A(state[1]), .Y(n88) );
  NAND3BX1 U158 ( .AN(n32), .B(cnt[0]), .C(cnt[1]), .Y(n63) );
  OAI21XL U159 ( .A0(data[0]), .A1(n44), .B0(n38), .Y(n26) );
  NAND4BX1 U160 ( .AN(n28), .B(n41), .C(n81), .D(n42), .Y(next_state[0]) );
  AOI221XL U161 ( .A0(data[0]), .A1(n43), .B0(n29), .B1(n90), .C0(n26), .Y(n42) );
  OAI211X1 U162 ( .A0(state[0]), .A1(n47), .B0(n32), .C0(n48), .Y(n43) );
  NOR3X1 U163 ( .A(n85), .B(n33), .C(n25), .Y(n48) );
  NAND4X1 U164 ( .A(n79), .B(n35), .C(n36), .D(n34), .Y(next_state[1]) );
  NAND2X1 U165 ( .A(n28), .B(n90), .Y(n35) );
  OAI31XL U166 ( .A0(n37), .A1(n83), .A2(n86), .B0(data[0]), .Y(n36) );
  OAI21XL U167 ( .A0(state[1]), .A1(n89), .B0(n32), .Y(n37) );
  NAND2X1 U168 ( .A(total[0]), .B(n25), .Y(n24) );
  NAND4X1 U169 ( .A(n79), .B(n30), .C(n31), .D(n32), .Y(next_state[2]) );
  NAND2X1 U170 ( .A(n85), .B(data[0]), .Y(n30) );
  OAI21XL U171 ( .A0(n33), .A1(n84), .B0(n90), .Y(n31) );
  CLKINVX1 U172 ( .A(n34), .Y(n84) );
  CLKINVX1 U173 ( .A(state[0]), .Y(n89) );
  NAND3BX1 U174 ( .AN(n26), .B(n79), .C(n27), .Y(next_state[3]) );
  AOI211X1 U175 ( .A0(data[0]), .A1(n28), .B0(flag), .C0(n29), .Y(n27) );
  XOR2X1 U176 ( .A(length[4]), .B(addr[4]), .Y(n57) );
  XOR2X1 U177 ( .A(length[2]), .B(addr[2]), .Y(n60) );
  XOR2X1 U178 ( .A(length[0]), .B(addr[0]), .Y(n61) );
  XOR2X1 U179 ( .A(length[6]), .B(addr[6]), .Y(n62) );
  NOR2BX1 U180 ( .AN(N21), .B(n73), .Y(next_addr[0]) );
  CLKINVX1 U181 ( .A(n39), .Y(n79) );
  OAI211X1 U182 ( .A0(n87), .A1(n40), .B0(n41), .C0(n81), .Y(n39) );
  NAND2X1 U183 ( .A(state[3]), .B(n88), .Y(n40) );
  CLKINVX1 U184 ( .A(cnt[2]), .Y(n75) );
  OAI32X1 U185 ( .A0(n77), .A1(cnt[1]), .A2(n32), .B0(n66), .B1(n76), .Y(
        next_cnt[1]) );
  XOR2X1 U186 ( .A(total[0]), .B(n25), .Y(next_total[0]) );
  CLKINVX1 U187 ( .A(cnt[0]), .Y(n77) );
  XOR2X1 U188 ( .A(total[2]), .B(n23), .Y(next_total[2]) );
  CLKINVX1 U189 ( .A(total[1]), .Y(n78) );
  CLKINVX1 U190 ( .A(cnt[1]), .Y(n76) );
  OAI2BB2XL U191 ( .B0(n75), .B1(n71), .A0N(total[2]), .A1N(N107), .Y(count[2]) );
  CLKINVX1 U192 ( .A(data[0]), .Y(n90) );
  AO22X1 U193 ( .A0(cnt[0]), .A1(flag), .B0(total[0]), .B1(N107), .Y(count[0])
         );
  AO22X1 U194 ( .A0(cnt[3]), .A1(flag), .B0(total[3]), .B1(N107), .Y(count[3])
         );
endmodule

