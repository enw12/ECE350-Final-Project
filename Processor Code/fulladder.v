module fulladder(c_in, in1, in2, sum, c_out);

	input c_in, in1, in2;
	output sum, c_out;
	
	wire w1, w2, w3;
	
	// Standard circuit for full adder
	xor xor_1(w1, in1, in2);
	xor sumBit(sum, w1, c_in);
	
	and and_1(w2, in1, in2);
	and and_2(w3, w1, c_in);
	
	or cOut(c_out, w2, w3);
	

endmodule
