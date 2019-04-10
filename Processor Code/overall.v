module overall(clk, in_fd, in_back, in_left, in_right, out, inSwitch, outSwitch);

	input clk, in_fd, in_back, in_left, in_right;
	input inSwitch;
	
	output out;
	output outSwitch;
	
	wire busy;
	
	reg [7:0] out_reg;
	reg outSwitch_reg;
		
	async_transmitter myTransmit(.clk(clk), .TxD_start(~busy), .TxD_data(out_reg), .TxD(out), .TxD_busy(busy));	
	
	assign outSwitch = outSwitch_reg;
	
	always
	begin
		if (in_fd && ~in_back && ~in_left && ~in_right)
			out_reg = 8'b00000001;
		else if (in_fd && ~in_back && ~in_left && in_right)
			out_reg = 8'b00000010;
		else if (~in_fd && ~in_back && ~in_left && in_right)
			out_reg = 8'b00000011;
		else if (~in_fd && in_back && ~in_left && in_right)
			out_reg = 8'b00000100;
		else if (~in_fd && in_back && ~in_left && ~in_right)
			out_reg = 8'b00000101;
		else if (~in_fd && in_back && in_left && ~in_right)
			out_reg = 8'b00000110;
		else if (~in_fd && ~in_back && in_left && ~in_right)
			out_reg = 8'b00000111;
		else if (in_fd && ~in_back && in_left && ~in_right)	
			out_reg = 8'b00001000;
		else 
			out_reg = 8'b00000000;
			
		if (inSwitch)
			outSwitch_reg = 1'b1;
		else 
			outSwitch_reg = 1'b0;
		
	end

endmodule
