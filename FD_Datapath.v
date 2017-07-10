module FD_Datapath(refPxl, selPxl1, selPxl2, selPxl3, selPxl4, 
						 selPxl5, selPxl6, selPxl7, selPxl8, selPxl9, 
						 selPxl10, selPxl11, selPxl12, selPxl13, selPxl14, 
						 selPxl15, selPxl16, Threshold, FD_readEn,
						 
						 outrefPxl, outPxl1, outPxl2, outPxl3, outPxl4, 
						 outPxl5, outPxl6, outPxl7, outPxl8, outPxl9, 
						 outPxl10, outPxl11, outPxl12, outPxl13, outPxl14, 
						 outPxl15, outPxl16, outThreshold, 
						 
						 isCorner);
						 
	input [7:0] 	 refPxl, selPxl1, selPxl2, selPxl3, selPxl4, 
						 selPxl5, selPxl6, selPxl7, selPxl8, selPxl9, 
						 selPxl10, selPxl11, selPxl12, selPxl13, selPxl14, 
						 selPxl15, selPxl16, Threshold;
	input				 FD_readEn;
	
	output[7:0]		 outrefPxl, outPxl1, outPxl2, outPxl3, outPxl4, 
						 outPxl5, outPxl6, outPxl7, outPxl8, outPxl9, 
						 outPxl10, outPxl11, outPxl12, outPxl13, outPxl14, 
						 outPxl15, outPxl16, outThreshold;
						 
	output			 isCorner;
						 
	
	
	wire [31:0] cmp;
	
	wire [8:0] Clip_brighter;
	wire signed[8:0] Clip_darker;
	
	wire [7:0] brighter;
	wire [7:0] darker;

	wire result_cmp;
	
	assign Clip_brighter = refPxl + Threshold;
	assign Clip_darker = refPxl - Threshold;

	assign brighter = (Clip_brighter > 9'hff) ? 8'hff : Clip_brighter;
	assign darker = (Clip_darker < 0) ? 8'h0 : Clip_darker;
	
	
	assign cmp[0] = (selPxl1 >= brighter) & 
						 (selPxl2 >= brighter) &
						 (selPxl3 >= brighter) &
						 (selPxl4 >= brighter) &
						 (selPxl5 >= brighter) &
						 (selPxl6 >= brighter) &
						 (selPxl7 >= brighter) &
						 (selPxl8 >= brighter) &
						 (selPxl9 >= brighter);

	assign cmp[1] = (selPxl2 >= brighter) &
						 (selPxl3 >= brighter) &
						 (selPxl4 >= brighter) &
						 (selPxl5 >= brighter) &
						 (selPxl6 >= brighter) &
						 (selPxl7 >= brighter) &
						 (selPxl8 >= brighter) &
						 (selPxl9 >= brighter) &
						 (selPxl10 >= brighter);

	assign cmp[2] = (selPxl3 >= brighter) &
						 (selPxl4 >= brighter) &
						 (selPxl5 >= brighter) &
						 (selPxl6 >= brighter) &
						 (selPxl7 >= brighter) &
						 (selPxl8 >= brighter) &
						 (selPxl9 >= brighter) &
						 (selPxl10 >= brighter) &
						 (selPxl11 >= brighter);

	assign cmp[3] = (selPxl4 >= brighter) &
						 (selPxl5 >= brighter) &
						 (selPxl6 >= brighter) &
						 (selPxl7 >= brighter) &
						 (selPxl8 >= brighter) &
						 (selPxl9 >= brighter) &
						 (selPxl10 >= brighter) &
						 (selPxl11 >= brighter) &
						 (selPxl12 >= brighter);

	assign cmp[4] = (selPxl5 >= brighter) &
						 (selPxl6 >= brighter) &
						 (selPxl7 >= brighter) &
						 (selPxl8 >= brighter) &
						 (selPxl9 >= brighter) &
						 (selPxl10 >= brighter) &
						 (selPxl11 >= brighter) &
						 (selPxl12 >= brighter) &
						 (selPxl13 >= brighter);

	assign cmp[5] = (selPxl6 >= brighter) &
						 (selPxl7 >= brighter) &
						 (selPxl8 >= brighter) &
						 (selPxl9 >= brighter) &
						 (selPxl10 >= brighter) &
						 (selPxl11 >= brighter) &
						 (selPxl12 >= brighter) &
						 (selPxl13 >= brighter) &
						 (selPxl14 >= brighter);

	assign cmp[6] = (selPxl7 >= brighter) &
						 (selPxl8 >= brighter) &
						 (selPxl9 >= brighter) &
						 (selPxl10 >= brighter) &
						 (selPxl11 >= brighter) &
						 (selPxl12 >= brighter) &
						 (selPxl13 >= brighter) &
						 (selPxl14 >= brighter) &
						 (selPxl15 >= brighter);

	assign cmp[7] = (selPxl8 >= brighter) &
						 (selPxl9 >= brighter) &
						 (selPxl10 >= brighter) &
						 (selPxl11 >= brighter) &
						 (selPxl12 >= brighter) &
						 (selPxl13 >= brighter) &
						 (selPxl14 >= brighter) &
						 (selPxl15 >= brighter) &
						 (selPxl16 >= brighter);

	assign cmp[8] = (selPxl9 >= brighter) &
						 (selPxl10 >= brighter) &
						 (selPxl11 >= brighter) &
						 (selPxl12 >= brighter) &
						 (selPxl13 >= brighter) &
						 (selPxl14 >= brighter) &
						 (selPxl15 >= brighter) &
						 (selPxl16 >= brighter) &
						 (selPxl1 >= brighter);

	assign cmp[9] = (selPxl10 >= brighter) &
						 (selPxl11 >= brighter) &
						 (selPxl12 >= brighter) &
						 (selPxl13 >= brighter) &
						 (selPxl14 >= brighter) &
						 (selPxl15 >= brighter) &
						 (selPxl16 >= brighter) &
						 (selPxl1 >= brighter) 	&
						 (selPxl2 >= brighter)	;
	assign cmp[10] = (selPxl11 >= brighter)	&
						 (selPxl12 >= brighter) 	&
						 (selPxl13 >= brighter) 	&
						 (selPxl14 >= brighter) 	&
						 (selPxl15 >= brighter) 	&
						 (selPxl16 >= brighter) 	&
						 (selPxl1 >= brighter) &
						 (selPxl2 >= brighter) &
						 (selPxl3 >= brighter);

	assign cmp[11] = (selPxl12 >= brighter) &
						 (selPxl13 >= brighter) &
						 (selPxl14 >= brighter) &
						 (selPxl15 >= brighter) &
						 (selPxl16 >= brighter) &
						 (selPxl1 >= brighter) &
						 (selPxl2 >= brighter) &
						 (selPxl3 >= brighter) &
						 (selPxl4 >= brighter);

	assign cmp[12] = (selPxl13 >= brighter) &
						 (selPxl14 >= brighter) &
						 (selPxl15 >= brighter) &
						 (selPxl16 >= brighter) &
						 (selPxl1 >= brighter) &
						 (selPxl2 >= brighter) &
						 (selPxl3 >= brighter) &
						 (selPxl4 >= brighter) &
						 (selPxl5 >= brighter);

	assign cmp[13] = (selPxl14 >= brighter) &
						 (selPxl15 >= brighter) &
						 (selPxl16 >= brighter) &
						 (selPxl1 >= brighter) &
						 (selPxl2 >= brighter) &
						 (selPxl3 >= brighter) &
						 (selPxl4 >= brighter) &
						 (selPxl5 >= brighter) &
						 (selPxl6 >= brighter);

	assign cmp[14] = (selPxl15 >= brighter) &
						 (selPxl16 >= brighter) &
						 (selPxl1 >= brighter) &
						 (selPxl2 >= brighter) &
						 (selPxl3 >= brighter) &
						 (selPxl4 >= brighter) &
						 (selPxl5 >= brighter) &
						 (selPxl6 >= brighter) &
						 (selPxl7 >= brighter);

	assign cmp[15] = (selPxl16 >= brighter) &
						 (selPxl1 >= brighter) &
						 (selPxl2 >= brighter) &
						 (selPxl3 >= brighter) &
						 (selPxl4 >= brighter) &
						 (selPxl5 >= brighter) &
						 (selPxl6 >= brighter) &
						 (selPxl7 >= brighter) &
						 (selPxl8 >= brighter);

	assign cmp[16] = (selPxl1 <= darker) &
						 (selPxl2 <= darker) &
						 (selPxl3 <= darker) &
						 (selPxl4 <= darker) &
						 (selPxl5 <= darker) &
						 (selPxl6 <= darker) &
						 (selPxl7 <= darker) &
						 (selPxl8 <= darker) &
						 (selPxl9 <= darker);

	assign cmp[17] = (selPxl2 <= darker) &
						 (selPxl3 <= darker) &
						 (selPxl4 <= darker) &
						 (selPxl5 <= darker) &
						 (selPxl6 <= darker) &
						 (selPxl7 <= darker) &
						 (selPxl8 <= darker) &
						 (selPxl9 <= darker) &
						 (selPxl10 <= darker);

	assign cmp[18] = (selPxl3 <= darker) &
						 (selPxl4 <= darker) &
						 (selPxl5 <= darker) &
						 (selPxl6 <= darker) &
						 (selPxl7 <= darker) &
						 (selPxl8 <= darker) &
						 (selPxl9 <= darker) &
						 (selPxl10 <= darker) &
						 (selPxl11 <= darker);

	assign cmp[19] = (selPxl4 <= darker) &
						 (selPxl5 <= darker) &
						 (selPxl6 <= darker) &
						 (selPxl7 <= darker) &
						 (selPxl8 <= darker) &
						 (selPxl9 <= darker) &
						 (selPxl10 <= darker) &
						 (selPxl11 <= darker) &
						 (selPxl12 <= darker);

	assign cmp[20] = (selPxl5 <= darker) &
						 (selPxl6 <= darker) &
						 (selPxl7 <= darker) &
						 (selPxl8 <= darker) &
						 (selPxl9 <= darker) &
						 (selPxl10 <= darker) &
						 (selPxl11 <= darker) &
						 (selPxl12 <= darker) &
						 (selPxl13 <= darker);

	assign cmp[21] = (selPxl6 <= darker) &
						 (selPxl7 <= darker) &
						 (selPxl8 <= darker) &
						 (selPxl9 <= darker) &
						 (selPxl10 <= darker) &
						 (selPxl11 <= darker) &
						 (selPxl12 <= darker) &
						 (selPxl13 <= darker) &
						 (selPxl14 <= darker);

	assign cmp[22] = (selPxl7 <= darker) &
						 (selPxl8 <= darker) &
						 (selPxl9 <= darker) &
						 (selPxl10 <= darker) &
						 (selPxl11 <= darker) &
						 (selPxl12 <= darker) &
						 (selPxl13 <= darker) &
						 (selPxl14 <= darker) &
						 (selPxl15 <= darker);

	assign cmp[23] = (selPxl8 <= darker) &
						 (selPxl9 <= darker) &
						 (selPxl10 <= darker) &
						 (selPxl11 <= darker) &
						 (selPxl12 <= darker) &
						 (selPxl13 <= darker) &
						 (selPxl14 <= darker) &
						 (selPxl15 <= darker) &
						 (selPxl16 <= darker);

	assign cmp[24] = (selPxl9 <= darker) &
						 (selPxl10 <= darker) &
						 (selPxl11 <= darker) &
						 (selPxl12 <= darker) &
						 (selPxl13 <= darker) &
						 (selPxl14 <= darker) &
						 (selPxl15 <= darker) &
						 (selPxl16 <= darker) &
						 (selPxl1 <= darker);

	assign cmp[25] = (selPxl10 <= darker) &
						 (selPxl11 <= darker) &
						 (selPxl12 <= darker) &
						 (selPxl13 <= darker) &
						 (selPxl14 <= darker) &
						 (selPxl15 <= darker) &
						 (selPxl16 <= darker) &
						 (selPxl1 <= darker) &
						 (selPxl2 <= darker);

	assign cmp[26] = (selPxl11 <= darker) &
						 (selPxl12 <= darker) &
						 (selPxl13 <= darker) &
						 (selPxl14 <= darker) &
						 (selPxl15 <= darker) &
						 (selPxl16 <= darker) &
						 (selPxl1 <= darker) &
						 (selPxl2 <= darker) &
						 (selPxl3 <= darker);

	assign cmp[27] = (selPxl12 <= darker) &
						 (selPxl13 <= darker) &
						 (selPxl14 <= darker) &
						 (selPxl15 <= darker) &
						 (selPxl16 <= darker) &
						 (selPxl1 <= darker) &
						 (selPxl2 <= darker) &
						 (selPxl3 <= darker) &
						 (selPxl4 <= darker);

	assign cmp[28] = (selPxl13 <= darker) &
						 (selPxl14 <= darker) &
						 (selPxl15 <= darker) &
						 (selPxl16 <= darker) &
						 (selPxl1 <= darker) &
						 (selPxl2 <= darker) &
						 (selPxl3 <= darker) &
						 (selPxl4 <= darker) &
						 (selPxl5 <= darker);

	assign cmp[29] = (selPxl14 <= darker) &
						 (selPxl15 <= darker) &
						 (selPxl16 <= darker) &
						 (selPxl1 <= darker) &
						 (selPxl2 <= darker) &
						 (selPxl3 <= darker) &
						 (selPxl4 <= darker) &
						 (selPxl5 <= darker) &
						 (selPxl6 <= darker);

	assign cmp[30] = (selPxl15 <= darker) &
						 (selPxl16 <= darker) &
						 (selPxl1 <= darker) &
						 (selPxl2 <= darker) &
						 (selPxl3 <= darker) &
						 (selPxl4 <= darker) &
						 (selPxl5 <= darker) &
						 (selPxl6 <= darker) &
						 (selPxl7 <= darker);

	assign cmp[31] = (selPxl16 <= darker) &
						 (selPxl1 <= darker) &
						 (selPxl2 <= darker) &
						 (selPxl3 <= darker) &
						 (selPxl4 <= darker) &
						 (selPxl5 <= darker) &
						 (selPxl6 <= darker) &
						 (selPxl7 <= darker) &
						 (selPxl8 <= darker);

	assign result_cmp = ((cmp[15:0] > 16'b0) | (cmp[31:16] > 16'b0) )? 1:0;
	
	/*assign result_cmp = 	(cmp == 32'b00000000000000000000000000000001) ? 1'b1 :
								(cmp == 32'b00000000000000000000000000000010) ? 1'b1 :
								(cmp == 32'b00000000000000000000000000000100) ? 1'b1 :
								(cmp == 32'b00000000000000000000000000001000) ? 1'b1 :
								(cmp == 32'b00000000000000000000000000010000) ? 1'b1 :
								(cmp == 32'b00000000000000000000000000100000) ? 1'b1 :
								(cmp == 32'b00000000000000000000000001000000) ? 1'b1 :
								(cmp == 32'b00000000000000000000000010000000) ? 1'b1 :
								(cmp == 32'b00000000000000000000000100000000) ? 1'b1 :
								(cmp == 32'b00000000000000000000001000000000) ? 1'b1 :
								(cmp == 32'b00000000000000000000010000000000) ? 1'b1 :
								(cmp == 32'b00000000000000000000100000000000) ? 1'b1 :
								(cmp == 32'b00000000000000000001000000000000) ? 1'b1 :
								(cmp == 32'b00000000000000000010000000000000) ? 1'b1 :
								(cmp == 32'b00000000000000000100000000000000) ? 1'b1 :
								(cmp == 32'b00000000000000001000000000000000) ? 1'b1 :
								(cmp == 32'b00000000000000010000000000000000) ? 1'b1 :
								(cmp == 32'b00000000000000100000000000000000) ? 1'b1 :
								(cmp == 32'b00000000000001000000000000000000) ? 1'b1 :
								(cmp == 32'b00000000000010000000000000000000) ? 1'b1 :
								(cmp == 32'b00000000000100000000000000000000) ? 1'b1 :
								(cmp == 32'b00000000001000000000000000000000) ? 1'b1 :
								(cmp == 32'b00000000010000000000000000000000) ? 1'b1 :
								(cmp == 32'b00000000100000000000000000000000) ? 1'b1 :
								(cmp == 32'b00000001000000000000000000000000) ? 1'b1 :
								(cmp == 32'b00000010000000000000000000000000) ? 1'b1 :
								(cmp == 32'b00000100000000000000000000000000) ? 1'b1 :
								(cmp == 32'b00001000000000000000000000000000) ? 1'b1 :
								(cmp == 32'b00010000000000000000000000000000) ? 1'b1 :
								(cmp == 32'b00100000000000000000000000000000) ? 1'b1 :
								(cmp == 32'b01000000000000000000000000000000) ? 1'b1 :
								(cmp == 32'b10000000000000000000000000000000) ? 1'b1 : 1'b0;*/
	assign outrefPxl = refPxl,
			 outPxl1 = selPxl1,
			 outPxl2 = selPxl2,
			 outPxl3 = selPxl3,
			 outPxl4 = selPxl4,
			 outPxl5 = selPxl5,
			 outPxl6 = selPxl6,
			 outPxl7 = selPxl7,
			 outPxl8 = selPxl8,
			 outPxl9 = selPxl9,
			 outPxl10 = selPxl10,
			 outPxl11 = selPxl11,
			 outPxl12 = selPxl12,
			 outPxl13 = selPxl13,
			 outPxl14 = selPxl14,
			 outPxl15 = selPxl15,
			 outPxl16 = selPxl16,
			 outThreshold = Threshold,
			 isCorner = result_cmp;
	
	
endmodule
