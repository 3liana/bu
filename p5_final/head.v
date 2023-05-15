`timescale      1ns/1ns

//=============================================================================
//****************************     generate     *******************************
//=============================================================================
`define Ram_size 10'h3ff       //size of ram
`define Rom_size 10'h3ff  
`define CYCLE    100           // generate clock
`define GRF31 5'b11111

`define op 31:26
`define rs 25:21
`define rt 20:16
`define rd 15:11
`define func 5:0

//=============================================================================
//****************************          *******************************
//=============================================================================
`define ALU_SUBU 3'b001
`define ALU_OR 3'b010
`define ALU_ADDU 3'b00
`define ALU_CLZ 3'b011

`define EXT_ZERO 2'b00
`define EXT_SIGN 2'b01
`define EXT_LUI 2'b10
`define EXT_B 2'b11

`define WA_RD 2'b00
`define WA_RT 2'b01
`define WA_31 2'b10

`define NPC_B 3'b001
`define NPC_JAL 3'b010
`define NPC_RS 3'b011
`define NPC_RT 3'b100

`define  MtR_ALUout 2'b00
`define  MtR_MD 2'b01
`define  MtR_PC8 2'b10
`define  MtR_ 2'b11

//Hazard
`define T_ALU 2'b01
`define T_DM  2'b10
`define T_PC  2'b00
//=============================================================================
//****************************     decoder Code    *******************************
//=============================================================================
//instruction identify
`define RTYPE 6'b00_0000
`define RONE 6'b11_1111
//opcode
`define R_ADDU 6'b10_0001
`define R_SUBU 6'b10_0011
`define R_JR 6'b00_1000
`define R_JALR 6'b00_1001
`define R_SPECIAL2 6'b011100
//
`define ORI 6'b00_1101
`define LW 6'b10_0011
`define SW 6'b10_1011
`define BEQ 6'b00_0100
`define LUI 6'b00_1111
`define JAL 6'b00_0011
`define NOP 6'b00_0000
`define J   6'b00_0010
`define BGTZ 6'b00_0111
`define LB 6'b10_0000
`define SB 6'b10_1000
`define SH 6'b10_1001
`define LH 6'b10_0001
`define BGEZALR 6'b0
`define CLZ 6'b100000