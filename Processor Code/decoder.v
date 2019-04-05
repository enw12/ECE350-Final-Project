module decoder(instruction, opcode, rd, rs, rt, shamt, ALUOp, immediate, target);

	input [31:0] instruction;
	output [4:0] opcode, rd, rs, rt, shamt, ALUOp;
	output [31:0] immediate, target;
	
	assign opcode = instruction[31:27];	
	assign rd = instruction[26:22];
	assign rs = instruction[21:17];
	assign rt = instruction[16:12];
	assign shamt = instruction[11:7];
	assign ALUOp = instruction[6:2];
	
	assign immediate[16:0] = instruction[16:0];
	genvar i;
	generate
	for (i = 17; i < 32; i = i+1)
		begin : sign_extend_immediate
		assign immediate[i] = immediate[16];
		end
	endgenerate
	
	assign target[26:0] = instruction[26:0];
	assign target[31:27] = 5'b0;
	
endmodule
