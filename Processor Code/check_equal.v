module check_equal(in1, in2, equal);

	input [4:0] in1, in2;
	output equal;
	
	wire [4:0] claRes;
	wire not_zero, equalReg;
	
	cla5 calculate(.in1(in1), .in2(in2), .c_in(1'b1), .sum(claRes));
	
	or is_Zero(not_zero, in1[0], in1[1], in1[2], in1[3], in1[4]);
	
	nor check_zero(equalReg, claRes[0], claRes[1], claRes[2], claRes[3], claRes[4]);
	
	and ret_val(equal, not_zero, equalReg);
	
endmodule
