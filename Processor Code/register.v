module register(read_data, write_data, clk, enable, clr);
	
	input clk, enable, clr;
	input [31:0] write_data;
	
	output [31:0] read_data;
	
	DFFE_ref dffe_0(.q(read_data[0]), .d(write_data[0]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_1(.q(read_data[1]), .d(write_data[1]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_2(.q(read_data[2]), .d(write_data[2]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_3(.q(read_data[3]), .d(write_data[3]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_4(.q(read_data[4]), .d(write_data[4]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_5(.q(read_data[5]), .d(write_data[5]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_6(.q(read_data[6]), .d(write_data[6]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_7(.q(read_data[7]), .d(write_data[7]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_8(.q(read_data[8]), .d(write_data[8]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_9(.q(read_data[9]), .d(write_data[9]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_10(.q(read_data[10]), .d(write_data[10]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_11(.q(read_data[11]), .d(write_data[11]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_12(.q(read_data[12]), .d(write_data[12]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_13(.q(read_data[13]), .d(write_data[13]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_14(.q(read_data[14]), .d(write_data[14]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_15(.q(read_data[15]), .d(write_data[15]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_16(.q(read_data[16]), .d(write_data[16]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_17(.q(read_data[17]), .d(write_data[17]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_18(.q(read_data[18]), .d(write_data[18]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_19(.q(read_data[19]), .d(write_data[19]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_20(.q(read_data[20]), .d(write_data[20]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_21(.q(read_data[21]), .d(write_data[21]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_22(.q(read_data[22]), .d(write_data[22]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_23(.q(read_data[23]), .d(write_data[23]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_24(.q(read_data[24]), .d(write_data[24]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_25(.q(read_data[25]), .d(write_data[25]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_26(.q(read_data[26]), .d(write_data[26]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_27(.q(read_data[27]), .d(write_data[27]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_28(.q(read_data[28]), .d(write_data[28]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_29(.q(read_data[29]), .d(write_data[29]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_30(.q(read_data[30]), .d(write_data[30]), .clk(clk), .en(enable), .clr(clr));
	DFFE_ref dffe_31(.q(read_data[31]), .d(write_data[31]), .clk(clk), .en(enable), .clr(clr));

	
endmodule
