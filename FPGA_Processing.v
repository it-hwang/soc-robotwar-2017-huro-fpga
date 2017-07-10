/************************************************************************
  Project   : SoC Robot WAR Support
  Title     : FPGA HDL Source for Image Processing(SRAM Interface)
  File name : FPGA_Processing.v

  Author(s) : Advanced Digital Chips Inc. 

  History
        + v0.0   2002/ 9/18 : First version released
        + v0.1   2003/ 7/08 : Update
		  + v0.2   2004/ 6/12 : Update(Conversion for FPGA Chip(XC2S100))
	     + v0.3   2006/ 6/30 : Update(Conversion for FPGA Chip(XC3S400))
	Modify by KAIST SDIA
	     + v0.5	 2008/7/23: Update(Conversion for FPGA Chip (Cyclone3 - EP3C16U256C7N)
	Modify
	     + v0.6  2011/9/07: Update(Conversion for FPGA Chip (Cyclone4 - EP4CE75U19I7))
		                      - change to use Internal FPGA RAM
		                     Video Decoder Input YCbCr422 to RGB565
									Add Interrupt Request 1 channel
	Modify
	     + v0.7  2014/6/19: Update(Conversion for AMAZON2 Chip)								
									
*************************************************************************/

module FPGA_Processing ( resetx,
					clk_llc2, clk_llc, vref, href, odd, vpo,                  	   // mem_ctrl <- SAA7111A
					AMAmem_adr, AMAmem_data, AMAmem_csx, 			            // Amazon2 Interface
					AMAmem_wrx, AMAmem_rdx, AMAmem_waitx, AMAmem_irq0, AMAmem_irq1,	   // Amazon2 Interface
					led_test       										                  // FPGA test(LED On/Off)
					);

input         resetx;

/* mem_ctrl <- SAA7111A */
input         clk_llc2;      // 13.5 MHz
input         clk_llc;       // 27 MHz
input         vref;          // vertical sync.
input         href;          // horizontal sync.
input         odd;           // odd field (RTS0) 
input  [15:0] vpo;           // RGB(565) input vidoe data

/* Amazon2 SRAM Interface */
input  [14:0] AMAmem_adr;     // Amazon2 Address[15:1] 
inout  [15:0] AMAmem_data;    // Amazon2 Data[15:0] 
input         AMAmem_csx;     // FPGA Chip Select, Amazon2 nCS3
input         AMAmem_wrx;     // write strobe, Amazon2 nWR
input         AMAmem_rdx;     // read strobe, Amazon2 nRD
output        AMAmem_waitx;   // Amazon2 read wait, Amazon2 nWAIT 
output        AMAmem_irq0;    // external read interrupt(FPGA -> Amazon2), Amazon2 IRQ6
output        AMAmem_irq1;    // external read interrupt(FPGA -> Amazon2), Amazon2 IRQ7

/* FPGA test */
output       led_test;

//-----------------------------------------------------------------
// SRAM WRITE & Interrupt	
// SAA7111A Video Decoder => SRAM, V/H sync. input 
// 720x480 -> 180x120 compression
//-----------------------------------------------------------------

reg [ 1:0] clk_div;     

always @(negedge resetx or posedge clk_llc2)
   if      (~resetx)         clk_div <= 2'b0;
   else                      clk_div <= clk_div + 1'b1;

// clk_llc8 : 180(720/4) clock generation
wire clk_llc8  = clk_div[1];

// href2 : (480/2) clock generation
reg  href2;
always @(negedge resetx or posedge href)
   if      (~resetx)          href2 <= 1'b0;
   else                       href2 <= ~href2;

// select only odd frame
wire oddframe   = odd & vref;

// 120(480/4) clock generation
wire href2_wr   = href2 & href & oddframe;// & oddframe2; 


/////////////////////////////////////////////////////////////////////////////
// YCbCr422 to RGB565
reg [ 1:0] CodeCnt;

reg [ 7:0] Y_Data1, Cb_Data1, Cr_Data1, Y_Data2, Cb_Data2, Cr_Data2;
reg [20:0] R_int,G_int,B_int,X_int,A_int,B1_int,B2_int,C_int; 
reg [ 9:0] const1,const2,const3,const4,const5;


