module counter(done, op_type, clk, reset);

	input op_type, clk, reset;
	
	output done;

	wire [32:0] shift_wire;

	assign shift_wire[0] = 1'b1;
	
	genvar i;
	generate
	for (i = 1; i < 33; i = i+1)
		begin : createDFFE
		DFFE_ref dffe(.q(shift_wire[i]), .d(shift_wire[i-1]), .clk(clk), .en(1'b1), .clr(reset));
		end
	endgenerate
	
	assign done = op_type ? shift_wire[31] : shift_wire[32];
	
endmodule
