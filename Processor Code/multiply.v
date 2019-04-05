module multiply(product, ovf, multiplier, multiplicand, clk, reset);

	input [63:0] multiplier;
	input [31:0] multiplicand;
	input clk, reset;
	
	output [63:0] product;
	output ovf;
	
	wire ctrl_add_mult, ctrl_sub_mult, ctrl_no_change, not_last0, not_last1, c_in;
	wire curr_ovf, new_ovf, add_ovf, ovf1, ovf2;
	wire [1:0] last;
	wire [31:0] new63to32, my_sum;
	wire [63:0] no_shift_product;
	
	// Determine last 2 bits for Booth's Algorithm
	DFFE_ref store_last(.q(last[0]), .d(multiplier[0]), .clk(clk), .en(1'b1), .clr(reset));
	assign last[1] = multiplier[0];
	
	not not0(not_last0, last[0]);
	not not1(not_last1, last[1]);
	
	// Determine whether to add or sub multiplicand
	and add_mult(ctrl_add_mult, not_last1, last[0]);
	and sub_mult(ctrl_sub_mult, last[1], not_last0);
	nor no_change(ctrl_no_change, ctrl_add_mult, ctrl_sub_mult);
	
	// Determine carry in for adder based on add or sub 
	assign c_in = ctrl_add_mult ? 1'b0 : 1'bz;
	assign c_in = ctrl_sub_mult ? 1'b1 : 1'bz;
	
	// Add or sub multiplicand and stor overflow
	cla32 new32(.c_in(c_in), .in1(multiplier[63:32]), .in2(multiplicand), .sum(my_sum), .ovf(add_ovf));
	
	// Determine new data in bits 63:32 
	assign new63to32 = ctrl_no_change ? multiplier[63:32] : my_sum;
	
	// Get new val prior to shift
	assign no_shift_product[31:0] = multiplier[31:0];
	assign no_shift_product[63:32] = new63to32;
		
	// Shift val to get new data to put in register
	assign product = no_shift_product >>> 1;
	
	assign ovf = 1'b0;
	
endmodule
