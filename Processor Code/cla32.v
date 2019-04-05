module cla32(c_in, in1, in2, sum, ovf, not_equal, less_than);

	input c_in;
	input [31:0] in1, in2;
	
	output [31:0] sum;
	output ovf, not_equal, less_than;
	
	wire [31:0] in2Sub;
	wire c_in1, c_in2, c_in3, c_outFinalA, c_outFinalB;
	wire or1, or2, or3, or4;
	
	// Generate xor gates 
	genvar i;
	generate
		for (i = 0; i < 32; i = i+1)
		begin : determineSub
			xor xor_sub(in2Sub[i], in2[i], c_in);
		end
	endgenerate
	
	// Create 4 8-bit Adders
	cla8 bits7_0(.sum(sum[7:0]), .c_out1(c_in1), .in1(in1[7:0]), .in2(in2Sub[7:0]), .c_in(c_in));
	cla8 bits15_8(.sum(sum[15:8]), .c_out1(c_in2), .in1(in1[15:8]), .in2(in2Sub[15:8]), .c_in(c_in1));
	cla8 bits23_16(.sum(sum[23:16]), .c_out1(c_in3), .in1(in1[23:16]), .in2(in2Sub[23:16]), .c_in(c_in2));
	cla8 bits31_24(.sum(sum[31:24]), .c_out1(c_outFinalA), .c_out0(c_outFinalB), .in1(in1[31:24]), .in2(in2Sub[31:24]), .c_in(c_in3));
	
	// Determine overflow
	xor ovf_gate(ovf, c_outFinalA, c_outFinalB);
	
	// Determine not equal
	or or_1(or1, sum[0], sum[1], sum[2], sum[3], sum[4], sum[5], sum[6], sum[7]);
	or or_2(or2, sum[8], sum[9], sum[10], sum[11], sum[12], sum[13], sum[14], sum[15]);
	or or_3(or3, sum[16], sum[17], sum[18], sum[19], sum[20], sum[21], sum[22], sum[23]);
	or or_4(or4, sum[24], sum[25], sum[26], sum[27], sum[28], sum[29], sum[30], sum[31]);
	or notEqual(not_equal, or1, or2, or3, or4);
	
	// Determine less than
	xor lessThan(less_than, sum[31], ovf);
	
endmodule
