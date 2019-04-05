module cla8(c_in, in1, in2, sum, c_out0, c_out1);

	input c_in;
	input [7:0] in1, in2;
	
	output [7:0] sum;
	output c_out0, c_out1;
	
	wire g0, g1, g2, g3, g4, g5, g6, g7;
	wire p0, p1, p2, p3, p4, p5, p6, p7;
	wire c1, c2, c3, c4, c5, c6;
	
	wire pc0, pg1, ppc1, pg2, ppg2, pppc2, pg3, ppg3, pppg3, ppppc3, pg4, ppg4, pppg4, ppppg4, pppppc4;
	wire pg5, ppg5, pppg5, ppppg5, pppppg5, ppppppc5, pg6, ppg6, pppg6, ppppg6, pppppg6, ppppppg6, pppppppc6;
	wire pg7, ppg7, pppg7, ppppg7, pppppg7, ppppppg7, pppppppg7, ppppppppc7;
	
	// Determine carries
	and and0_first(g0, in1[0], in2[0]);
	or or0_first(p0, in1[0], in2[0]);
	and and0_second(pc0, p0, c_in);
	or or0_second(c1, g0, pc0);
	
	and and1_first(g1, in1[1], in2[1]);
	or or1_first(p1, in1[1], in2[1]);
	and and1_second(pg1, p1, g0);
	and and1_third(ppc1, p1, p0, c_in);
	or or1_second(c2, g1, pg1, ppc1);

	and and2_first(g2, in1[2], in2[2]);
	or or2_first(p2, in1[2], in2[2]);
	and and2_second(pg2, p2, g1);
	and and2_third(ppg2, p2, p1, g0);
	and and2_fourth(pppc2, p2, p1, p0, c_in);
	or or2_second(c3, g2, pg2, ppg2, pppc2);
	
	and and3_first(g3, in1[3], in2[3]);
	or or3_first(p3, in1[3], in2[3]);
	and and3_second(pg3, p3, g2);
	and and3_third(ppg3, p3, p2, g1);
	and and3_fourth(pppg3, p3, p2, p1, g0);
	and and3_fifth(ppppc3, p3, p2, p1, p0, c_in);
	or or3_second(c4, g3, pg3, ppg3, pppg3, ppppc3);
	
	and and4_first(g4, in1[4], in2[4]);
	or or4_first(p4, in1[4], in2[4]);	
	and and4_second(pg4, p4, g3);
	and and4_third(ppg4, p4, p3, g2);
	and and4_fourth(pppg4, p4, p3, p2, g1);
	and and4_fifth(ppppg4, p4, p3, p2, p1, g0);
	and and4_sixth(pppppc4, p4, p3, p2, p1, p0, c_in);
	or or4_second(c5, g4, pg4, ppg4, pppg4, ppppg4, pppppc4);
	
	and and5_first(g5, in1[5], in2[5]);
	or or5_first(p5, in1[5], in2[5]);
	and and5_second(pg5, p5, g4);
	and and5_third(ppg5, p5, p4, g3);
	and and5_fourth(pppg5, p5, p4, p3, g2);
	and and5_fifth(ppppg5, p5, p4, p3, p2, g1);	
	and and5_sixth(pppppg5, p5, p4, p3, p2, p1, g0);	
	and and5_seventh(ppppppc5, p5, p4, p3, p2, p1, p0, c_in);
	or or5_second(c6, g5, pg5, ppg5, pppg5, ppppg5, pppppg5, ppppppc5);
	
	and and6_first(g6, in1[6], in2[6]);
	or or6_first(p6, in1[6], in2[6]);
	and and6_second(pg6, p6, g5);
	and and6_third(ppg6, p6, p5, g4);
	and and6_fourth(pppg6, p6, p5, p4, g3);
	and and6_fifth(ppppg6, p6, p5, p4, p3, g2);	
	and and6_sixth(pppppg6, p6, p5, p4, p3, p2, g1);
	and and6_seventh(ppppppg6, p6, p5, p4, p3, p2, p1, g0);
	and and6_eighth(pppppppc6, p6, p5, p4, p3, p2, p1, p0, c_in);
	or or6_second(c_out0, g6, pg6, ppg6, pppg6, ppppg6, pppppg6, ppppppg6, pppppppc6); 
	
	and and7_first(g7, in1[7], in2[7]);
	or or7_first(p7, in1[7], in2[7]);
	and and7_second(pg7, p7, g6);
	and and7_third(ppg7, p7, p6, g5);
	and and7_fourth(pppg7, p7, p6, p5, g4);
	and and7_fifth(ppppg7, p7, p6, p5, p4, g3);	
	and and7_sixth(pppppg7, p7, p6, p5, p4, p3, g2);
	and and7_seventh(ppppppg7, p7, p6, p5, p4, p3, p2, g1);
	and and7_eighth(pppppppg7, p7, p6, p5, p4, p3, p2, p1, g0);
	and and7_ninth(ppppppppc7, p7, p6, p5, p4, p3, p2, p1, p0, c_in);
	or or7_second(c_out1, g7, pg7, ppg7, pppg7, ppppg7, pppppg7, ppppppg7, pppppppg7, ppppppppc7);
	
	// Create 8 Full Adders
	fulladder add0(.sum(sum[0]), .in1(in1[0]), .in2(in2[0]), .c_in(c_in));
	fulladder add1(.sum(sum[1]), .in1(in1[1]), .in2(in2[1]), .c_in(c1));
	fulladder add2(.sum(sum[2]), .in1(in1[2]), .in2(in2[2]), .c_in(c2));
	fulladder add3(.sum(sum[3]), .in1(in1[3]), .in2(in2[3]), .c_in(c3));
	fulladder add4(.sum(sum[4]), .in1(in1[4]), .in2(in2[4]), .c_in(c4));
	fulladder add5(.sum(sum[5]), .in1(in1[5]), .in2(in2[5]), .c_in(c5));
	fulladder add6(.sum(sum[6]), .in1(in1[6]), .in2(in2[6]), .c_in(c6));
	fulladder add7(.sum(sum[7]), .in1(in1[7]), .in2(in2[7]), .c_in(c_out0));

endmodule
