module divide(quotient, ovf, curr_q, divisor, clk, reset);

	input [63:0] curr_q;
	input [31:0] divisor;
	input clk, reset;
	
	output [63:0] quotient;
	output ovf;
	
	wire sub_ovf, div_exists;
	wire [31:0] new63to32, my_diff;
	wire [63:0] no_shift_quotient;
	
	// Add or sub multiplicand and stor overflow
	cla32 new32(.c_in(1'b1), .in1(curr_q[63:32]), .in2(divisor), .sum(my_diff), .ovf(sub_ovf));
	
	// Determine whether to use output of subtraction or original based on if result is < 0
	assign new63to32 = my_diff[31] ? curr_q[63:32] : my_diff;
	
	// Determine if dividend is 0
//	nor det_0(div_exists, curr_q[31], curr_q[30], curr_q[29], curr_q[28], curr_q[27], curr_q[26], curr_q[25], 
//		curr_q[24], curr_q[23], curr_q[22], curr_q[21], curr_q[20], curr_q[19], curr_q[18], curr_q[17], curr_q[16], 
//		curr_q[15], curr_q[14], curr_q[13], curr_q[12], curr_q[11], curr_q[10], curr_q[9], curr_q[8], curr_q[7], 
//		curr_q[6], curr_q[5], curr_q[4], curr_q[3], curr_q[2], curr_q[1], curr_q[0]);	
		
	// Get new val prior to shift
	assign no_shift_quotient[31:0] = curr_q[31:0];
	assign no_shift_quotient[63:32] = new63to32;
		
	// Shift val to get new data to put in register
	genvar i;
	generate
	for (i = 1; i < 64; i = i+1)
		begin : shiftQuotient
			assign quotient[i] = no_shift_quotient[i-1];
		end
	endgenerate
	
	assign quotient[0] = my_diff[31] ? 1'b0 : 1'b1;
	
	assign ovf = 1'b0;
	
endmodule