/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Sat Mar 30 15:49:48 2019
/////////////////////////////////////////////////////////////


module Priority_Encoder ( out, a, b );
  output [2:0] out;
  input [3:0] a;
  input [3:0] b;
  wire   n1, n2, n3, n4, n5, n6, n7, n8;

  NAND4X1 U3 ( .A(n1), .B(n2), .C(n3), .D(n4), .Y(out[2]) );
  NAND3X1 U4 ( .A(n3), .B(n4), .C(n5), .Y(out[1]) );
  OAI211X1 U5 ( .A0(b[2]), .A1(b[3]), .B0(n1), .C0(n2), .Y(n5) );
  CLKINVX1 U6 ( .A(a[1]), .Y(n2) );
  CLKINVX1 U7 ( .A(a[2]), .Y(n3) );
  OAI21XL U8 ( .A0(a[2]), .A1(n6), .B0(n4), .Y(out[0]) );
  CLKINVX1 U9 ( .A(a[3]), .Y(n4) );
  AOI21X1 U10 ( .A0(n7), .A1(n1), .B0(a[1]), .Y(n6) );
  CLKINVX1 U11 ( .A(a[0]), .Y(n1) );
  AO21X1 U12 ( .A0(b[1]), .A1(n8), .B0(b[3]), .Y(n7) );
  CLKINVX1 U13 ( .A(b[2]), .Y(n8) );
endmodule


module Decoder_2_to_4 ( out, a, b );
  output [3:0] out;
  input a, b;
  wire   n1, n2;

  NOR2X1 U1 ( .A(n1), .B(n2), .Y(out[3]) );
  NOR2X1 U2 ( .A(b), .B(n1), .Y(out[2]) );
  CLKINVX1 U3 ( .A(a), .Y(n1) );
  NOR2X1 U4 ( .A(a), .B(n2), .Y(out[1]) );
  CLKINVX1 U5 ( .A(b), .Y(n2) );
  NOR2X1 U6 ( .A(b), .B(a), .Y(out[0]) );
endmodule


module Decoder_2_to_4_2 ( out, a, b );
  output [3:0] out;
  input a, b;
  wire   n1, n2;

  NOR2X1 U7 ( .A(n1), .B(n2), .Y(out[3]) );
  NOR2X1 U8 ( .A(b), .B(n1), .Y(out[2]) );
  CLKINVX1 U9 ( .A(a), .Y(n1) );
  NOR2X1 U10 ( .A(a), .B(n2), .Y(out[1]) );
  CLKINVX1 U11 ( .A(b), .Y(n2) );
  NOR2X1 U12 ( .A(b), .B(a), .Y(out[0]) );
endmodule


module Decoder_2_to_4_1 ( out, a, b );
  output [3:0] out;
  input a, b;
  wire   n1, n2;

  NOR2X1 U7 ( .A(n1), .B(n2), .Y(out[3]) );
  NOR2X1 U8 ( .A(b), .B(n1), .Y(out[2]) );
  CLKINVX1 U9 ( .A(a), .Y(n1) );
  NOR2X1 U10 ( .A(a), .B(n2), .Y(out[1]) );
  CLKINVX1 U11 ( .A(b), .Y(n2) );
  NOR2X1 U12 ( .A(b), .B(a), .Y(out[0]) );
endmodule


module Decoder_4_to_16 ( out, a, b );
  output [15:0] out;
  input [1:0] a;
  input [1:0] b;
  wire   n1, n2, n3, n4, n5, n6, n7, n8;
  wire   [3:0] x;
  wire   [3:0] y;

  Decoder_2_to_4_2 dec1 ( .out(x), .a(a[1]), .b(a[0]) );
  Decoder_2_to_4_1 dec2 ( .out(y), .a(b[1]), .b(b[0]) );
  NOR2X1 U25 ( .A(n1), .B(n2), .Y(out[9]) );
  NOR2X1 U26 ( .A(n1), .B(n3), .Y(out[8]) );
  NOR2X1 U27 ( .A(n4), .B(n5), .Y(out[7]) );
  NOR2X1 U28 ( .A(n4), .B(n6), .Y(out[6]) );
  NOR2X1 U29 ( .A(n2), .B(n4), .Y(out[5]) );
  NOR2X1 U30 ( .A(n3), .B(n4), .Y(out[4]) );
  CLKINVX1 U31 ( .A(x[1]), .Y(n4) );
  NOR2X1 U32 ( .A(n5), .B(n7), .Y(out[3]) );
  NOR2X1 U33 ( .A(n6), .B(n7), .Y(out[2]) );
  NOR2X1 U34 ( .A(n2), .B(n7), .Y(out[1]) );
  NOR2X1 U35 ( .A(n5), .B(n8), .Y(out[15]) );
  NOR2X1 U36 ( .A(n6), .B(n8), .Y(out[14]) );
  NOR2X1 U37 ( .A(n2), .B(n8), .Y(out[13]) );
  CLKINVX1 U38 ( .A(y[1]), .Y(n2) );
  NOR2X1 U39 ( .A(n3), .B(n8), .Y(out[12]) );
  CLKINVX1 U40 ( .A(x[3]), .Y(n8) );
  NOR2X1 U41 ( .A(n1), .B(n5), .Y(out[11]) );
  CLKINVX1 U42 ( .A(y[3]), .Y(n5) );
  NOR2X1 U43 ( .A(n1), .B(n6), .Y(out[10]) );
  CLKINVX1 U44 ( .A(y[2]), .Y(n6) );
  CLKINVX1 U45 ( .A(x[2]), .Y(n1) );
  NOR2X1 U46 ( .A(n3), .B(n7), .Y(out[0]) );
  CLKINVX1 U47 ( .A(x[0]), .Y(n7) );
  CLKINVX1 U48 ( .A(y[0]), .Y(n3) );
