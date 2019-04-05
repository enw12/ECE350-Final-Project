module alu(resRDY, data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, clock, data_result, isNotEqual, isLessThan, overflow, dataRDY);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;
	input clock;
	
   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow, dataRDY;
	
	//TEST
	output resRDY;
	
	wire [31:0] ctrlDec, claResult, andResult, orResult, shiftLeftResult, shiftRightResult, multdivResult;
	wire stall, stall_in, ctrl_mult, ctrl_div, cla_ovf, multdiv_ovf;

	// Decode opcode and shift amount
	dec5to32 opcode_decode(.out(ctrlDec), .In(ctrl_ALUopcode));

	// Adder and subtracter
	cla32 addSub(.sum(claResult), .ovf(cla_ovf), .not_equal(isNotEqual), 
					 .less_than(isLessThan), .c_in(ctrlDec[1]), .in1(data_operandA), .in2(data_operandB));
	
	// Bitwise And and Or
	and32 andBitwise(.out(andResult), .in1(data_operandA), .in2(data_operandB));
	or32 orBitwise(.out(orResult), .in1(data_operandA), .in2(data_operandB));

	// Shifters
	left_shift shiftLeft(.out(shiftLeftResult), .in(data_operandA), .shiftAmt(ctrl_shiftamt));
	right_shift shiftRight(.out(shiftRightResult), .in(data_operandA), .shiftAmt(ctrl_shiftamt));
	
	// Ctrl_Mult and Ctrl_Div
	or stallCtrl(stall_in, ctrlDec[6], ctrlDec[7]);
	
	DFFE_ref multCtrl(.q(stall), .d(1'b1), .clk(clock), .en(stall_in), .clr(dataRDY));

	and mCtrl(ctrl_mult, ~stall, ctrlDec[6]);
	and dCtrl(ctrl_div, ~stall, ctrlDec[7]);

	// Mult Div
	multdiv my_multdiv(.data_operandA(data_operandA), .data_operandB(data_operandB), 
			.ctrl_MULT(ctrl_mult), .ctrl_DIV(ctrl_div), .clock(clock), .data_result(multdivResult), 
			.data_exception(multdiv_ovf), .data_resultRDY(resRDY));
	
	or det_ovf(overflow, cla_ovf, multdiv_ovf);
	
	// Decide which result to pass on
	assign data_result = ctrlDec[0] ? claResult : 32'bz;
	assign data_result = ctrlDec[1] ? claResult : 32'bz;
	assign data_result = ctrlDec[2] ? andResult : 32'bz;
	assign data_result = ctrlDec[3] ? orResult : 32'bz;
	assign data_result = ctrlDec[4] ? shiftLeftResult : 32'bz;
	assign data_result = ctrlDec[5] ? shiftRightResult : 32'bz;
	assign data_result = ctrlDec[6] ? multdivResult : 32'bz;
	assign data_result = ctrlDec[7] ? multdivResult : 32'bz;

	or det_ready(dataRDY, ctrlDec[0], ctrlDec[1], ctrlDec[2], ctrlDec[3], ctrlDec[4], ctrlDec[5], resRDY);
	
endmodule
