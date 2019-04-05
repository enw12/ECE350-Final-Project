module left_shift(in, shiftAmt, out);

	input [31:0] in;
	input [4:0] shiftAmt;
	
	output [31:0] out;
	
	wire [31:0] w1, w2, w3, w4, w5, out1, out2, out3, out4;
	
	// 16-bit shift
	genvar i;
	generate 
	for (i = 0; i < 16; i = i+1)
	begin : Bit16
		assign w1[i+16] = in[i];
	end
	endgenerate
	assign w1[15:0] = 16'b0;
	mux_2 first_mux(.out(out1), .in1(w1), .in0(in), .select(shiftAmt[4]));
	
	// 8-bit shift
	genvar j;
	generate 
	for (j = 0; j < 24; j = j+1)
	begin : Bit8
		assign w2[j+8] = out1[j];
	end
	endgenerate
	assign w2[7:0] = 8'b0;
	mux_2 second_mux(.out(out2), .in1(w2), .in0(out1), .select(shiftAmt[3]));
	
	// 4-bit shift
	genvar k;
	generate 
	for (k = 0; k < 28; k = k+1)
	begin : Bit4
		assign w3[k+4] = out2[k];
	end
	endgenerate
	assign w3[3:0] = 4'b0;
	mux_2 third_mux(.out(out3), .in1(w3), .in0(out2), .select(shiftAmt[2]));
	
	// 2-bit shift
	genvar l;
	generate 
	for (l = 0; l < 30; l = l+1)
	begin : Bit2
		assign w4[l+2] = out3[l];
	end
	endgenerate
	assign w4[1:0] = 2'b0;
	mux_2 fourth_mux(.out(out4), .in1(w4), .in0(out3), .select(shiftAmt[1]));

	// 1-bit shift
	genvar m;
	generate 
	for (m = 0; m < 31; m = m+1)
	begin : Bit1
		assign w5[m+1] = out4[m];
	end
	endgenerate
	assign w5[0] = 1'b0;
	mux_2 fifth_mux(.out(out), .in1(w5), .in0(out4), .select(shiftAmt[0]));

endmodule