endmodule


module bitslice_0 ( out, pa, pb, a, b );
  output [1:0] out;
  input pa, pb, a, b;


  AOI2BB1X1 U3 ( .A0N(a), .A1N(pa), .B0(pb), .Y(out[1]) );
  AOI2BB1X1 U4 ( .A0N(b), .A1N(pb), .B0(pa), .Y(out[0]) );
endmodule


module bitslice_7 ( out, pa, pb, a, b );
  output [1:0] out;
  input pa, pb, a, b;


  AOI2BB1X1 U3 ( .A0N(a), .A1N(pa), .B0(pb), .Y(out[1]) );
  AOI2BB1X1 U4 ( .A0N(b), .A1N(pb), .B0(pa), .Y(out[0]) );
endmodule


module bitslice_6 ( out, pa, pb, a, b );
  output [1:0] out;
  input pa, pb, a, b;


  AOI2BB1X1 U3 ( .A0N(a), .A1N(pa), .B0(pb), .Y(out[1]) );
  AOI2BB1X1 U4 ( .A0N(b), .A1N(pb), .B0(pa), .Y(out[0]) );
endmodule


module bitslice_5 ( out, pa, pb, a, b );
  output [1:0] out;
  input pa, pb, a, b;


  AOI2BB1X1 U3 ( .A0N(a), .A1N(pa), .B0(pb), .Y(out[1]) );
  AOI2BB1X1 U4 ( .A0N(b), .A1N(pb), .B0(pa), .Y(out[0]) );
endmodule


module Select_Large ( out, a, b );
  output [3:0] out;
  input [3:0] a;
  input [3:0] b;
  wire   \nab0[1] ;
  wire   [1:0] nab3;
  wire   [1:0] nab2;
  wire   [1:0] nab1;
  wire   SYNOPSYS_UNCONNECTED__0;

  bitslice_0 b_3 ( .out(nab3), .pa(1'b0), .pb(1'b0), .a(a[3]), .b(b[3]) );
  bitslice_7 b_2 ( .out(nab2), .pa(nab3[1]), .pb(nab3[0]), .a(a[2]), .b(b[2])
         );
  bitslice_6 b_1 ( .out(nab1), .pa(nab2[1]), .pb(nab2[0]), .a(a[1]), .b(b[1])
         );
  bitslice_5 b_0 ( .out({\nab0[1] , SYNOPSYS_UNCONNECTED__0}), .pa(nab1[1]), 
        .pb(nab1[0]), .a(a[0]), .b(b[0]) );
  CLKMX2X2 U6 ( .A(b[3]), .B(a[3]), .S0(\nab0[1] ), .Y(out[3]) );
  CLKMX2X2 U7 ( .A(b[2]), .B(a[2]), .S0(\nab0[1] ), .Y(out[2]) );
  CLKMX2X2 U8 ( .A(b[1]), .B(a[1]), .S0(\nab0[1] ), .Y(out[1]) );
  CLKMX2X2 U9 ( .A(b[0]), .B(a[0]), .S0(\nab0[1] ), .Y(out[0]) );
endmodule


module bitslice_4 ( out, pa, pb, a, b );
  output [1:0] out;
  input pa, pb, a, b;


  AOI2BB1X1 U3 ( .A0N(a), .A1N(pa), .B0(pb), .Y(out[1]) );
  AOI2BB1X1 U4 ( .A0N(b), .A1N(pb), .B0(pa), .Y(out[0]) );
endmodule


module bitslice_3 ( out, pa, pb, a, b );
  output [1:0] out;
  input pa, pb, a, b;


  AOI2BB1X1 U3 ( .A0N(a), .A1N(pa), .B0(pb), .Y(out[1]) );
  AOI2BB1X1 U4 ( .A0N(b), .A1N(pb), .B0(pa), .Y(out[0]) );
endmodule


module bitslice_2 ( out, pa, pb, a, b );
  output [1:0] out;
  input pa, pb, a, b;


  AOI2BB1X1 U3 ( .A0N(a), .A1N(pa), .B0(pb), .Y(out[1]) );
  AOI2BB1X1 U4 ( .A0N(b), .A1N(pb), .B0(pa), .Y(out[0]) );
endmodule


module bitslice_1 ( out, pa, pb, a, b );
  output [1:0] out;
  input pa, pb, a, b;


  AOI2BB1X1 U3 ( .A0N(a), .A1N(pa), .B0(pb), .Y(out[1]) );
  AOI2BB1X1 U4 ( .A0N(b), .A1N(pb), .B0(pa), .Y(out[0]) );
