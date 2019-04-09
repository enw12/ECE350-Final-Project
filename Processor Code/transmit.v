module transmit(rxd, rts, txd, cts, in);

	input rxd, cts, in;
	output txd, rts;
	
	always
	begin
	
		if (in)
			txd = 1;
		else 
			txd = 0;
	
	end
	

endmodule