always @ (posedge clk_llc or negedge resetx)
	if      (~resetx)					CodeCnt <= 2'b0;
	else if (href2_wr)				CodeCnt <= CodeCnt + 1'b1;
	else if (~href2_wr)				CodeCnt <= 2'b0;
	
	
always @ (posedge clk_llc or negedge resetx)
	if      (~resetx)				Cb_Data1 <= 8'b0;
	else if (CodeCnt==2'b00)	Cb_Data1 <= vpo[15:8];
	
always @ (posedge clk_llc or negedge resetx)
	if      (~resetx)				Y_Data1 <= 8'b0;
	else if (CodeCnt==2'b01)	Y_Data1 <= vpo[15:8];
	
always @ (posedge clk_llc or negedge resetx)
	if      (~resetx)				Cr_Data1 <= 8'b0;
	else if (CodeCnt==2'b10)	Cr_Data1 <= vpo[15:8];
	
always @ (posedge clk_llc or negedge resetx)
	if      (~resetx)				Y_Data2 <= 8'b0;
	else if (CodeCnt==2'b11)	Y_Data2 <= vpo[15:8];
	
always @ (posedge clk_llc or negedge resetx)
	if      (~resetx)				Cb_Data2 <= 8'b0;
	else if (CodeCnt==2'b00)	Cb_Data2 <= vpo[15:8];

always @ (posedge clk_llc or negedge resetx)
	if      (~resetx)				Cr_Data2 <= 8'b0;
	else if (CodeCnt==2'b10)	Cr_Data2 <= vpo[15:8];

	
//registering constants
always @ (posedge clk_llc)
begin
 const1 = 10'b 0100101010; //1.164 = 01.00101010
 const2 = 10'b 0110011000; //1.596 = 01.10011000
 const3 = 10'b 0011010000; //0.813 = 00.11010000
 const4 = 10'b 0001100100; //0.392 = 00.01100100
 const5 = 10'b 1000000100; //2.017 = 10.00000100
end

wire [9:0] YData1 = {Y_Data1, 2'b00};
wire [9:0] CbData1 = {Cb_Data1, 2'b00};
wire [9:0] CrData1 = {Cr_Data1, 2'b00};
wire [9:0] YData2 = {Y_Data2, 2'b00};
wire [9:0] CbData2 = {Cb_Data2, 2'b00};
wire [9:0] CrData2 = {Cr_Data2, 2'b00};

always @ (posedge clk_llc or negedge resetx)
   if (~resetx)
      begin
       A_int <= 0; B1_int <= 0; B2_int <= 0; C_int <= 0; X_int <= 0;
      end
   else if (CodeCnt==2'b10)
     begin
     X_int <= (const1 * (YData1 - 'd64)) ;
     A_int <= (const2 * (CrData1 - 'd512));
     B1_int <= (const3 * (CrData1 - 'd512));
     B2_int <= (const4 * (CbData1 - 'd512));
     C_int <= (const5 * (CbData1 - 'd512));
     end
	else if (CodeCnt==2'b11)
     begin
     X_int <= (const1 * (YData2 - 'd64)) ;
     A_int <= (const2 * (CrData2 - 'd512));
     B1_int <= (const3 * (CrData2 - 'd512));
     B2_int <= (const4 * (CbData2 - 'd512));
     C_int <= (const5 * (CbData2 - 'd512));
     end
	  
always @ (posedge clk_llc or negedge resetx)
   if (~resetx)
      begin
       R_int <= 0; G_int <= 0; B_int <= 0;
      end
   else if ((CodeCnt==2'b10) | (CodeCnt==2'b11))
     begin
     R_int <= X_int + A_int;  
     G_int <= X_int - B1_int - B2_int; 
     B_int <= X_int + C_int; 
     end


wire [ 4:0] R = (R_int[20]) ? 5'b0 : (R_int[19:18] == 2'b0) ? R_int[17:13] : 5'b11111;
wire [ 5:0] G = (G_int[20]) ? 6'b0 : (G_int[19:18] == 2'b0) ? G_int[17:12] : 6'b111111;
wire [ 4:0] B = (B_int[20]) ? 5'b0 : (B_int[19:18] == 2'b0) ? B_int[17:13] : 5'b11111;	  

//y = (0.299 * R) + (0.587*G) + (0.114*B)
wire [4:0]	GrayScale = (R>>2) + (G>>2) + (B>>3);
//wire [4:0]	GrayScale = ((3*R) + (6*G) + B) / 10;
wire [4:0]	Gray_R = GrayScale;
wire [5:0]	Gray_G = {GrayScale,1'b0};
wire [4:0]	Gray_B = GrayScale;
wire [15:0]	DecVData = {Gray_R,Gray_G,Gray_B};
wire [15:0] OriginVData = {R,G,B};
/////////////////////////////////////////////////////////////////////////////


// 180x120 write clock generation 
wire vpo_wrx    = ~(vref & href2_wr & clk_llc8);

reg vpo_wrxd1;
reg vpo_wrxd2;
reg vpo_wrxd3;

always @(negedge resetx or posedge clk_llc)
   if      (~resetx)           vpo_wrxd1 <= 1'b1;
   else                        vpo_wrxd1 <= vpo_wrx;

always @(negedge resetx or posedge clk_llc)
   if      (~resetx)           vpo_wrxd2 <= 1'b1;
   else                        vpo_wrxd2 <= vpo_wrxd1;

always @(negedge resetx or posedge clk_llc)
   if      (~resetx)           vpo_wrxd3 <= 1'b1;
   else                        vpo_wrxd3 <= vpo_wrxd2;



// delayed write clock for no grich
wire   vd_wrx    = ~(~vpo_wrxd1 & vpo_wrxd3);

//------------------------------------------------------
// 16bit SRAM address generation (64KB)
// 180 x 120
//   __________ 
//  |          |  0x0000  
//  | 180x120  |  
//  |          |  
//  |          |  
//  |----------|  0x5460(word)
//  | reserved |  
//  |----------|  0x8000(word)
//  |          |  
//  | 180x120  |  
//  |          |  
//  |          |  
//  |----------|  0xD460(word)  
//  | reserved |  
//  |__________|  0xFFFF
//
//------------------------------------------------------

reg [15:0] vdata;
reg [15:0] ovdata;
reg [15:0] vadr;
reg A_addr;
always @(negedge resetx or posedge clk_llc8)
   if      (~resetx)           
		begin
			vdata <= 16'b0;
			ovdata <= 16'b0;
		end
	else if (href2_wr)
		begin
			vdata <= DecVData;
			ovdata <= OriginVData;
		end

always @(negedge resetx or posedge clk_llc8)
   if      (~resetx)           vadr[14:0] <= 15'b0;
   else if (~oddframe)         vadr[14:0] <= 15'b0;
   else if (href2_wr)          vadr[14:0] <= vadr[14:0] + 1'b1;

always @(negedge resetx or posedge odd)
   if      (~resetx)       vadr[15] <= 1'b0;
   else                    vadr[15] <= ~vadr[15];
	
always @(negedge resetx or posedge Sys_clk)
   if      (~resetx)       A_addr <= 1'b0;
   else                    A_addr <= AMAmem_irq1;



//----------------------------------------------------------------------------------
// External Interrupt Generation
// 1 interrupter per 1 frame(interrupt length = Sys_clk 2cycle)
//----------------------------------------------------------------------------------

reg  oddframe_d1;
reg  oddframe_d2;
reg  oddframe_d3;

always @(negedge resetx or posedge Sys_clk)
   if      (~resetx)             oddframe_d1 <= 1'b0;
   else                          oddframe_d1 <= oddframe;

always @(negedge resetx or posedge Sys_clk)
   if      (~resetx)             oddframe_d2 <= 1'b0;
   else                          oddframe_d2 <= oddframe_d1;

always @(negedge resetx or posedge Sys_clk)
   if      (~resetx)             oddframe_d3 <= 1'b0;
   else                          oddframe_d3 <= oddframe_d2;

assign AMAmem_irq0 = ~oddframe_d1 & oddframe_d3 & (vadr[15] == 1);
assign AMAmem_irq1 = ~oddframe_d1 & oddframe_d3 & (vadr[15] == 0);





wire	[15:0]  vmem_addr;
wire	[15:0]  vmem_data;
wire	[15:0]  ovmem_data;
wire	        vmem_rden;
wire	        vmem_wren;
wire  [15:0]  vmem_q;

//////////////////////////// MEGA Wizard //////////////////////////////////
// FPGA PLL
wire  Sys_clk;
// clk_llc PLL
pll	pll_inst (
		.inclk0 ( clk_llc ),
		.c0 ( Sys_clk )
		);
// Original Image Block RAM Instance
RAM	RAM_inst (
	.address ( vmem_addr ),
	.clock ( Sys_clk ),
	.data ( ovmem_data ),
	.rden ( vmem_rden ),
	.wren ( vmem_wren ),
	.q ( vmem_q )
	);
////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------
// SRAM Controller State Machine
// SRAM (2cycle command & wait enable)
//-----------------------------------------------------------------
supply1   vdd;
reg [6:0] cs, ns;

parameter s0  = 7'b0000001;
parameter s1  = 7'b0000010;
parameter s2  = 7'b0000100;
parameter s3  = 7'b0001000;
parameter s4  = 7'b0010000;
parameter s5  = 7'b0100000;
parameter s6  = 7'b1000000;

wire mcs0 = cs[0];    // idle state
wire mcs1 = cs[1];    // sa7111 video data write state 
wire mcs2 = cs[2];    // sa7111 video data write last state 
wire mcs3 = cs[3];    // Eagle data write state(for test)
wire mcs4 = cs[4];    // Eagle data write last state
wire mcs5 = cs[5];    // Eagle data read state 
wire mcs6 = cs[6];    // Eagle data read last state

always @(negedge resetx or posedge Sys_clk)
  if (~resetx) cs <= s0;
  else         cs <= ns;

always @(mcs0 or mcs1 or mcs2 or mcs3 or mcs4 or mcs5 or mcs6 or AMAmem_csx or vd_wrx or AMAmem_wrx or AMAmem_rdx) begin
  ns = s0;
  case (vdd)	// synopsys parallel_case full_case
    mcs0    : if      ( ~vd_wrx )                            ns = s1;
              else if (  vd_wrx & ~AMAmem_csx & ~AMAmem_wrx )  ns = s3;
              else if (  vd_wrx & ~AMAmem_csx & ~AMAmem_rdx )  ns = s5;
              else							ns = s0;
    mcs1    : if      (vd_wrx)			ns = s2;
              else             			ns = s1;
              
    mcs2    :                        	ns = s0;

    mcs3    : if      (AMAmem_wrx )   	ns = s4;
              else                   	ns = s3;
              
    mcs4    : 									ns = s0;
    
	 mcs5    : if      (AMAmem_rdx)    	ns = s6;
              else                    	ns = s5;
              
    mcs6    :                     		ns = s0;

    default :                 			ns = s0;          
  endcase
end  


//-----------------------------------------------------------------
// SRAM Controller Output
//-----------------------------------------------------------------
//assign mem_csx     =  mcs0;		// SRAM Chip select

assign vmem_wren     = mcs1; 	// SRAM Write // ~( mcs1 );

assign vmem_rden     = mcs5; 		// SRAM Read  //~mcs5;
 
//assign mem_bex[1]  = ~(mcs1 | mcs3 | mcs5) ;	// 16bit MSB Byte enable
//assign mem_bex[0]  = ~(mcs1 | mcs3 | mcs5) ;	// 16bit LSB Byte enable

wire FD_isCorner;
wire NMS_isCorner;
wire	[15:0]	row;

assign row = (vmem_addr  / 16'b0000000010110100);

assign AMAmem_data  = ( ~AMAmem_csx ) ? ((row > 4) ? ((NMS_isCorner) ? ({vmem_q[15:11],vmem_q[10:6],1'b1,vmem_q[4:0]}) : ({vmem_q[15:11],vmem_q[10:6],1'b0,vmem_q[4:0]})) : ({vmem_q[15:11],vmem_q[10:6],1'b0,vmem_q[4:0]})) : 16'bZ;

assign vmem_data    = ( mcs1 | mcs2 ) ? vdata : 16'bZ ;
assign ovmem_data    = ( mcs1 | mcs2 ) ? ovdata : 16'bZ ;
//assign vmem_data    = ( (~mcs0 & mcs1) | (~mcs0 & mcs2) ) ? vdata : 16'bZ ;

assign vmem_addr     = ( mcs1 | mcs2 ) ? vadr : {A_addr, AMAmem_adr};	// 16bit SRAM address
//assign vmem_addr     = ( (~mcs0 & mcs1) | (~mcs0 & mcs2) ) ? vadr : AMAmem_adr;

//-----------------------------------------------------------------
//FAST
wire	[15:0]	FD_refAddr;
wire	[4:0]		FD_regAddr;
wire	[4:0]		FD_calAddr;
wire				FD_readEn;
wire	[15:0]	FD_memAddr;
wire	[15:0]	FD_memVal;
wire				FS_writeEn;
wire				FS_readEn;
wire	[15:0]	NMS_refAddr;
wire	[3:0]		NMS_calAddr;
wire	[3:0]		NMS_regAddr;
wire				NMS_readEn;
wire	[15:0]	NMS_memAddr;
wire	[15:0]	NMS_memVal;

reg	nRESET;

always @ ( vmem_rden )
		if( vmem_rden )
			nRESET = 1'b1;
		else
			nRESET = 1'b0;

FAST_Controller Controller(
	.clock( Sys_clk ),
	.input_addr( vmem_addr ),
	.nRESET( nRESET ),
	.FD_refAddr( FD_refAddr ),
	.FD_calAddr( FD_calAddr ),
	.FD_regAddr( FD_regAddr ),
	.FD_readEn( FD_readEn ),
	.FAST_En( vmem_rden ),
	.FS_writeEn( FS_writeEn ),
	.FS_readEn( FS_readEn ),
	.NMS_refAddr( NMS_refAddr ),
	.NMS_calAddr( NMS_calAddr ),
	.NMS_regAddr( NMS_regAddr ),
	.NMS_readEn( NMS_readEn ));

FD_AddrCal AddrCal_FD(
	.refAddr( FD_refAddr ), 
	.regAddr( FD_calAddr ), 
	.srmAddr( FD_memAddr ));

wire  [7:0] FD_regOut00;
wire  [7:0] FD_regOut01;
wire  [7:0] FD_regOut02;
wire  [7:0] FD_regOut03;
wire  [7:0] FD_regOut04;
wire  [7:0] FD_regOut05;
wire  [7:0] FD_regOut06;
wire  [7:0] FD_regOut07;
wire  [7:0] FD_regOut08;
wire  [7:0] FD_regOut09;
wire  [7:0] FD_regOut10;
wire  [7:0] FD_regOut11;
wire  [7:0] FD_regOut12;
wire  [7:0] FD_regOut13;
wire  [7:0] FD_regOut14;
wire  [7:0] FD_regOut15;
wire  [7:0] FD_regOut16;
wire  [7:0] FD_Threshold;
wire	[7:0]	FD_regData = {FD_memVal[10:5],3'b000};

FD_Register Register_FD(
	//input
	.clk(Sys_clk),
	.nRESET(nRESET),
	.readEn(FD_readEn),
	.RegAddr(FD_regAddr),
	.ReadData(FD_regData),
	//output
	.Refpixel(FD_regOut00),
	.Selpixel_0(FD_regOut01),
	.Selpixel_1(FD_regOut02),
	.Selpixel_2(FD_regOut03), 
	.Selpixel_3(FD_regOut04),
	.Selpixel_4(FD_regOut05),
	.Selpixel_5(FD_regOut06),
	.Selpixel_6(FD_regOut07),
	.Selpixel_7(FD_regOut08),
	.Selpixel_8(FD_regOut09),
	.Selpixel_9(FD_regOut10),
	.Selpixel_10(FD_regOut11),
	.Selpixel_11(FD_regOut12),
	.Selpixel_12(FD_regOut13),
	.Selpixel_13(FD_regOut14),
	.Selpixel_14(FD_regOut15),
	.Selpixel_15(FD_regOut16),
	.Threhol(FD_Threshold));

wire  [7:0] FD_datapathOut00;
wire  [7:0] FD_datapathOut01;
wire  [7:0] FD_datapathOut02;
wire  [7:0] FD_datapathOut03;
wire  [7:0] FD_datapathOut04;
wire  [7:0] FD_datapathOut05;
wire  [7:0] FD_datapathOut06;
wire  [7:0] FD_datapathOut07;
wire  [7:0] FD_datapathOut08;
wire  [7:0] FD_datapathOut09;
wire  [7:0] FD_datapathOut10;
wire  [7:0] FD_datapathOut11;
wire  [7:0] FD_datapathOut12;
wire  [7:0] FD_datapathOut13;
wire  [7:0] FD_datapathOut14;
wire  [7:0] FD_datapathOut15;
wire  [7:0] FD_datapathOut16;
wire	FD_dataPathThreshold;


FD_Datapath Datapath_FD(
	//input
  .refPxl(FD_regOut00),
	.selPxl1(FD_regOut01),
	.selPxl2(FD_regOut02),
	.selPxl3(FD_regOut03),
	.selPxl4(FD_regOut04), 
	.selPxl5(FD_regOut05),
	.selPxl6(FD_regOut06),
	.selPxl7(FD_regOut07),
	.selPxl8(FD_regOut08),
	.selPxl9(FD_regOut09), 
	.selPxl10(FD_regOut10),
	.selPxl11(FD_regOut11),
	.selPxl12(FD_regOut12),
	.selPxl13(FD_regOut13),
	.selPxl14(FD_regOut14), 
	.selPxl15(FD_regOut15),
	.selPxl16(FD_regOut16),
	.Threshold(FD_Threshold),
	.FD_readEn(FD_readEn), 
  //output
	.outrefPxl(FD_datapathOut00),
	.outPxl1(FD_datapathOut01),
	.outPxl2(FD_datapathOut02),
	.outPxl3(FD_datapathOut03),
	.outPxl4(FD_datapathOut04), 
	.outPxl5(FD_datapathOut05),
	.outPxl6(FD_datapathOut06),
	.outPxl7(FD_datapathOut07),
	.outPxl8(FD_datapathOut08),
	.outPxl9(FD_datapathOut09), 
	.outPxl10(FD_datapathOut10),
	.outPxl11(FD_datapathOut11),
	.outPxl12(FD_datapathOut12),
	.outPxl13(FD_datapathOut13),
	.outPxl14(FD_datapathOut14), 
	.outPxl15(FD_datapathOut15),
	.outPxl16(FD_datapathOut16),
	.outThreshold(FD_dataPathThreshold), 
	.isCorner(FD_isCorner));
	
wire [7:0]	FS_refPixelOut;
wire [11:0]	FS_scoreVal;
wire [14:0]	FS_refAddrOut;

FS_Datapath Datapath_FS(
	//input
	.refPxl(FD_datapathOut00), 
	.selPxl1(FD_datapathOut01),
	.selPxl2(FD_datapathOut02),
	.selPxl3(FD_datapathOut03),
	.selPxl4(FD_datapathOut04),
	.selPxl5(FD_datapathOut05),
	.selPxl6(FD_datapathOut06), 
	.selPxl7(FD_datapathOut07),
	.selPxl8(FD_datapathOut08),
	.selPxl9(FD_datapathOut09),
	.selPxl10(FD_datapathOut10),
	.selPxl11(FD_datapathOut11),
	.selPxl12(FD_datapathOut12), 
	.selPxl13(FD_datapathOut13),
	.selPxl14(FD_datapathOut14),
	.selPxl15(FD_datapathOut15),
	.selPxl16(FD_datapathOut16), 
	.Threshold(FD_Threshold),
	.isCorner(FD_isCorner),
	.refAddr(FD_refAddr),
	//output
	.scoreVal(FS_scoreVal),
	.outrefPxl(FS_refPixelOut), 
	.outrefAddr(FS_refAddrOut));

NMS_AddrCal AddrCal_NMS(
	//input
	.refAddr(NMS_refAddr),
	.regAddr(NMS_calAddr), 
						 
	//output
	.srmAddr(NMS_memAddr));

wire	[11:0]	NMS_regOut00;
wire	[11:0]	NMS_regOut01;
wire	[11:0]	NMS_regOut02;
wire	[11:0]	NMS_regOut03;
wire	[11:0]	NMS_regOut04;
wire	[11:0]	NMS_regOut05;
wire	[11:0]	NMS_regOut06;
wire	[11:0]	NMS_regOut07;
wire	[11:0]	NMS_regOut08;

NMS_Register Register_NMS(
	//input
	.clk(Sys_clk),
	.nRESET(nRESET),
	.regAddr(NMS_regAddr),
	.readEn(NMS_readEn),
	.scoreData(NMS_memVal),
	//output
	.nighScore0(NMS_regOut01),
	.nighScore1(NMS_regOut02),
	.nighScore2(NMS_regOut03),
	.nighScore3(NMS_regOut04),
	.nighScore4(NMS_regOut05),
	.nighScore5(NMS_regOut06),
	.nighScore6(NMS_regOut07),
	.nighScore7(NMS_regOut08),
	.refScore(NMS_regOut00));

NMS_Datapath Datapath_NMS(
	//input
	.refPxl(FS_refPixelOut),
	.nighScore0(NMS_regOut01),
	.nighScore1(NMS_regOut02),
	.nighScore2(NMS_regOut03),
	.nighScore3(NMS_regOut04),
	.nighScore4(NMS_regOut05), 
	.nighScore5(NMS_regOut06), 
	.nighScore6(NMS_regOut07), 
	.nighScore7(NMS_regOut08),
	.refScore(NMS_regOut00),		  
	//output
	.NMS_isCorner(NMS_isCorner));
//-----------------------------------------------------------------

//-----------------------------------------------------------------
//Coustom RAM
CustomRAM RAM_custom(
	.clock ( Sys_clk ),
	.data ( vmem_data ),
	.rdaddress ( FD_memAddr ),
	.wraddress ( vmem_addr ),
	.wren ( vmem_wren ),
	.q( FD_memVal ) );
	
//Score RAM
ScoreRAM RAM_score(
	.clock( Sys_clk ),
	.data( FS_scoreVal ),
	.rdaddress( NMS_memAddr ),
	.rden( FS_readEn ),
	.wraddress( FS_refAddrOut ),
	.wren( FS_writeEn ),
	.q( NMS_memVal ));
//-----------------------------------------------------------------

//-----------------------------------------------------------------
// FPGA waitx signal generation
// if Eagle is interfaced to low speed device, waitx has to delayed  
//-----------------------------------------------------------------
wire    waitx = AMAmem_csx  | ~( mcs1 | mcs2 ) ;

reg  waitx_d1;
reg  waitx_d2;
reg  waitx_d3;
reg  waitx_d4;
reg  waitx_d5;

reg  waitx_d6;
reg  waitx_d7;
reg  waitx_d8;
reg  waitx_d9;
reg  waitx_d10;


always @(negedge resetx or posedge Sys_clk)
   if      (~resetx)     	waitx_d1 <= 1'b0;
   else                      	waitx_d1 <= waitx;

always @(negedge resetx or posedge Sys_clk)
   if      (~resetx)         	waitx_d2 <= 1'b0;
   else                     	waitx_d2 <= waitx_d1;

always @(negedge resetx or posedge Sys_clk)
   if      (~resetx)         	waitx_d3 <= 1'b0;
   else                     	waitx_d3 <= waitx_d2;

always @(negedge resetx or posedge Sys_clk)
   if      (~resetx)         	waitx_d4 <= 1'b0;
   else                     	waitx_d4 <= waitx_d3;

always @(negedge resetx or posedge Sys_clk)
   if      (~resetx)         	waitx_d5 <= 1'b0;
   else                     	waitx_d5 <= waitx_d4;

always @(negedge resetx or posedge Sys_clk)
   if      (~resetx)         	waitx_d6 <= 1'b0;
   else                     	waitx_d6 <= waitx_d5;
   
always @(negedge resetx or posedge Sys_clk)
   if      (~resetx)         	waitx_d7 <= 1'b0;
   else                     	waitx_d7 <= waitx_d6;
   
always @(negedge resetx or posedge Sys_clk)
   if      (~resetx)         	waitx_d8 <= 1'b0;
   else                     	waitx_d8 <= waitx_d7;
   
always @(negedge resetx or posedge Sys_clk)
   if      (~resetx)         	waitx_d9 <= 1'b0;
   else                     	waitx_d9 <= waitx_d8; 

always @(negedge resetx or posedge Sys_clk)
   if      (~resetx)         	waitx_d10 <= 1'b0;
   else                     	waitx_d10 <= waitx_d9;   


assign AMAmem_waitx = waitx & waitx_d1 & waitx_d2 & waitx_d3 & waitx_d4 & waitx_d5 & waitx_d6 & waitx_d7 & waitx_d8 & waitx_d9 & waitx_d10;



//-----------------------------------------------------------------
// FPGA Test
// led has to on/off after FPGA download
//-----------------------------------------------------------------
reg [ 5 : 0 ]  led_blink;
wire  vadrclk = vadr[14];

always @(negedge resetx or posedge vadrclk )
   if      (~resetx)           led_blink   <= 6'b0;
   else                        led_blink   <= led_blink + 1'b1;

assign led_test = led_blink[5];

endmodule
