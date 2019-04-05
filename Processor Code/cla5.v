module cla5(c_in, in1, in2, sum);

	input c_in;
	input [4:0] in1, in2;
	
	output [4:0] sum;
	
	wire [4:0] in2Sub;
	
	wire g0, g1, g2, g3;
	wire p0, p1, p2, p3;
	wire c1, c2, c3, c4;
	
	wire pc0, pg1, ppc1, pg2, ppg2, pppc2, pg3, ppg3, pppg3, ppppc3;
	
	// Generate xor gates 
	genvar i;
	generate
		for (i = 0; i < 5; i = i+1)
		begin : determineSub
			xor xor_sub(in2Sub[i], in2[i], c_in);
		end
	endgenerate
	
	// Determine carries
	and and0_first(g0, in1[0], in2Sub[0]);
	or or0_first(p0, in1[0], in2Sub[0]);
	and and0_second(pc0, p0, c_in);
	or or0_second(c1, g0, pc0);
	
	and and1_first(g1, in1[1], in2Sub[1]);
	or or1_first(p1, in1[1], in2Sub[1]);
	and and1_second(pg1, p1, g0);
	and and1_third(ppc1, p1, p0, c_in);
	or or1_second(c2, g1, pg1, ppc1);

	and and2_first(g2, in1[2], in2Sub[2]);
	or or2_first(p2, in1[2], in2Sub[2]);
	and and2_second(pg2, p2, g1);
	and and2_third(ppg2, p2, p1, g0);
	and and2_fourth(pppc2, p2, p1, p0, c_in);
	or or2_second(c3, g2, pg2, ppg2, pppc2);
	
	and and3_first(g3, in1[3], in2Sub[3]);
	or or3_first(p3, in1[3], in2Sub[3]);
	and and3_second(pg3, p3, g2);
	and and3_third(ppg3, p3, p2, g1);
	and and3_fourth(pppg3, p3, p2, p1, g0);
	and and3_fifth(ppppc3, p3, p2, p1, p0, c_in);
	or or3_second(c4, g3, pg3, ppg3, pppg3, ppppc3);

	// Create 8 Full Adders
	fulladder add0(.sum(sum[0]), .in1(in1[0]), .in2(in2Sub[0]), .c_in(c_in));
	fulladder add1(.sum(sum[1]), .in1(in1[1]), .in2(in2Sub[1]), .c_in(c1));
	fulladder add2(.sum(sum[2]), .in1(in1[2]), .in2(in2Sub[2]), .c_in(c2));
	fulladder add3(.sum(sum[3]), .in1(in1[3]), .in2(in2Sub[3]), .c_in(c3));
	fulladder add4(.sum(sum[4]), .in1(in1[4]), .in2(in2Sub[4]), .c_in(c4));

endmodule
