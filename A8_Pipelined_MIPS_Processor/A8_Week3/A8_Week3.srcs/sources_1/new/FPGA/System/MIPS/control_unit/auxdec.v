module auxdec (
        input  wire [1:0] alu_op,
        input  wire [5:0] funct,
        output wire [3:0] alu_ctrl,
        output wire [1:0] hilo_mux_ctrl,
        output wire hilo_we,
        output wire jr_mux_ctrl
    );

    reg [7:0] ctrl;

    assign {alu_ctrl, hilo_mux_ctrl, hilo_we, jr_mux_ctrl} = ctrl;

    always @ (alu_op, funct) begin
        case (alu_op)
            2'b00: ctrl = 8'b0010_00_0_0;          // ADD
            2'b01: ctrl = 8'b0110_00_0_0;          // SUB
            default: case (funct)
                6'b10_0100: ctrl = 8'b0000_00_0_0; // AND
                6'b10_0101: ctrl = 8'b0001_00_0_0; // OR
                6'b10_0000: ctrl = 8'b0010_00_0_0; // ADD
                6'b10_0010: ctrl = 8'b0110_00_0_0; // SUB
                6'b10_1010: ctrl = 8'b0111_00_0_0; // SLT
                6'b01_1001: ctrl = 8'b1000_00_1_0; // MULTU
                6'b01_0000: ctrl = 8'b0000_11_0_0; // MFHI
                6'b01_0010: ctrl = 8'b0000_01_0_0; // MFLO
                6'b00_0000: ctrl = 8'b1001_00_0_0; // SLL
                6'b00_0010: ctrl = 8'b1010_00_0_0; // SRL
                6'b00_1000: ctrl = 8'b0000_00_0_1; // JR
                default:    ctrl = 8'bxxxx_xx_x_x;
            endcase
        endcase
    end

endmodule