module FS_Datapath(
			//input
			refPxl, 
			selPxl1, selPxl2, selPxl3, selPxl4, selPxl5, selPxl6, 
			selPxl7, selPxl8, selPxl9, selPxl10, selPxl11, selPxl12, 
			selPxl13, selPxl14,selPxl15, selPxl16, 
			Threshold,isCorner,
			refAddr,
			//output
			scoreVal, 
			//writeEn, 
			outrefPxl, 
			outrefAddr
			);
				
	input	[7:0] 	 	refPxl, selPxl1, selPxl2, selPxl3, selPxl4, 
							selPxl5, selPxl6, selPxl7, selPxl8, selPxl9, 
							selPxl10, selPxl11, selPxl12, selPxl13, selPxl14, 
							selPxl15, selPxl16, Threshold;
	input	[14:0] 	 	refAddr;
	
	input isCorner;
	
	//output writeEn;
	output	[7:0] 	outrefPxl;
	output	[11:0] 	scoreVal;
	output	[14:0] 	outrefAddr;
	
	wire [7:0] 	tmpRefpxl;
	wire [14:0] tmpRefAddr;
   wire [7:0] 	compare_row, compare_high;
	wire [31:0] Scorerow;
	wire [11:0] BrightSum, DarkSum;
	wire [15:0] tempPxl1, tempPxl2, tempPxl3, tempPxl4,
					tempPxl5, tempPxl6, tempPxl7, tempPxl8,
					tempPxl9, tempPxl10, tempPxl11, tempPxl12,
					tempPxl13, tempPxl14, tempPxl15, tempPxl16;
				  
	wire 			[8:0] Clip_brighter;
	wire signed	[8:0] Clip_darker;
	
	assign tmpRefAddr	= 	refAddr;
	assign tmpRefpxl 	= 	refPxl;
	assign outrefAddr = 	tmpRefAddr;
	assign outrefPxl 	=  tmpRefpxl;
	
	assign Clip_brighter = refPxl + Threshold;
	assign Clip_darker 	= refPxl - Threshold;
	
	assign compare_high 	= (Clip_brighter > 9'hff) ? 8'hff : Clip_brighter;
	assign compare_row 	= (Clip_darker < 0) ? 8'h0 : Clip_darker;
	
	
	///////////////////////Comprare This smaller than compare_row  then, darkSet
	/////////////////////// Bigger than compare_high then, dark
	// 01 = brighter , 00 = darker , 10 = similar
	
	assign Scorerow[1:0] = (selPxl1<=compare_row) ? 2'b0 : ((selPxl1>=compare_high) ? 2'b1 : 2'b10);
	assign Scorerow[3:2] = (selPxl2<=compare_row) ? 2'b0 : ((selPxl2>=compare_high) ? 2'b1 : 2'b10);
	assign Scorerow[5:4] = (selPxl3<=compare_row) ? 2'b0 : ((selPxl3>=compare_high) ? 2'b1 : 2'b10);
	assign Scorerow[7:6] = (selPxl4<=compare_row) ? 2'b0 : ((selPxl4>=compare_high) ? 2'b1 : 2'b10);
	assign Scorerow[9:8] = (selPxl5<=compare_row) ? 2'b0 : ((selPxl5>=compare_high) ? 2'b1 : 2'b10);
	assign Scorerow[11:10] = (selPxl6<=compare_row) ? 2'b0 : ((selPxl6>=compare_high) ? 2'b1 : 2'b10);
	assign Scorerow[13:12] = (selPxl7<=compare_row) ? 2'b0 : ((selPxl7>=compare_high) ? 2'b1 : 2'b10);
	assign Scorerow[15:14] = (selPxl8<=compare_row) ? 2'b0 : ((selPxl8>=compare_high) ? 2'b1 : 2'b10);
	assign Scorerow[17:16] = (selPxl9<=compare_row) ? 2'b0 : ((selPxl9>=compare_high) ? 2'b1 : 2'b10);
	assign Scorerow[19:18] = (selPxl10<=compare_row) ? 2'b0 : ((selPxl10>=compare_high) ? 2'b1 : 2'b10);
	assign Scorerow[21:20] = (selPxl11<=compare_row) ? 2'b0 : ((selPxl11>=compare_high) ? 2'b1 : 2'b10);
	assign Scorerow[23:22] = (selPxl12<=compare_row) ? 2'b0 : ((selPxl12>=compare_high) ? 2'b1 : 2'b10);
	assign Scorerow[25:24] = (selPxl13<=compare_row) ? 2'b0 : ((selPxl13>=compare_high) ? 2'b1 : 2'b10);
	assign Scorerow[27:26] = (selPxl14<=compare_row) ? 2'b0 : ((selPxl14>=compare_high) ? 2'b1 : 2'b10);
	assign Scorerow[29:28] = (selPxl15<=compare_row) ? 2'b0 : ((selPxl15>=compare_high) ? 2'b1 : 2'b10);
	assign Scorerow[31:30] = (selPxl16<=compare_row) ? 2'b0 : ((selPxl16>=compare_high) ? 2'b1 : 2'b10);
	
	/////////////////
	
	//brighter
	assign tempPxl1[15:8] = (Scorerow[1:0] == 1) ? selPxl1 : 8'b0;
	assign tempPxl2[15:8] = (Scorerow[3:2] == 1) ? selPxl2 : 8'b0;
	assign tempPxl3[15:8] = (Scorerow[5:4] == 1) ? selPxl3 : 8'b0;
	assign tempPxl4[15:8] = (Scorerow[7:6] == 1) ? selPxl4 : 8'b0;
	assign tempPxl5[15:8] = (Scorerow[9:8] == 1) ? selPxl5 : 8'b0;
	assign tempPxl6[15:8] = (Scorerow[11:10] == 1) ? selPxl6 : 8'b0;
	assign tempPxl7[15:8] = (Scorerow[13:12] == 1) ? selPxl7 : 8'b0;
	assign tempPxl8[15:8] = (Scorerow[15:14] == 1) ? selPxl8 : 8'b0;
	assign tempPxl9[15:8] = (Scorerow[17:16] == 1) ? selPxl9 : 8'b0;
	assign tempPxl10[15:8] = (Scorerow[19:18] == 1) ? selPxl10 : 8'b0;
	assign tempPxl11[15:8] = (Scorerow[21:20] == 1) ? selPxl11 : 8'b0;
	assign tempPxl12[15:8] = (Scorerow[23:22] == 1) ? selPxl12 : 8'b0;
	assign tempPxl13[15:8] = (Scorerow[25:24] == 1) ? selPxl13 : 8'b0;
	assign tempPxl14[15:8] = (Scorerow[27:26] == 1) ? selPxl14 : 8'b0;
	assign tempPxl15[15:8] = (Scorerow[29:28] == 1) ? selPxl15 : 8'b0;
	assign tempPxl16[15:8] = (Scorerow[31:30] == 1) ? selPxl16 : 8'b0;
	
	assign BrightSum = tempPxl1[15:8] + tempPxl2[15:8] + tempPxl3[15:8] + tempPxl4[15:8] +
							 tempPxl5[15:8] + tempPxl6[15:8] + tempPxl7[15:8] + tempPxl8[15:8] +
							 tempPxl9[15:8] + tempPxl10[15:8] + tempPxl11[15:8] + tempPxl12[15:8] +
							 tempPxl13[15:8] + tempPxl14[15:8] + tempPxl15[15:8] + tempPxl16[15:8];
			
   //darker
	assign tempPxl1[7:0] = (Scorerow[1:0] == 0) ? selPxl1 : 8'b0;
	assign tempPxl2[7:0] = (Scorerow[3:2] == 0) ? selPxl2 : 8'b0;
	assign tempPxl3[7:0] = (Scorerow[5:4] == 0) ? selPxl3 : 8'b0;
	assign tempPxl4[7:0] = (Scorerow[7:6] == 0) ? selPxl4 : 8'b0;
	assign tempPxl5[7:0] = (Scorerow[9:8] == 0) ? selPxl5 : 8'b0;
	assign tempPxl6[7:0] = (Scorerow[11:10] == 0) ? selPxl6 : 8'b0;
	assign tempPxl7[7:0] = (Scorerow[13:12] == 0) ? selPxl7 : 8'b0;
	assign tempPxl8[7:0] = (Scorerow[15:14] == 0) ? selPxl8 : 8'b0;
	assign tempPxl9[7:0] = (Scorerow[17:16] == 0) ? selPxl9 : 8'b0;
	assign tempPxl10[7:0] = (Scorerow[19:18] == 0) ? selPxl10 : 8'b0;
	assign tempPxl11[7:0] = (Scorerow[21:20] == 0) ? selPxl11 : 8'b0;
	assign tempPxl12[7:0] = (Scorerow[23:22] == 0) ? selPxl12 : 8'b0;
	assign tempPxl13[7:0] = (Scorerow[25:24] == 0) ? selPxl13 : 8'b0;
	assign tempPxl14[7:0] = (Scorerow[27:26] == 0) ? selPxl14 : 8'b0;
	assign tempPxl15[7:0] = (Scorerow[29:28] == 0) ? selPxl15 : 8'b0;
	assign tempPxl16[7:0] = (Scorerow[31:30] == 0) ? selPxl16 : 8'b0;
	
	assign DarkSum = tempPxl1[7:0] + tempPxl2[7:0] + tempPxl3[7:0] + tempPxl4[7:0] +
						  tempPxl5[7:0] + tempPxl6[7:0] + tempPxl7[7:0] + tempPxl8[7:0] +
						  tempPxl9[7:0] + tempPxl10[7:0] + tempPxl11[7:0] + tempPxl12[7:0] +
						  tempPxl13[7:0] + tempPxl14[7:0] + tempPxl15[7:0] + tempPxl16[7:0];
					
	assign scoreVal =(isCorner)? ((DarkSum > BrightSum) ? DarkSum : BrightSum) : 12'b0;			
	
	//assign writeEn = 1'b1;
	
endmodule
