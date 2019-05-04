#Clock
    set_property -dict {PACKAGE_PIN E3  IOSTANDARD LVCMOS33} [get_ports {clk100MHz}]; 
    create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk100MHz}];
    
    
	#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets button_clk_IBUF];



#switches
    #n
        set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports {n[0]}];  # Switch 0
        set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports {n[1]}];  # Switch 1
        set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33} [get_ports {n[2]}];  # Switch 2
        set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVCMOS33} [get_ports {n[3]}];  # Switch 3
        set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS33} [get_ports {Sel}];  # Switch 4
        #set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports {Sel];  # Switch 5
#        set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {switches[6]}];  # Switch 6
#        set_property -dict {PACKAGE_PIN R13 IOSTANDARD LVCMOS33} [get_ports {switches[7]}];  # Switch 7
#        set_property -dict {PACKAGE_PIN T8  IOSTANDARD LVCMOS33} [get_ports {switches[8]}];  # Switch 8

    #Buttons
        set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS33} [get_ports {button_clk}]; # Center Button
        set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports {button_rst}]; # Left Button


#LEDs
        set_property -dict {PACKAGE_PIN K13 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[0]}];
        set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[1]}];
        set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[2]}]; 
        set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[3]}]; 
        set_property -dict {PACKAGE_PIN R10 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[4]}]; 
        set_property -dict {PACKAGE_PIN T11 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[5]}];
        set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[6]}];
        set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[7]}]; 
        
        set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[0]}];
        set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[1]}];
        set_property -dict {PACKAGE_PIN T9  IOSTANDARD LVCMOS33} [get_ports {LEDSEL[2]}];
        set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[3]}];
        set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[4]}];
        set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[5]}];
        set_property -dict {PACKAGE_PIN K2  IOSTANDARD LVCMOS33} [get_ports {LEDSEL[6]}];
        set_property -dict {PACKAGE_PIN U13 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[7]}];
    #Inputs out
        #Y
            set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { hex_out[0] }]; #IO_L18P_T2_A24_15 Sch=led[0]
            set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports { hex_out[1] }]; #IO_L24P_T3_RS1_15 Sch=led[1]
            set_property -dict { PACKAGE_PIN J13   IOSTANDARD LVCMOS33 } [get_ports { hex_out[2] }]; #IO_L17N_T2_A25_15 Sch=led[2]
            set_property -dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports { hex_out[3] }]; #IO_L8P_T1_D11_14 Sch=led[3]
            set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { hex_out[4] }]; #IO_L7P_T1_D09_14 Sch=led[4]
            set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { hex_out[5] }]; #IO_L18N_T2_A11_D27_14 Sch=led[5]
            set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { hex_out[6] }]; #IO_L17P_T2_A14_D30_14 Sch=led[6]
            set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports { hex_out[7] }]; #IO_L18P_T2_A12_D28_14 Sch=led[7]
            set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { hex_out[8] }]; #IO_L16N_T2_A15_D31_14 Sch=led[8]
            set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS33 } [get_ports { hex_out[9] }]; #IO_L14N_T2_SRCC_14 Sch=led[9]
            set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { hex_out[10] }]; #IO_L22P_T3_A05_D21_14 Sch=led[10]
            set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { hex_out[11] }]; #IO_L15N_T2_DQS_DOUT_CSO_B_14 Sch=led[11]
            set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { hex_out[12] }]; #IO_L16P_T2_CSI_B_14 Sch=led[12]
            set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports { hex_out[13] }]; #IO_L22N_T3_A04_D20_14 Sch=led[13]
            set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { hex_out[14] }]; #IO_L20N_T3_A07_D23_14 Sch=led[14]
            set_property -dict { PACKAGE_PIN V11 IOSTANDARD LVCMOS33 } [get_ports { hex_out[15] }]; #IO_L21N_T3_DQS_A06_D22_14 Sch=led[15]
        #Done/Err
#            set_property -dict {PACKAGE_PIN V11 IOSTANDARD LVCMOS33} [get_ports {done}];
#            set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports {err}];
#             set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports {factErr}]; #left red RGB
             set_property -dict {PACKAGE_PIN N15 IOSTANDARD LVCMOS33} [get_ports {factErr}]; #right red RGBs
            
            
            #set_property -dict {PACKAGE_PIN R11 IOSTANDARD LVCMOS33} [get_ports {we_dm}];  # LED 0