module dec5to32(out, In);

	//declare inputs and outputs
	input [4:0] In;
	output [31:0] out;
	
	//declare nIn (the NOT of the input)
	wire [4:0] nIn;
	
	//wire in through not gates to nIn
	not not0(nIn[0], In[0]);
	not not1(nIn[1], In[1]);
	not not2(nIn[2], In[2]);
	not not3(nIn[3], In[3]);
	not not4(nIn[4], In[4]);

	//decode with AND gates
	and and0(out[0], nIn[4], nIn[3], nIn[2], nIn[1], nIn[0]); 
	and and1(out[1], nIn[4], nIn[3], nIn[2], nIn[1], In[0]); 
	and and2(out[2], nIn[4], nIn[3], nIn[2], In[1], nIn[0]); 
	and and3(out[3], nIn[4], nIn[3], nIn[2], In[1], In[0]); 
	and and4(out[4], nIn[4], nIn[3], In[2], nIn[1], nIn[0]); 
	and and5(out[5], nIn[4], nIn[3], In[2], nIn[1], In[0]); 
	and and6(out[6], nIn[4], nIn[3], In[2], In[1], nIn[0]);
	and and7(out[7], nIn[4], nIn[3], In[2], In[1], In[0]);
	and and8(out[8], nIn[4], In[3], nIn[2], nIn[1], nIn[0]); 
	and and9(out[9], nIn[4], In[3], nIn[2], nIn[1], In[0]); 
	and and10(out[10], nIn[4], In[3], nIn[2], In[1], nIn[0]); 
	and and11(out[11], nIn[4], In[3], nIn[2], In[1], In[0]); 
	and and12(out[12], nIn[4], In[3], In[2], nIn[1], nIn[0]); 
	and and13(out[13], nIn[4], In[3], In[2], nIn[1], In[0]); 
	and and14(out[14], nIn[4], In[3], In[2], In[1], nIn[0]);
	and and15(out[15], nIn[4], In[3], In[2], In[1], In[0]);
	and and16(out[16], In[4], nIn[3], nIn[2], nIn[1], nIn[0]); 
	and and17(out[17], In[4], nIn[3], nIn[2], nIn[1], In[0]); 
	and and18(out[18], In[4], nIn[3], nIn[2], In[1], nIn[0]); 
	and and19(out[19], In[4], nIn[3], nIn[2], In[1], In[0]); 
	and and20(out[20], In[4], nIn[3], In[2], nIn[1], nIn[0]); 
	and and21(out[21], In[4], nIn[3], In[2], nIn[1], In[0]); 
	and and22(out[22], In[4], nIn[3], In[2], In[1], nIn[0]);
	and and23(out[23], In[4], nIn[3], In[2], In[1], In[0]);
	and and24(out[24], In[4], In[3], nIn[2], nIn[1], nIn[0]); 
	and and25(out[25], In[4], In[3], nIn[2], nIn[1], In[0]); 
	and and26(out[26], In[4], In[3], nIn[2], In[1], nIn[0]); 
	and and27(out[27], In[4], In[3], nIn[2], In[1], In[0]); 
	and and28(out[28], In[4], In[3], In[2], nIn[1], nIn[0]); 
	and and29(out[29], In[4], In[3], In[2], nIn[1], In[0]); 
	and and30(out[30], In[4], In[3], In[2], In[1], nIn[0]);
	and and31(out[31], In[4], In[3], In[2], In[1], In[0]);
	
endmodule
