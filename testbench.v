`define CYCLE_TIME 20
`define INSTRUCTION_NUMBERS 10000
`timescale 1ns/1ps
`include "CPU.v"

module testbench;
reg Clk, Rst;
reg [31:0] cycles, i;

// Instruction DM initialilation
initial
begin
	/*=================================================     連加     =================================================*/
		cpu.IF.instruction[ 0] = 32'b001000_00000_01010_00000_00000_000011;	//addi $t2, $zero, 3       $3 = 1 + 2 = 3
		cpu.IF.instruction[ 1] = 32'b100011_00000_01001_00000_00000_000000;	//add $t1,$zero,$v0  $5 = 1 + 2 = 3
		cpu.IF.instruction[ 2] = 32'b000000_00000_00000_00000_00000_100000; //NOP
		cpu.IF.instruction[ 3] = 32'b000000_00000_00000_00000_00000_100000; //NOP
		cpu.IF.instruction[ 4] = 32'b000000_00000_00000_00000_00000_100000; //NOP
		cpu.IF.instruction[ 5] = 32'b000100_01001_01010_00000_00001_111001; //beq $t1, $t2, Special
		cpu.IF.instruction[ 6] = 32'b000000_00000_00000_00000_00000_100000; //NOP
		cpu.IF.instruction[ 7] = 32'b000000_00000_00000_00000_00000_100000; //NOP
		cpu.IF.instruction[ 8] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 9] = 32'b001000_00000_00100_00000_00000_000001; //$4 = 1
		cpu.IF.instruction[10] = 32'b001000_00000_01011_11111_11111_111110;	//addi $t3, $zero, -2  $6 = 1 + 2 = 3
		cpu.IF.instruction[11] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $5, $4)	
		cpu.IF.instruction[12] = 32'b001100_01001_01010_00000_00000_000001;	//and $t2, $t2, $t1	
		cpu.IF.instruction[13] = 32'b001000_01001_00001_11111_11111_111111;	//subi $t4, $1, 1	
		cpu.IF.instruction[14] = 32'b001000_01001_00010_11111_11111_111110;	//subi $t4, $2, 2	
		cpu.IF.instruction[15] = 32'b000000_00000_00000_00000_00000_100000;	//NOP	
		cpu.IF.instruction[16] = 32'b000101_01010_00000_00000_00000_000110;	//bne $t2, $zero, ODD need modify	
		cpu.IF.instruction[17] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[18] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[19] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[20] = 32'b000000_00000_00001_01100_00000_100000;	//add $t4, $1, 0	
		cpu.IF.instruction[21] = 32'b000010_00000_00000_00000_00000_011001;	//j isPrime	
		cpu.IF.instruction[22] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[23] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0) //ODD	
		cpu.IF.instruction[24] = 32'b000000_00000_00010_01100_00000_100000;	//add $t4, $2, 0	
		cpu.IF.instruction[25] = 32'b001000_00000_01101_00000_00000_000010;	//addi $t5, $zero, 2//isPrime
		cpu.IF.instruction[26] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[27] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[28] = 32'b001000_00000_10000_00000_00000_000010;	//addi $t8, $zero, 2  //ForStart
		cpu.IF.instruction[29] = 32'b000000_01101_01101_01110_00000_100000;	//add $t6, $t5, $t5	
		cpu.IF.instruction[30] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)			
		cpu.IF.instruction[31] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[32] = 32'b001000_10000_10000_00000_00000_000001;	//addi $t8, $t8, 1	//to here MUL
		cpu.IF.instruction[33] = 32'b000000_01110_01101_01110_00000_100000;	//add $t6, $t6, $t5	// change MUL
		cpu.IF.instruction[34] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[35] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[36] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[37] = 32'b000000_01100_01110_01111_00000_101010;	//slt $t7, $t4, $t6	
		cpu.IF.instruction[38] = 32'b000000_10000_01101_00001_00000_101010;	//slt $1, $t8, $t5	
		cpu.IF.instruction[39] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[40] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[41] = 32'b000101_00000_01111_00000_00000_100101;	//bne $t7, $zero, endIsPrime (now is 0)
		cpu.IF.instruction[42] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[43] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[44] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[45] = 32'b000101_00001_00000_11111_11111_110010;	//bne $1, $zero, MUL
		cpu.IF.instruction[46] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[47] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[48] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[49] = 32'b000000_01100_01101_01110_00000_100000;	//add $t6, $t4, $t5	
		cpu.IF.instruction[50] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[51] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[52] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[53] = 32'b000000_01110_01101_01110_00000_100010;	//sub $t6, $t6, $t5  //doRem
		cpu.IF.instruction[54] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[55] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[56] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[57] = 32'b000000_01110_01101_01111_00000_101010;	//slt $t7, $t6, $t5
		cpu.IF.instruction[58] = 32'b000100_01110_00000_00000_00000_001010;	//beq $t6, $zero, doneRem
		cpu.IF.instruction[59] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[60] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[61] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[62] = 32'b000101_01111_00000_00000_00000_000110;	//bne $t7, $zero, doneRem	
		cpu.IF.instruction[63] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[64] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[65] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[66] = 32'b000010_00000_00000_00000_00000_110101;	//j doRem	
		cpu.IF.instruction[67] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[68] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[69] = 32'b000100_01110_00000_00000_00000_001110;	//beq $t6, $zero, False //doneRem	
		cpu.IF.instruction[70] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[71] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[72] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[73] = 32'b001000_01101_01101_00000_00000_000001;	//addi $t5, $t5, 1	
		cpu.IF.instruction[74] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[75] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[76] = 32'b000010_00000_00000_00000_00000_011100;	//j ForStart
		cpu.IF.instruction[77] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[78] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[79] = 32'b001000_00000_10000_00000_00000_000001;	//addi $t8, $zero, 1 //endIsPrime	
		cpu.IF.instruction[80] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[81] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[82] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[83] = 32'b000010_00000_00000_00000_00001_011000;	//j While	
		cpu.IF.instruction[84] = 32'b000000_00000_00000_10000_00000_100000;	//add $t8, $zero, $zero	//False
		cpu.IF.instruction[85] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[86] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[87] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[88] = 32'b000100_10000_00000_00000_00000_100010;	//beq $t8, $zero, nomin	//while
		cpu.IF.instruction[89] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[90] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[91] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[92] = 32'b000101_10001_00000_00000_00000_000111;	//bne $t9, $zero, save2
		cpu.IF.instruction[93] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[94] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[95] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[96] = 32'b101011_00000_01100_00000_00000_000001;	//sw $t4,$4, $zero
		cpu.IF.instruction[97] = 32'b000010_00000_00000_00000_00001_100101;	//j endsave
		cpu.IF.instruction[98] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[99] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[100]= 32'b101011_00000_01100_00000_00000_000010;	//sw $t4,$4, $1 //save2
		cpu.IF.instruction[101]= 32'b001000_10001_10001_00000_00000_000001;	//addi $t9, $t9, 1  //endsave	
		cpu.IF.instruction[102]= 32'b001000_00000_01111_00000_00000_000010;	//addi $t7, $zero, 2	
		cpu.IF.instruction[103]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[104]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[105]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[106]= 32'b000100_01011_01111_00000_00000_011010;	//beq $t3, $t7, EXIT	
		cpu.IF.instruction[107]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[108]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[109]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[110]= 32'b001000_00000_01011_00000_00000_000010;	//addi $t3, $zero, 2	
		cpu.IF.instruction[111]= 32'b000101_01010_00000_00000_00000_000111;	//bne $t2, $zero, ODD2	
		cpu.IF.instruction[112]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[113]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[114]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[115]= 32'b001000_01001_01100_00000_00000_000001;	//addi $t4, $t1, 1	
		cpu.IF.instruction[116]= 32'b000010_00000_00000_00000_00000_011001;	//j isPrime	
		cpu.IF.instruction[117]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[118]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[119]= 32'b001000_01001_01100_00000_00000_000010;	//addi $t4, $t1, 2 //ODD2	
		cpu.IF.instruction[120]= 32'b000010_00000_00000_00000_00000_011001;	//j isPrime	
		cpu.IF.instruction[121]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[122]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[123]= 32'b000000_01100_01011_01100_00000_100000;	//add $t4, $t4, $t3	//nomin
		cpu.IF.instruction[124]= 32'b000010_00000_00000_00000_00000_011001;	//j isPrime	
		cpu.IF.instruction[125]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[126]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[127]= 32'b001000_00000_00101_00000_00000_000010;	//addi $5 2 //special
		cpu.IF.instruction[128]= 32'b001000_00000_00110_00000_00000_000101;	//addi $6 5	
		cpu.IF.instruction[129]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[130]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		cpu.IF.instruction[131]= 32'b101011_00001_00101_00000_00000_000000;	//sw $5 1	
		cpu.IF.instruction[132]= 32'b101011_00010_00110_00000_00000_000000;	//sw $6 2	
		cpu.IF.instruction[133]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)//EXIT	
		cpu.IF.instruction[134]= 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)	
		for (i=135; i<200; i=i+1)  cpu.IF.instruction[ i] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.PC = 0;
		
		
		
	
