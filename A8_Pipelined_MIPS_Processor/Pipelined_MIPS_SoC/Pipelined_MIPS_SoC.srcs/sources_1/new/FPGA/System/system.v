

module system(
        input clk,
        input reset,
        input [31:0] gpi1,
        input [31:0] gpi2,
        output [31:0] gpO1,
        output [31:0] gpO2
    );
    
    wire [31:0] PC;
    wire [31:0] Instruction;
    wire MemWrite;
    //wire [31:0] address;
    wire [31:0] WriteData;
    wire [31:0] DMemData;
    wire [31:0] FactData;
    wire [31:0] GPIOData;
    wire [31:0] ReadData;
    
    wire WE1;
    wire WE2;
    wire WEM;
    wire [1:0] RdSel;
    
    
    
    imem iMemory(
        .a(PC[7:2]),
        .y(Instruction)        
    );
    
    wire [4:0] dummy5;
    wire [31:0] dummy32;
    wire [31:0] dummy;
    wire [31:0] address;    
    
    mips_pipelined MIPS(
        .clk(clk),
        .rst(reset),
        .ra3(dummy5),
        .we_dm(MemWrite),
        .pc_current(PC),
        .instr(Instruction),
        .alu_out(dummy32),
        .wd_dm(WriteData),
        .rd_dm(ReadData),
        .rd3(dummy),
        .address(address)
    
    );
    
    
    
    dmem dMemory(
        .clk(clk),
        .we(WEM),
        .a(address[7:2]),
        .d(WriteData),
        .q(DMemData)
    );
    
    
    fact_top fact(
        .A(address[3:2]),
        .WE(WE1),
        .WD(WriteData[3:0]),
        .Rst(reset),
        .clk(clk),
        .RD(FactData)
        );
    
    gpio_top gpio(
        .A(address[3:2]),
        .WE(WE2),
        .gpi1(gpi1),
        .gpi2(gpi2),
        .WD(WriteData),
        .RST(reset),
        .CLK(clk),
        .RD(GPIOData),
        .gpo1(gpO1),
        .gpo2(gpO2)
        );

    system_AD AD(
        .WE(MemWrite),
        .A(address),
        .WEM(WEM),
        .WE1(WE1),
        .WE2(WE2),
        .RdSel(RdSel)
        );
        
    mux4 #(32) rdDM_mux(
        .sel(RdSel),
        .a(DMemData),
        .b(DMemData),
        .c(FactData),
        .d(GPIOData),
        .y(ReadData)
    );



endmodule
