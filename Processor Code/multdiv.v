module multdiv(data_operandA, data_operandB, ctrl_MULT, ctrl_DIV, clock, data_result, data_exception, data_resultRDY);
   input [31:0] data_operandA, data_operandB;
   input ctrl_MULT, ctrl_DIV, clock;

   output [31:0] data_result;
   output data_exception, data_resultRDY;

	wire reset, ctrl_op, div, flip_inputA, flip_inputB, flip_result;
	wire [63:0] curr_data, new_data, reset_data, mult_result, div_result, op_result;
	wire [31:0] negA, negB, b_input, data_unedited, data_flipped;
	wire ovf0, ovf1, ovf2, e_sign, ovf_sign, div_ovf;
	
	// Determine if registers should be reset for new operation
	or determine_reset(reset, ctrl_MULT, ctrl_DIV);
	
	// Determine if using mult or div
	DFFE_ref mult_or_div(.q(ctrl_op), .d(ctrl_MULT), .clk(clock), .en(reset), .clr(1'b0));

	cla32 neg_A(.c_in(1'b1), .in1(32'b0), .in2(data_operandA), .sum(negA));
	cla32 neg_B(.c_in(1'b1), .in1(32'b0), .in2(data_operandB), .sum(negB));
	
	not is_divide(div, ctrl_op);
	and unsign_valA(flip_inputA, div, data_operandA[31]);
	and unsign_valB(flip_inputB, div, data_operandB[31]);
	xor res_flip(flip_result, flip_inputA, flip_inputB);
	
	assign b_input = flip_inputB ? negB : data_operandB;
	
	assign reset_data[63:32] = 32'b0;
	assign reset_data[31:0] = flip_inputA ? negA : data_operandA;
	
	// Create counter for mult to determine when result is ready
	counter my_count(.done(data_resultRDY), .op_type(ctrl_op), .clk(clock), .reset(reset));
	
	// Create 64 bit register to store product/quotient
	reg64 my_data(.read_data(curr_data), .write_data(new_data), .clk(clock), .enable(1'b1), .clr(1'b0));
	
	// Assign new data for register
	assign op_result = ctrl_op ? mult_result : div_result; 
	assign new_data = reset ? reset_data : op_result;
//	mux_2 new_val(.select(reset), .in0(op_result), .in1(reset_data), .out(new_data));
	
	// Add multiplier
	multiply my_mult(.product(mult_result), .ovf(ovf1), .multiplier(curr_data), .multiplicand(b_input), .clk(clock), .reset(reset));
	
	// Add divider
	divide my_div(.quotient(div_result), .ovf(), .curr_q(curr_data), .divisor(b_input), .clk(clock), .reset(reset));
	
	assign data_unedited = ctrl_op ? mult_result[31:0] : div_result[31:0];
	cla32 neg_result(.c_in(1'b1), .in1(32'b0), .in2(data_unedited), .sum(data_flipped));
	
	assign data_result = flip_result ? data_flipped : data_unedited;
	 
	// Determine data exception
//	xor expected_sign(e_sign, data_operandA[31], data_operandB[31]);
//	xor det_ovf2(ovf2, e_sign, data_result[31]);
	
//	or is_0(ovf0, data_result[31], data_result[30], data_result[29], data_result[28], data_result[27], data_result[26],
//	data_result[25], data_result[24], data_result[23], data_result[22], data_result[21], data_result[20], data_result[19],
//	data_result[18], data_result[17], data_result[16], data_result[15], data_result[14], data_result[13], data_result[12], 
//	data_result[11], data_result[10], data_result[9], data_result[8], data_result[7], data_result[6], data_result[5], 
//	data_result[4], data_result[3], data_result[2], data_result[1], data_result[0]);
	
//	assign ovf_sign = ovf0 ? ovf2 : ovf0;
	
//	nor div_0(div_ovf, data_operandB[31], data_operandB[30], data_operandB[29], data_operandB[28], data_operandB[27], 
//		data_operandB[26], data_operandB[25], data_operandB[24], data_operandB[23], data_operandB[22], data_operandB[21], 
//		data_operandB[20], data_operandB[19], data_operandB[18], data_operandB[17], data_operandB[16], data_operandB[15], 
//		data_operandB[14], data_operandB[13], data_operandB[12], data_operandB[11], data_operandB[10], data_operandB[9], 
//		data_operandB[8], data_operandB[7], data_operandB[6], data_operandB[5], data_operandB[4], data_operandB[3], 
//		data_operandB[2], data_operandB[1], data_operandB[0]);
	
	or exception(data_exception, ovf1, ovf_sign, div_ovf);
	
endmodule