endmodule


module Select_Small ( out, a, b );
  output [3:0] out;
  input [3:0] a;
  input [3:0] b;
  wire   \nab0[1] ;
  wire   [1:0] nab3;
  wire   [1:0] nab2;
  wire   [1:0] nab1;
  wire   SYNOPSYS_UNCONNECTED__0;

  bitslice_4 b_3 ( .out(nab3), .pa(1'b0), .pb(1'b0), .a(a[3]), .b(b[3]) );
  bitslice_3 b_2 ( .out(nab2), .pa(nab3[1]), .pb(nab3[0]), .a(a[2]), .b(b[2])
         );
  bitslice_2 b_1 ( .out(nab1), .pa(nab2[1]), .pb(nab2[0]), .a(a[1]), .b(b[1])
         );
  bitslice_1 b_0 ( .out({\nab0[1] , SYNOPSYS_UNCONNECTED__0}), .pa(nab1[1]), 
        .pb(nab1[0]), .a(a[0]), .b(b[0]) );
  CLKMX2X2 U6 ( .A(a[3]), .B(b[3]), .S0(\nab0[1] ), .Y(out[3]) );
  CLKMX2X2 U7 ( .A(a[2]), .B(b[2]), .S0(\nab0[1] ), .Y(out[2]) );
  CLKMX2X2 U8 ( .A(a[1]), .B(b[1]), .S0(\nab0[1] ), .Y(out[1]) );
  CLKMX2X2 U9 ( .A(a[0]), .B(b[0]), .S0(\nab0[1] ), .Y(out[0]) );
endmodule


module Bit_Adder_24 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U1 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U2 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U3 ( .A(a), .B(b), .Y(n1) );
endmodule


module Bit_Adder_31 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U1 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U2 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U3 ( .A(a), .B(b), .Y(n1) );
endmodule


module Bit_Adder_30 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U1 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U2 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U3 ( .A(a), .B(b), .Y(n1) );
endmodule


module Bit_Adder_29 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U1 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U2 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U3 ( .A(a), .B(b), .Y(n1) );
endmodule


