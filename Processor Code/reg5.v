module reg5(read_data, write_data, clk, enable, clr);
	
	input clk, enable, clr;
	input [4:0] write_data;
	
	output [4:0] read_data;
	
	genvar i;
	generate
	for (i = 0; i < 5; i = i+1)
		begin : createDFFE
		DFFE_ref dffe(.q(read_data[i]), .d(write_data[i]), .clk(clk), .en(enable), .clr(clr));
		end
	endgenerate

endmodule
