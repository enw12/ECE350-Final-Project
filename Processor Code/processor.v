/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Custom
	 forward_data,
	 stop,
	 
	 // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB,                   // I: Data from port B of regfile

	 // TESTING
	 ALU_rdy,
	 mdRDY
);
    // Custom
	 input [31:0] forward_data;
	 output stop;
	 
	 // Control signals
    input clock, reset;
	 
    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;
	 
	 // TESTING
	 output ALU_rdy, mdRDY;
	 
	 // Custom wire
	 wire stop_in;
	 
	 // Transition Wires
	 wire [31:0] jumpPC, branchPC, branchPC_store, altPC;
	 wire stall, flush, ctrl_jump, will_branch, ctrl_branch, bne, blt;
	 
	 // Bypass Wires
	 wire XA_Bypass, XB_Bypass, will_writeX, bypass_XA, bypass_XB;
	 wire MA_Bypass, MB_Bypass, will_writeM, bypass_MA, bypass_MB;
	 wire [31:0] bypass1A, bypass1B;
	 
	 // Fetch Wires
	 wire [31:0] PC_in, imem_index, new_imem_address, normal_flow_address, FD, FD_in_init, FD_in, PC_D;
	 
	 // Decode Wires
	 wire [4:0] opcode, rd, rs, rt, shamt, ALUOp, iALU, ALU_store;
	 wire [31:0] decoded_opcode, immediate, target, data2, data_store_1, data_store_2;
	 wire rType, iType, j1Type, j2Type, iBranch, det_rdrt;
	 
	 wire [31:0] regStore1_init, regStore2_init, opStoreX_init, imm_inX_init, target_inX_init, PC_inX_init;
	 wire [4:0] alu_op_store_init, shamt_store_init, rd_store_init;
	 
	 wire [31:0] regStore1, regStore2, opStoreX, imm_inX, target_inX, PC_inX;
	 wire [4:0] alu_op_store, shamt_store, rd_store;
	 
	 // Execute Wires
	 wire [31:0] ALU_data2, ALU_in1, ALU_in2, ALU_in2Custom, ALU_out, imm_X, target_X, op_XM, PC_XM, data_unaltered, alt_data_val;
	 wire [4:0] ALU_op_in, ALU_op_inStore, shamt_in, rd_XM;
	 wire iTypeX, ne, lt, ovf, ALU_rdy, alt_data;
	
	 wire [31:0] ALU_out_XM, data_unaltered_XM, op_XM_store;
	 wire [4:0] rd_XM_store;
	 wire will_branch_XM;
	 
	 wire [31:0] ALU_decoded_opcode, ALU_ovf0, ovf_data, ALU_out1;
	 wire [4:0] rd_XM1;
	 
	 wire [31:0] ALU_out_XM_init, op_XM_store_init, ALU_opcodeCtrl;
	 wire [4:0] rd_XM_store_init;
	 wire multOrdiv;
	 
	 // Memory Wires
	 wire [31:0] mem_in, mw_store, write_dataReg, op_MW, PC_MW;
	 wire [4:0] rd_MW;
	 
	 // Write Wires
	 wire [31:0] op_final, data_write1, data_write2;
	 wire [4:0] writeReg1, alt_writeReg;
	 wire allow_write, det_data;
	 
	 // Stall Logic
	 assign stall = ~ALU_rdy;
	 or det_flush(flush, ctrl_jump, ctrl_branch);
	 
	 // IMEM Integration
	 assign normal_flow_address = stall ? imem_index : new_imem_address;
	 assign altPC = ctrl_jump ? jumpPC : 32'bz;
	 assign altPC = ctrl_branch ? branchPC : 32'bz;
	 assign PC_in = flush ? altPC : normal_flow_address;
	 register PC(.write_data(PC_in), .clk(clock), .enable(1'b1), .clr(reset), .read_data(imem_index));
	 assign address_imem = imem_index[11:0];
	 
	 // Next PC
	 cla32 det_nextPC(.sum(new_imem_address), .c_in(1'b0), .in1(imem_index), .in2(32'b1));
	 
	 // FD Register
	 assign FD_in_init = stall ? FD : q_imem;
	 assign FD_in = flush ? 32'b0 : FD_in_init;
	 register FtoD(.write_data(FD_in), .clk(clock), .enable(1'b1), .clr(reset), .read_data(FD));
	 register FD_PC(.write_data(new_imem_address), .clk(clock), .enable(1'b1), .clr(reset), .read_data(PC_D));
	 
	 // Decode Instruction
	 decoder (.instruction(FD), .opcode(opcode), .rd(rd), .rs(rs), .rt(rt), .shamt(shamt), .ALUOp(ALUOp), 
			.immediate(immediate), .target(target));
	
	 dec5to32 opcode_decoder(.In(opcode), .out(decoded_opcode));
	
	 or rOr(rType, decoded_opcode[0]);
	 or iOr(iType, decoded_opcode[2], decoded_opcode[5], decoded_opcode[6], decoded_opcode[7], decoded_opcode[8], decoded_opcode[9]);
	 or j1Or(j1Type, decoded_opcode[1], decoded_opcode[3], decoded_opcode[21], decoded_opcode[22]);
	 or j2Or(j2Type, decoded_opcode[4]);
	 
	 or i_isBranch(iBranch, decoded_opcode[2], decoded_opcode[6], decoded_opcode[9]);
	 assign iALU = iBranch ? 5'b00001 : 5'b00000;
	 
	 assign ALU_store = iType ? iALU : ALUOp;
	 
	 or second_readReg(det_rdrt, decoded_opcode[7], iBranch, j2Type);
	  
	 // DX Stage
	 assign ctrl_readRegA = rs;
	 assign ctrl_readRegB = det_rdrt ? rd : rt;
	 
	 // Bypassing
	 check_equal rdM_regA(.in1(rd_MW), .in2(ctrl_readRegA), .equal(MA_Bypass));
	 check_equal rdM_regB(.in1(rd_MW), .in2(ctrl_readRegB), .equal(MB_Bypass));
	 or check_writeM(will_writeM, op_MW[0], op_MW[5], op_MW[8]);
	 and bypassMtoA(bypass_MA, will_writeM, MA_Bypass);
	 and bypassMtoB(bypass_MB, will_writeM, MB_Bypass);	 
	 
	 assign bypass1A = bypass_MA ? mw_store : data_readRegA;
	 assign bypass1B = bypass_MB ? mw_store : data_readRegB;
	 
	 check_equal rdX_regA(.in1(rd_XM), .in2(ctrl_readRegA), .equal(XA_Bypass));
	 check_equal rdX_regB(.in1(rd_XM), .in2(ctrl_readRegB), .equal(XB_Bypass));
	 or check_writeX(will_writeX, op_XM[0], op_XM[5]);
	 and bypassXtoA(bypass_XA, will_writeX, XA_Bypass);
	 and bypassXtoB(bypass_XB, will_writeX, XB_Bypass);
	 
	 assign data_store_1 = bypass_XA ? ALU_out : bypass1A;
	 assign data_store_2 = bypass_XB ? ALU_out : bypass1B;
	 	 
	 // Store inputs to ALU
	 assign regStore1_init = stall ? ALU_in1 : data_store_1;
	 assign regStore2_init = stall ? ALU_data2 : data_store_2;
	 assign opStoreX_init = stall ? op_XM : decoded_opcode;
	 assign imm_inX_init = stall ? imm_X : immediate;
	 assign target_inX_init = stall ? target_X : target;
	 assign alu_op_store_init = stall ? ALU_op_in : ALU_store;
	 assign shamt_store_init = stall ? shamt_in : shamt;
	 assign rd_store_init = stall ? rd_XM : rd;
	 assign PC_inX_init = stall ? PC_XM : PC_D;

	 assign regStore1 = flush ? 32'b0 : regStore1_init;
	 assign regStore2 = flush ? 32'b0 : regStore2_init;
	 assign opStoreX = flush ? 32'b0 : opStoreX_init;
	 assign imm_inX = flush ? 32'b0 : imm_inX_init;
	 assign target_inX = flush ? 32'b0 : target_inX_init;
	 assign alu_op_store = flush ? 5'b0 : alu_op_store_init;
	 assign shamt_store = flush ? 5'b0 : shamt_store_init;
	 assign rd_store = flush ? 5'b0 : rd_store_init;
	 assign PC_inX = flush ? 32'b0 : PC_inX_init;
	
	 register Data_1(.write_data(regStore1), .clk(clock), .enable(1'b1), .clr(reset), .read_data(ALU_in1));
	 register Data_2(.write_data(regStore2), .clk(clock), .enable(1'b1), .clr(reset), .read_data(ALU_data2));
	 register op_storeX(.write_data(opStoreX), .clk(clock), .enable(1'b1), .clr(reset), .read_data(op_XM));
	 register Imm_Reg(.write_data(imm_inX), .clk(clock), .enable(1'b1), .clr(reset), .read_data(imm_X));
	 register Tar_Reg(.write_data(target_inX), .clk(clock), .enable(1'b1), .clr(reset), .read_data(target_X));
	 reg5 alu_op(.write_data(alu_op_store), .clk(clock), .enable(1'b1), .clr(reset), .read_data(ALU_op_in));
	 reg5 shamt_storeReg(.write_data(shamt_store), .clk(clock), .enable(1'b1), .clr(reset), .read_data(shamt_in));
	 reg5 rd_storeReg(.write_data(rd_store), .clk(clock), .enable(1'b1), .clr(reset), .read_data(rd_XM));
	 register PC_storeReg(.write_data(PC_inX), .clk(clock), .enable(1'b1), .clr(reset), .read_data(PC_XM));
	 	 
	 // Execute
	 or iOrX(iTypeX, op_XM[5], op_XM[7], op_XM[8]);
	 assign ALU_in2 = iTypeX ? imm_X : ALU_data2;
	 
	 or det_jump(ctrl_jump, op_XM[1], op_XM[3], op_XM[4]);
	 assign jumpPC = op_XM[4] ? ALU_data2 : target_X;
	 
	 assign ALU_in2Custom = op_XM[9] ? forward_data : ALU_in2;
	 
	 alu my_alu(.data_operandA(ALU_in1), .data_operandB(ALU_in2Custom), .ctrl_ALUopcode(ALU_op_in), 
			.ctrl_shiftamt(shamt_in), .clock(clock), .data_result(ALU_out), .isNotEqual(ne), .isLessThan(lt), 
			.overflow(ovf), .dataRDY(ALU_rdy), .resRDY(mdRDY)); 
	 
	 and det_bne(bne, op_XM[2], ne);
	 and det_blt(blt, op_XM[6], ne, ~lt);
	 or det_branch(will_branch, bne, blt);
	 cla32 branch_PC(.sum(branchPC_store), .c_in(1'b0), .in1(PC_XM), .in2(imm_X));
	 
	 // Custom
	 and det_stop(stop_in, op_XM[9], ne, ~lt);
	 DFFE_ref stop_store(.q(stop), .d(stop_in), .clk(clock), .en(op_XM[9]), .clr(reset));

	 or det_alt_data(alt_data, op_XM[3], op_XM[21]);
	 assign alt_data_val = op_XM[3] ? PC_XM : target_X;
	 assign data_unaltered = alt_data ? alt_data_val : ALU_data2;
	 
	 // XM Stage
	 assign ALU_out_XM = ctrl_branch ? 32'b0 : ALU_out;
	 assign data_unaltered_XM = ctrl_branch ? 32'b0 : data_unaltered;
	 assign op_XM_store = ctrl_branch ? 32'b0 : op_XM;
	 assign rd_XM_store = ctrl_branch ? 5'b0 : rd_XM;
	 assign will_branch_XM = ctrl_branch ? 1'b0 : will_branch;
	 
	 register XtoM(.write_data(ALU_out_XM), .clk(clock), .enable(1'b1), .clr(reset), .read_data(mem_in));
	 register write_DataXM(.write_data(data_unaltered_XM), .clk(clock), .enable(1'b1), .clr(reset), .read_data(write_dataReg));
	 register op_storeXM(.write_data(op_XM_store), .clk(clock), .enable(1'b1), .clr(reset), .read_data(op_MW));	
	 reg5 rd_storeXM(.write_data(rd_XM_store), .clk(clock), .enable(1'b1), .clr(reset), .read_data(rd_MW));
	 DFFE_ref branch_indicator(.q(ctrl_branch), .d(will_branch_XM), .clk(clock), .en(1'b1), .clr(reset));
	 register branch_store(.write_data(branchPC_store), .clk(clock), .enable(1'b1), .clr(reset), .read_data(branchPC));
	 
	 // Memory
	 assign wren = op_MW[7];
	 assign address_dmem = mem_in[11:0];
	 assign data = write_dataReg;
	 
	 assign mw_store = op_MW[8] ? q_dmem : mem_in;
	 
	 // MW Stage
	 register MtoW(.write_data(mw_store), .clk(clock), .enable(1'b1), .clr(reset), .read_data(data_write1));
	 register op_storeMW(.write_data(op_MW), .clk(clock), .enable(1'b1), .clr(reset), .read_data(op_final));	
	 reg5 rd_storeMW(.write_data(rd_MW), .clk(clock), .enable(1'b1), .clr(reset), .read_data(writeReg1));
	 register altRegDataStore(.write_data(write_dataReg), .clk(clock), .enable(1'b1), .clr(reset), .read_data(data_write2));
	 
	 // Write
	 or det_write(allow_write, op_final[0], op_final[5], op_final[8]);
	 or which_data(det_data, op_final[3], op_final[21]);
	 assign alt_writeReg = op_final[3] ? 5'b11111 : 5'b11110; 
	 assign ctrl_writeReg = det_data ? alt_writeReg : writeReg1;
	 assign data_writeReg = det_data ? data_write2 : data_write1;
	 assign ctrl_writeEnable = allow_write ? 1'b1 : 1'b0;
	 
endmodule
