/**
 * NOTE: you should not need to change this file! This file will be swapped out for a grading
 * "skeleton" for testing. We will also remove your imem and dmem file.
 *
 * NOTE: skeleton should be your top-level module!
 *
 * This skeleton file serves as a wrapper around the processor to provide certain control signals
 * and interfaces to memory elements. This structure allows for easier testing, as it is easier to
 * inspect which signals the processor tries to assert when.
 */

module skeleton(clock, reset, // data_writeReg, ctrl_writeReg, ctrl_writeEnable, ALU_rdy, mdRDY, stop, 
		in_fd, in_back, in_left, in_right, out, out_signal, Rx);
    input clock, reset;
	 //TEST
//	 output [31:0] data_writeReg;
//	 output [4:0] ctrl_writeReg;
//	 output ctrl_writeEnable, ALU_rdy, mdRDY, stop;

	 input in_fd, in_back, in_left, in_right;
	 output out;
	 output [7:0] out_signal;
	 
	 input Rx;
	 
	 /**Custom for Final**/
	 reg [7:0] out_reg;
	 assign out_signal = out_reg;
	 
	 reg transmit;
	 wire t_enable, transmit_active;
//	 wire out_inv;
	
//	 async_transmitter myTransmit(.clk(clock), .TxD_start(~busy), .TxD_data(out_reg), .TxD(out), .TxD_busy(busy));	
//	 UART_rs232_tx myTransmit(.Clk(clock), .Rst_n(~reset), .TxEn(TxEnable), .TxData(out_reg), .TxDone(TxDone), 
//			.Tx(out), .Tick(tick), .NBits(4'b1000));
//			
//	 UART_BaudRate_generator(.Clk(clock), .Rst_n(~reset), .Tick(tick), .BaudRate(16'd325));
			

//wire				Tx;
//wire [7:0]    	TxData     	; // Data to transmit.
//wire          	RxDone          ; // Reception completed. Data is valid.
//wire          	TxDone          ; // Trnasmission completed. Data sent.
//wire            tick		; // Baud rate clock
//reg          	TxEn            ;
//wire 		RxEn		;
//wire [3:0]      NBits    	;
//wire [15:0]    	BaudRate        ; //328; 162 etc... (Read comment in baud rate generator file)
///////////////////////////////////////////////////////////////////////////////////////////
//assign 		RxEn = 1'b1	;
////assign 		BaudRate = 16'd325; 	//baud rate set to 9600 for the HC-06 bluetooth module. Why 325? (Read comment in baud rate generator file)
//assign		BaudRate = 16'd5;
//assign 		NBits = 4'b1000	;	//We send/receive 8 bits
/////////////////////////////////////////////////////////////////////////////////////////


//Make connections between Rx module and TOP inputs and outputs and the other modules
//UART_rs232_rx I_RS232RX(
//    	.Clk(clock)             	,
//   	.Rst_n(~reset)         	,
//    	.RxEn(RxEn)           	,
//    	.RxData(RxData)       	,
//    	.RxDone(RxDone)       	,
//    	.Rx(Rx)               	,
//    	.Tick(tick)           	,
//    	.NBits(NBits)
//    );

//Make connections between Tx module and TOP inputs and outputs and the other modules
//UART_rs232_tx I_RS232TX(
//   	.Clk(clock)            	,
//    	.Rst_n(~reset)         	,
//    	.TxEn(1'b1)           	,
//    	.TxData(out_reg)      	,
//   	.TxDone(TxDone)      	,
//   	.Tx(Tx)               	,
//   	.Tick(tick)           	,
//   	.NBits(NBits)
//    );


		assign t_enable = ~transmit_active & transmit;

//		uart_tx myTransmit(.i_Clock(clock), .i_Tx_DV(t_enable), .i_Tx_Byte(out_reg), 
//			.o_Tx_Active(transmit_active), .o_Tx_Serial(out), .o_Tx_Done());	

		test myTransmit(
				.from_uart_ready(transmit), 						// avalon_data_receive_source.ready
				.from_uart_data(),  						//                           .data
				.from_uart_error(), 						//                           .error
				.from_uart_valid(), 						//                           .valid
				.to_uart_data(out_reg),    			//  avalon_data_transmit_sink.data
				.to_uart_error(1'b0),   						//                           .error
				.to_uart_valid(transmit), 		  				//                           .valid
				.to_uart_ready(),   						//                           .ready
				.clk(clock),          				   //                        clk.clk
				.UART_RXD(),        						//         external_interface.RXD
				.UART_TXD(out),      				   //                           .TXD
				.reset(reset)   
		);

//		assign out = ~out_inv;
				
//Make connections between tick generator module and TOP inputs and outputs and the other modules
//UART_BaudRate_generator I_BAUDGEN(
//    	.Clk(clock)               ,
//    	.Rst_n(~reset)           ,
//    	.Tick(tick)             ,
//    	.BaudRate(BaudRate)
//    );
			
			
	 always @(posedge clock)
	 begin
	 	
		transmit = ~in_fd || ~in_back || ~in_left || ~in_right;
		
		if (~in_fd && in_back && in_left && in_right && ~stop)
			out_reg = 8'b00000001;
		else if (~in_fd && in_back && in_left && ~in_right && ~stop)
			out_reg = 8'b00000010;
		else if (in_fd && in_back && in_left && ~in_right)
			out_reg = 8'b00000011;
		else if (in_fd && ~in_back && in_left && ~in_right)
			out_reg = 8'b00000100;
		else if (in_fd && ~in_back && in_left && in_right)
			out_reg = 8'b00000101;
		else if (in_fd && ~in_back && ~in_left && in_right)
			out_reg = 8'b00000110;
		else if (in_fd && in_back && ~in_left && in_right)
			out_reg = 8'b00000111;
		else if (~in_fd && in_back && ~in_left && in_right && ~stop)	
			out_reg = 8'b00001000;
		else 
			out_reg = 8'b00000000;
	 end
	 
	 
    /** IMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!
    wire [11:0] address_imem;
    wire [31:0] q_imem;
    imem my_imem(
        .address    (address_imem),            // address of data
        .clock      (~clock),                  // you may need to invert the clock
        .q          (q_imem)                   // the raw instruction
    );

    /** DMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!
    wire [11:0] address_dmem;
    wire [31:0] data;
    wire wren;
    wire [31:0] q_dmem;
    dmem my_dmem(
        .address    (/* 12-bit wire */),       // address of data
        .clock      (~clock),                  // may need to invert the clock
        .data	    (/* 32-bit data in */),    // data you want to write
        .wren	    (/* 1-bit signal */),      // write enable
        .q          (/* 32-bit data out */)    // data from dmem
    );

    /** REGFILE **/
    // Instantiate your regfile
    //wire ctrl_writeEnable;
    //wire [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    // TEST TAKE OUT
	 wire [4:0] ctrl_readRegA, ctrl_readRegB;
	 //wire [31:0] data_writeReg;
    wire [31:0] data_readRegA, data_readRegB;
    regfile my_regfile(
        clock,
        ctrl_writeEnable,
        ctrl_reset,
        ctrl_writeReg,
        ctrl_readRegA,
        ctrl_readRegB,
        data_writeReg,
        data_readRegA,
        data_readRegB
    );

    /** PROCESSOR **/
	 assign custom_in = 32'd3;
	 
    processor my_processor(
        // Custom
		  custom_in,
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
    
		  ALU_rdy, mdRDY
	 
	 );

endmodule