end

// Data Memory & Register Files initialilation
initial
begin
	cpu.MEM.DM[0] = 32'd1024;
	cpu.MEM.DM[1] = 32'd0;
	for (i=2; i<128; i=i+1) cpu.MEM.DM[i] = 32'b0;
	
	cpu.ID.REG[0] = 32'd0;
	cpu.ID.REG[1] = 32'd1;
	cpu.ID.REG[2] = 32'd2;

	for (i=3; i<32; i=i+1) cpu.ID.REG[i] = 32'b0;
	
	


end

//clock cycle time is 20ns, inverse Clk value per 10ns
initial Clk = 1'b1;
always #(`CYCLE_TIME/2) Clk = ~Clk;

//Rst signal
initial begin
	cycles = 32'b0;
	Rst = 1'b1;
	#12 Rst = 1'b0;
end

CPU cpu(
	.clk(Clk),
	.rst(Rst)
);

//display all Register value and Data memory content
always @(posedge Clk) begin
	cycles <= cycles + 1;
	if (cycles == `INSTRUCTION_NUMBERS) $finish; // Finish when excute the 24-th instruction (End label).
	$display("PC: %d cycles: %d", cpu.FD_PC>>2 , cycles);
	$display("  R00-R07: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[0], cpu.ID.REG[1], cpu.ID.REG[2], cpu.ID.REG[3],cpu.ID.REG[4], cpu.ID.REG[5], cpu.ID.REG[6], cpu.ID.REG[7]);
	$display("  R08-R15: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[8], cpu.ID.REG[9], cpu.ID.REG[10], cpu.ID.REG[11],cpu.ID.REG[12], cpu.ID.REG[13], cpu.ID.REG[14], cpu.ID.REG[15]);
	$display("  R16-R23: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[16], cpu.ID.REG[17], cpu.ID.REG[18], cpu.ID.REG[19],cpu.ID.REG[20], cpu.ID.REG[21], cpu.ID.REG[22], cpu.ID.REG[23]);
	$display("  R24-R31: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[24], cpu.ID.REG[25], cpu.ID.REG[26], cpu.ID.REG[27],cpu.ID.REG[28], cpu.ID.REG[29], cpu.ID.REG[30], cpu.ID.REG[31]);
	$display("  0x00   : %08x %08x %08x %08x %08x %08x %08x %08x", cpu.MEM.DM[0],cpu.MEM.DM[1],cpu.MEM.DM[2],cpu.MEM.DM[3],cpu.MEM.DM[4],cpu.MEM.DM[5],cpu.MEM.DM[6],cpu.MEM.DM[7]);
	$display("  0x08   : %08x %08x %08x %08x %08x %08x %08x %08x", cpu.MEM.DM[8],cpu.MEM.DM[9],cpu.MEM.DM[10],cpu.MEM.DM[11],cpu.MEM.DM[12],cpu.MEM.DM[13],cpu.MEM.DM[14],cpu.MEM.DM[15]);
end

//generate wave file, it can use gtkwave to display
initial begin
	$dumpfile("cpu_hw.vcd");
	$dumpvars;
end
endmodule