module Adder_3 ( out, ovf, a, b );
  output [3:0] out;
  input [3:0] a;
  input [3:0] b;
  output ovf;

  wire   [3:0] cout;

  Bit_Adder_24 ad3 ( .cout(cout[0]), .s(out[0]), .a(a[0]), .b(b[0]), .cin(1'b0) );
  Bit_Adder_31 ad2 ( .cout(cout[1]), .s(out[1]), .a(a[1]), .b(b[1]), .cin(
        cout[0]) );
  Bit_Adder_30 ad1 ( .cout(cout[2]), .s(out[2]), .a(a[2]), .b(b[2]), .cin(
        cout[1]) );
  Bit_Adder_29 ad0 ( .cout(cout[3]), .s(out[3]), .a(a[3]), .b(b[3]), .cin(
        cout[2]) );
  XOR2X1 U2 ( .A(cout[3]), .B(cout[2]), .Y(ovf) );
endmodule


module Bit_Adder_28 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U1 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U2 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U3 ( .A(a), .B(b), .Y(n1) );
endmodule


module Bit_Adder_27 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U1 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U2 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U3 ( .A(a), .B(b), .Y(n1) );
endmodule


module Bit_Adder_26 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U1 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U2 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U3 ( .A(a), .B(b), .Y(n1) );
endmodule


module Bit_Adder_25 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U1 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U2 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U3 ( .A(a), .B(b), .Y(n1) );
endmodule


module Adder_4 ( out, ovf, a, b );
  output [3:0] out;
  input [3:0] a;
  input [3:0] b;
  output ovf;

  wire   [3:0] cout;

  Bit_Adder_28 ad3 ( .cout(cout[0]), .s(out[0]), .a(a[0]), .b(b[0]), .cin(1'b0) );
  Bit_Adder_27 ad2 ( .cout(cout[1]), .s(out[1]), .a(a[1]), .b(b[1]), .cin(
        cout[0]) );
  Bit_Adder_26 ad1 ( .cout(cout[2]), .s(out[2]), .a(a[2]), .b(b[2]), .cin(
        cout[1]) );
  Bit_Adder_25 ad0 ( .cout(cout[3]), .s(out[3]), .a(a[3]), .b(b[3]), .cin(
        cout[2]) );
  XOR2X1 U2 ( .A(cout[3]), .B(cout[2]), .Y(ovf) );
endmodule


module Subtractor ( out, ovf, a, b );
  output [3:0] out;
  input [3:0] a;
  input [3:0] b;
  output ovf;
  wire   n1, n2;
  wire   [3:0] b2;
  assign b2[0] = b[0];

  Adder_4 add ( .out(out), .ovf(ovf), .a(a), .b(b2) );
  XOR2X1 U2 ( .A(n1), .B(b[3]), .Y(b2[3]) );
  NAND2BX1 U3 ( .AN(b[2]), .B(n2), .Y(n1) );
  XNOR2X1 U4 ( .A(b[2]), .B(n2), .Y(b2[2]) );
  NOR2X1 U5 ( .A(b[1]), .B(b2[0]), .Y(n2) );
  XOR2X1 U6 ( .A(b[1]), .B(b2[0]), .Y(b2[1]) );
endmodule


module Bit_Adder_4 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U4 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U5 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U6 ( .A(a), .B(b), .Y(n1) );
endmodule


module Bit_Adder_3 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U4 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U5 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U6 ( .A(a), .B(b), .Y(n1) );
endmodule


module Bit_Adder_2 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U4 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U5 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U6 ( .A(a), .B(b), .Y(n1) );
endmodule


module Bit_Adder_1 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U4 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U5 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U6 ( .A(a), .B(b), .Y(n1) );
endmodule


module Adder_1 ( out, ovf, a, b );
  output [3:0] out;
  input [3:0] a;
  input [3:0] b;
  output ovf;

  wire   [3:0] cout;

  Bit_Adder_4 ad3 ( .cout(cout[0]), .s(out[0]), .a(a[0]), .b(b[0]), .cin(1'b0)
         );
  Bit_Adder_3 ad2 ( .cout(cout[1]), .s(out[1]), .a(a[1]), .b(b[1]), .cin(
        cout[0]) );
  Bit_Adder_2 ad1 ( .cout(cout[2]), .s(out[2]), .a(a[2]), .b(b[2]), .cin(
        cout[1]) );
  Bit_Adder_1 ad0 ( .cout(cout[3]), .s(out[3]), .a(a[3]), .b(b[3]), .cin(
        cout[2]) );
  XOR2X1 U2 ( .A(cout[3]), .B(cout[2]), .Y(ovf) );
endmodule


module Subtractor_1 ( out, ovf, a, b );
  output [3:0] out;
  input [3:0] a;
  input [3:0] b;
  output ovf;
  wire   n1, n2;
  wire   [3:0] b2;

  Adder_1 add ( .out(out), .ovf(ovf), .a(a), .b({b2[3:1], b[0]}) );
  XOR2X1 U6 ( .A(n1), .B(b[3]), .Y(b2[3]) );
  NAND2BX1 U7 ( .AN(b[2]), .B(n2), .Y(n1) );
  XNOR2X1 U8 ( .A(b[2]), .B(n2), .Y(b2[2]) );
  NOR2X1 U9 ( .A(b[1]), .B(b[0]), .Y(n2) );
  XOR2X1 U10 ( .A(b[1]), .B(b[0]), .Y(b2[1]) );
endmodule


module Abs_Subtractor ( out, ovf, a, b );
  output [3:0] out;
  input [3:0] a;
  input [3:0] b;
  output ovf;
  wire   n1, n2, n3, n4;
  wire   [3:0] tmp;

  Subtractor_1 sub ( .out({tmp[3:1], out[0]}), .ovf(ovf), .a(a), .b(b) );
  NOR3BXL U8 ( .AN(n1), .B(n2), .C(tmp[2]), .Y(out[3]) );
  XOR2X1 U9 ( .A(tmp[2]), .B(n3), .Y(out[2]) );
  NOR2X1 U10 ( .A(n1), .B(n2), .Y(n3) );
  CLKINVX1 U11 ( .A(tmp[3]), .Y(n2) );
  NOR2X1 U12 ( .A(tmp[1]), .B(out[0]), .Y(n1) );
  XNOR2X1 U13 ( .A(tmp[1]), .B(n4), .Y(out[1]) );
  NAND2X1 U14 ( .A(out[0]), .B(tmp[3]), .Y(n4) );
endmodule


module Bit_Adder_20 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U4 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U5 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U6 ( .A(a), .B(b), .Y(n1) );
endmodule


module Bit_Adder_19 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U4 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U5 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U6 ( .A(a), .B(b), .Y(n1) );
endmodule


module Bit_Adder_18 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U4 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U5 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U6 ( .A(a), .B(b), .Y(n1) );
endmodule


module Bit_Adder_17 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U4 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U5 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U6 ( .A(a), .B(b), .Y(n1) );
endmodule


module Bit_Adder_16 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U4 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U5 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U6 ( .A(a), .B(b), .Y(n1) );
endmodule


module Bit_Adder_15 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U4 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U5 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U6 ( .A(a), .B(b), .Y(n1) );
endmodule


module Bit_Adder_14 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U4 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U5 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U6 ( .A(a), .B(b), .Y(n1) );
endmodule


module Bit_Adder_13 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U4 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U5 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U6 ( .A(a), .B(b), .Y(n1) );
endmodule


module Bit_Adder_12 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U4 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U5 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U6 ( .A(a), .B(b), .Y(n1) );
endmodule


module Bit_Adder_11 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U4 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U5 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U6 ( .A(a), .B(b), .Y(n1) );
endmodule


module Bit_Adder_10 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U4 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U5 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U6 ( .A(a), .B(b), .Y(n1) );
endmodule


module Bit_Adder_9 ( cout, s, a, b, cin );
  input a, b, cin;
  output cout, s;
  wire   n1;

  XOR2X1 U4 ( .A(cin), .B(n1), .Y(s) );
  AO22X1 U5 ( .A0(b), .A1(a), .B0(n1), .B1(cin), .Y(cout) );
  XOR2X1 U6 ( .A(a), .B(b), .Y(n1) );
endmodule


module Multiplier ( out, a, b );
  output [7:0] out;
  input [3:0] a;
  input [3:0] b;
  wire   c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, f1, d1,
         d2, d3, d4, d5, d6, d7, e1, e2, e3, e4, e5, e6, e7, f2, f3, f4, n1,
         n2, n3, n4, n5, n6, n7, n8;

  Bit_Adder_20 bitAdder0 ( .cout(d1), .s(d2), .a(c1), .b(c2), .cin(c3) );
  Bit_Adder_19 bitAdder1 ( .cout(d3), .s(d4), .a(c4), .b(c5), .cin(c6) );
  Bit_Adder_18 bitAdder2 ( .cout(d5), .s(d6), .a(c7), .b(c8), .cin(c9) );
  Bit_Adder_17 bitAdder3 ( .cout(d7), .s(out[1]), .a(c10), .b(c11), .cin(1'b0)
         );
  Bit_Adder_16 bitAdder4 ( .cout(e1), .s(e2), .a(c12), .b(c13), .cin(d1) );
  Bit_Adder_15 bitAdder5 ( .cout(e3), .s(e4), .a(d2), .b(d3), .cin(e5) );
  Bit_Adder_14 bitAdder6 ( .cout(e5), .s(e6), .a(d4), .b(c14), .cin(d5) );
  Bit_Adder_13 bitAdder7 ( .cout(e7), .s(out[2]), .a(d6), .b(d7), .cin(1'b0)
         );
  Bit_Adder_12 bitAdder8 ( .cout(out[7]), .s(out[6]), .a(f1), .b(e1), .cin(f2)
         );
  Bit_Adder_11 bitAdder9 ( .cout(f2), .s(out[5]), .a(e2), .b(e3), .cin(f3) );
  Bit_Adder_10 bitAdder10 ( .cout(f3), .s(out[4]), .a(e4), .b(1'b0), .cin(f4)
         );
  Bit_Adder_9 bitAdder11 ( .cout(f4), .s(out[3]), .a(e6), .b(e7), .cin(1'b0)
         );
  NOR2X1 U25 ( .A(n1), .B(n2), .Y(out[0]) );
  NOR2X1 U26 ( .A(n3), .B(n4), .Y(f1) );
  NOR2X1 U27 ( .A(n2), .B(n5), .Y(c9) );
  NOR2X1 U28 ( .A(n6), .B(n7), .Y(c8) );
  NOR2X1 U29 ( .A(n1), .B(n8), .Y(c7) );
  NOR2X1 U30 ( .A(n5), .B(n7), .Y(c6) );
  NOR2X1 U31 ( .A(n6), .B(n8), .Y(c5) );
  NOR2X1 U32 ( .A(n1), .B(n4), .Y(c4) );
  NOR2X1 U33 ( .A(n3), .B(n7), .Y(c3) );
  NOR2X1 U34 ( .A(n5), .B(n8), .Y(c2) );
  NOR2X1 U35 ( .A(n2), .B(n3), .Y(c14) );
  NOR2X1 U36 ( .A(n4), .B(n5), .Y(c13) );
  CLKINVX1 U37 ( .A(a[2]), .Y(n5) );
  NOR2X1 U38 ( .A(n3), .B(n8), .Y(c12) );
  CLKINVX1 U39 ( .A(b[2]), .Y(n8) );
  CLKINVX1 U40 ( .A(a[3]), .Y(n3) );
  NOR2X1 U41 ( .A(n2), .B(n6), .Y(c11) );
  CLKINVX1 U42 ( .A(b[0]), .Y(n2) );
  NOR2X1 U43 ( .A(n1), .B(n7), .Y(c10) );
  CLKINVX1 U44 ( .A(b[1]), .Y(n7) );
  CLKINVX1 U45 ( .A(a[0]), .Y(n1) );
  NOR2X1 U46 ( .A(n4), .B(n6), .Y(c1) );
  CLKINVX1 U47 ( .A(a[1]), .Y(n6) );
  CLKINVX1 U48 ( .A(b[3]), .Y(n4) );
endmodule


module AM_DW_mult_uns_2 ( a, b, product );
  input [7:0] a;
  input [7:0] b;
  output [15:0] product;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41;

  CLKINVX1 U1 ( .A(n1), .Y(product[7]) );
  ADDFXL U2 ( .A(n7), .B(n19), .CI(n2), .CO(n1), .S(product[6]) );
  ADDFXL U3 ( .A(n8), .B(n9), .CI(n3), .CO(n2), .S(product[5]) );
  ADDFXL U4 ( .A(n10), .B(n13), .CI(n4), .CO(n3), .S(product[4]) );
  ADDFXL U5 ( .A(n5), .B(n16), .CI(n14), .CO(n4), .S(product[3]) );
  ADDFXL U6 ( .A(n6), .B(n26), .CI(n18), .CO(n5), .S(product[2]) );
  ADDHXL U7 ( .A(n30), .B(n33), .CO(n6), .S(product[1]) );
  ADDFXL U8 ( .A(n20), .B(n23), .CI(n11), .CO(n7), .S(n8) );
  ADDFXL U9 ( .A(n15), .B(n21), .CI(n12), .CO(n9), .S(n10) );
  XNOR2X1 U10 ( .A(n27), .B(n24), .Y(n12) );
  OR2X1 U11 ( .A(n27), .B(n24), .Y(n11) );
  ADDFXL U12 ( .A(n22), .B(n31), .CI(n17), .CO(n13), .S(n14) );
  ADDHXL U13 ( .A(n25), .B(n28), .CO(n15), .S(n16) );
  ADDHXL U14 ( .A(n32), .B(n29), .CO(n17), .S(n18) );
  NOR2X1 U15 ( .A(n34), .B(n38), .Y(n19) );
  OR2X1 U16 ( .A(n35), .B(n38), .Y(n20) );
  OR2X1 U17 ( .A(n36), .B(n38), .Y(n21) );
  OR2X1 U18 ( .A(n37), .B(n38), .Y(n22) );
  OR2X1 U19 ( .A(n34), .B(n39), .Y(n23) );
  NOR2X1 U20 ( .A(n35), .B(n39), .Y(n24) );
  NOR2X1 U21 ( .A(n36), .B(n39), .Y(n25) );
  NOR2X1 U22 ( .A(n37), .B(n39), .Y(n26) );
  OR2X1 U23 ( .A(n34), .B(n40), .Y(n27) );
  NOR2X1 U24 ( .A(n35), .B(n40), .Y(n28) );
  NOR2X1 U25 ( .A(n36), .B(n40), .Y(n29) );
  NOR2X1 U26 ( .A(n37), .B(n40), .Y(n30) );
  OR2X1 U27 ( .A(n34), .B(n41), .Y(n31) );
  NOR2X1 U28 ( .A(n35), .B(n41), .Y(n32) );
  NOR2X1 U29 ( .A(n36), .B(n41), .Y(n33) );
  NOR2X1 U30 ( .A(n37), .B(n41), .Y(product[0]) );
  CLKINVX1 U41 ( .A(b[1]), .Y(n36) );
  CLKINVX1 U42 ( .A(b[0]), .Y(n37) );
  CLKINVX1 U43 ( .A(b[2]), .Y(n35) );
  CLKINVX1 U44 ( .A(a[0]), .Y(n41) );
  CLKINVX1 U45 ( .A(a[1]), .Y(n40) );
  CLKINVX1 U46 ( .A(a[2]), .Y(n39) );
  CLKINVX1 U47 ( .A(b[3]), .Y(n34) );
  CLKINVX1 U48 ( .A(a[3]), .Y(n38) );
endmodule


module AM ( A, B, Sel, Out, Ovf );
  input [3:0] A;
  input [3:0] B;
  input [3:0] Sel;
  output [15:0] Out;
  output Ovf;
  wire   ovf1, ovf2, ovf3, N74, N75, N76, N77, N78, N79, N80, N81, n78, n79,
         n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93,
         n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105,
         n106, n107, n108, n109, n110, n111, n112, n113, n114, n115, n116,
         n117, n118, n119, n120, n121, n122, n123, n124, n125, n126, n127,
         n128, n129, n130, n131, n132, n133, n134, n135, n136, n137, n138,
         n139, n140, n141, n142, n143, n144, n145, n146, n147;
  wire   [2:0] out1;
  wire   [3:0] out2;
  wire   [15:0] out3;
  wire   [3:0] out4;
  wire   [3:0] out5;
  wire   [3:0] out6;
  wire   [3:0] out7;
  wire   [3:0] out8;
  wire   [7:0] out9;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7;

  Priority_Encoder pri ( .out(out1), .a(A), .b(B) );
  Decoder_2_to_4 dec2 ( .out(out2), .a(A[3]), .b(B[3]) );
  Decoder_4_to_16 dec4 ( .out(out3), .a(A[3:2]), .b(B[3:2]) );
  Select_Large Lar ( .out(out4), .a(A), .b(B) );
  Select_Small Sma ( .out(out5), .a(A), .b(B) );
  Adder_3 add ( .out(out6), .ovf(ovf1), .a(A), .b(B) );
  Subtractor sub ( .out(out7), .ovf(ovf2), .a(A), .b(B) );
  Abs_Subtractor abs ( .out(out8), .ovf(ovf3), .a(A), .b(B) );
  Multiplier mul ( .out(out9), .a(A), .b(B) );
  AM_DW_mult_uns_2 mult_44 ( .a({A[3], A[3], A[3], A[3], A}), .b({B[3], B[3], 
        B[3], B[3], B}), .product({SYNOPSYS_UNCONNECTED__0, 
        SYNOPSYS_UNCONNECTED__1, SYNOPSYS_UNCONNECTED__2, 
        SYNOPSYS_UNCONNECTED__3, SYNOPSYS_UNCONNECTED__4, 
        SYNOPSYS_UNCONNECTED__5, SYNOPSYS_UNCONNECTED__6, 
        SYNOPSYS_UNCONNECTED__7, N81, N80, N79, N78, N77, N76, N75, N74}) );
  CLKINVX1 U96 ( .A(n78), .Y(Ovf) );
  AOI221XL U97 ( .A0(n79), .A1(ovf2), .B0(n80), .B1(ovf1), .C0(n81), .Y(n78)
         );
  AND2X1 U98 ( .A(ovf3), .B(n82), .Y(n81) );
  OAI2BB1X1 U99 ( .A0N(out3[9]), .A1N(n83), .B0(n84), .Y(Out[9]) );
  OAI2BB1X1 U100 ( .A0N(out3[8]), .A1N(n83), .B0(n84), .Y(Out[8]) );
  NAND2X1 U101 ( .A(n85), .B(n84), .Y(Out[7]) );
  AOI22X1 U102 ( .A0(out3[7]), .A1(n83), .B0(N81), .B1(n86), .Y(n85) );
  OAI211X1 U103 ( .A0(n87), .A1(n88), .B0(n89), .C0(n90), .Y(Out[6]) );
  AOI22X1 U104 ( .A0(out9[6]), .A1(n91), .B0(out3[6]), .B1(n83), .Y(n90) );
  CLKINVX1 U105 ( .A(N80), .Y(n88) );
  OAI211X1 U106 ( .A0(n87), .A1(n92), .B0(n89), .C0(n93), .Y(Out[5]) );
  AOI22X1 U107 ( .A0(out9[5]), .A1(n91), .B0(out3[5]), .B1(n83), .Y(n93) );
  CLKINVX1 U108 ( .A(N79), .Y(n92) );
  OAI211X1 U109 ( .A0(n87), .A1(n94), .B0(n89), .C0(n95), .Y(Out[4]) );
  AOI22X1 U110 ( .A0(out9[4]), .A1(n91), .B0(out3[4]), .B1(n83), .Y(n95) );
  CLKINVX1 U111 ( .A(n96), .Y(n89) );
  CLKINVX1 U112 ( .A(N78), .Y(n94) );
  NAND4X1 U113 ( .A(n97), .B(n98), .C(n99), .D(n100), .Y(Out[3]) );
  AOI222XL U114 ( .A0(out7[3]), .A1(n79), .B0(A[2]), .B1(n101), .C0(out9[3]), 
        .C1(n91), .Y(n100) );
  AOI222XL U115 ( .A0(out4[3]), .A1(n102), .B0(out8[3]), .B1(n82), .C0(out6[3]), .C1(n80), .Y(n99) );
  AOI222XL U116 ( .A0(N77), .A1(n86), .B0(out5[3]), .B1(n103), .C0(out3[3]), 
        .C1(n83), .Y(n98) );
  AOI21X1 U117 ( .A0(out2[3]), .A1(n104), .B0(n105), .Y(n97) );
  MXI2X1 U118 ( .A(n106), .B(n107), .S0(B[3]), .Y(n105) );
  MXI2X1 U119 ( .A(n108), .B(n109), .S0(A[3]), .Y(n107) );
  NAND2X1 U120 ( .A(n108), .B(A[3]), .Y(n106) );
  NAND4X1 U121 ( .A(n110), .B(n111), .C(n112), .D(n113), .Y(Out[2]) );
  AOI221XL U122 ( .A0(n114), .A1(A[3]), .B0(out7[2]), .B1(n79), .C0(n115), .Y(
        n113) );
  AO22X1 U123 ( .A0(n101), .A1(A[1]), .B0(out9[2]), .B1(n91), .Y(n115) );
  AOI222XL U124 ( .A0(out4[2]), .A1(n102), .B0(out8[2]), .B1(n82), .C0(out6[2]), .C1(n80), .Y(n112) );
  AOI222XL U125 ( .A0(N76), .A1(n86), .B0(out5[2]), .B1(n103), .C0(out3[2]), 
        .C1(n83), .Y(n111) );
  AOI221XL U126 ( .A0(out2[2]), .A1(n104), .B0(out1[2]), .B1(n116), .C0(n117), 
        .Y(n110) );
  MXI2X1 U127 ( .A(n118), .B(n119), .S0(B[2]), .Y(n117) );
  MXI2X1 U128 ( .A(n108), .B(n109), .S0(A[2]), .Y(n119) );
  NAND2X1 U129 ( .A(n108), .B(A[2]), .Y(n118) );
  NAND4X1 U130 ( .A(n120), .B(n121), .C(n122), .D(n123), .Y(Out[1]) );
  AOI221XL U131 ( .A0(n114), .A1(A[2]), .B0(out7[1]), .B1(n79), .C0(n124), .Y(
        n123) );
  AO22X1 U132 ( .A0(n101), .A1(A[0]), .B0(out9[1]), .B1(n91), .Y(n124) );
  NOR2BX1 U133 ( .AN(n125), .B(n126), .Y(n101) );
  AOI222XL U134 ( .A0(out4[1]), .A1(n102), .B0(out8[1]), .B1(n82), .C0(out6[1]), .C1(n80), .Y(n122) );
  AOI222XL U135 ( .A0(N75), .A1(n86), .B0(out5[1]), .B1(n103), .C0(out3[1]), 
        .C1(n83), .Y(n121) );
  AOI221XL U136 ( .A0(out2[1]), .A1(n104), .B0(out1[1]), .B1(n116), .C0(n127), 
        .Y(n120) );
  MXI2X1 U137 ( .A(n128), .B(n129), .S0(B[1]), .Y(n127) );
  MXI2X1 U138 ( .A(n108), .B(n109), .S0(A[1]), .Y(n129) );
  NAND2X1 U139 ( .A(A[1]), .B(n108), .Y(n128) );
  OAI2BB1X1 U140 ( .A0N(out3[15]), .A1N(n83), .B0(n84), .Y(Out[15]) );
  OAI2BB1X1 U141 ( .A0N(out3[14]), .A1N(n83), .B0(n84), .Y(Out[14]) );
  OAI2BB1X1 U142 ( .A0N(out3[13]), .A1N(n83), .B0(n84), .Y(Out[13]) );
  OAI2BB1X1 U143 ( .A0N(out3[12]), .A1N(n83), .B0(n84), .Y(Out[12]) );
  OAI2BB1X1 U144 ( .A0N(out3[11]), .A1N(n83), .B0(n84), .Y(Out[11]) );
  OAI2BB1X1 U145 ( .A0N(out3[10]), .A1N(n83), .B0(n84), .Y(Out[10]) );
  AOI21X1 U146 ( .A0(out9[7]), .A1(n91), .B0(n96), .Y(n84) );
  OAI22XL U147 ( .A0(n130), .A1(n131), .B0(n132), .B1(n133), .Y(n96) );
  XNOR2X1 U148 ( .A(out7[3]), .B(ovf2), .Y(n132) );
  XNOR2X1 U149 ( .A(out6[3]), .B(ovf1), .Y(n130) );
  NAND4X1 U150 ( .A(n134), .B(n135), .C(n136), .D(n137), .Y(Out[0]) );
  AOI222XL U151 ( .A0(out7[0]), .A1(n79), .B0(out9[0]), .B1(n91), .C0(n114), 
        .C1(A[1]), .Y(n137) );
  AND2X1 U152 ( .A(n125), .B(n126), .Y(n114) );
  OA21XL U153 ( .A0(n138), .A1(n139), .B0(n140), .Y(n125) );
  AND3X1 U154 ( .A(n139), .B(Sel[3]), .C(Sel[0]), .Y(n91) );
  CLKINVX1 U155 ( .A(n133), .Y(n79) );
  NAND3X1 U156 ( .A(Sel[0]), .B(n138), .C(Sel[3]), .Y(n133) );
  AOI222XL U157 ( .A0(out4[0]), .A1(n102), .B0(out8[0]), .B1(n82), .C0(out6[0]), .C1(n80), .Y(n136) );
  CLKINVX1 U158 ( .A(n131), .Y(n80) );
  NAND3X1 U159 ( .A(n138), .B(n126), .C(Sel[3]), .Y(n131) );
  NOR2X1 U160 ( .A(n141), .B(Sel[1]), .Y(n138) );
  AND3X1 U161 ( .A(n139), .B(Sel[3]), .C(n126), .Y(n82) );
  NOR2X1 U162 ( .A(n142), .B(n141), .Y(n139) );
  CLKINVX1 U163 ( .A(Sel[2]), .Y(n141) );
  AND3X1 U164 ( .A(n143), .B(Sel[1]), .C(n126), .Y(n102) );
  AOI222XL U165 ( .A0(N74), .A1(n86), .B0(out5[0]), .B1(n103), .C0(out3[0]), 
        .C1(n83), .Y(n135) );
  AND3X1 U166 ( .A(n143), .B(Sel[0]), .C(n142), .Y(n83) );
  AND3X1 U167 ( .A(n143), .B(Sel[1]), .C(Sel[0]), .Y(n103) );
  CLKINVX1 U168 ( .A(n87), .Y(n86) );
  NAND3X1 U169 ( .A(Sel[1]), .B(Sel[0]), .C(n144), .Y(n87) );
  AOI221XL U170 ( .A0(out2[0]), .A1(n104), .B0(out1[0]), .B1(n116), .C0(n145), 
        .Y(n134) );
  MXI2X1 U171 ( .A(n146), .B(n147), .S0(B[0]), .Y(n145) );
  MXI2X1 U172 ( .A(n108), .B(n109), .S0(A[0]), .Y(n147) );
  AND3X1 U173 ( .A(n144), .B(Sel[0]), .C(n142), .Y(n109) );
  NAND2X1 U174 ( .A(A[0]), .B(n108), .Y(n146) );
  AND3X1 U175 ( .A(n144), .B(Sel[1]), .C(n126), .Y(n108) );
  AND3X1 U176 ( .A(n144), .B(n126), .C(n142), .Y(n116) );
  NOR2X1 U177 ( .A(Sel[3]), .B(Sel[2]), .Y(n144) );
  AND3X1 U178 ( .A(n143), .B(n126), .C(n142), .Y(n104) );
  CLKINVX1 U179 ( .A(Sel[1]), .Y(n142) );
  CLKINVX1 U180 ( .A(Sel[0]), .Y(n126) );
  NOR2X1 U181 ( .A(n140), .B(Sel[2]), .Y(n143) );
  CLKINVX1 U182 ( .A(Sel[3]), .Y(n140) );
endmodule

