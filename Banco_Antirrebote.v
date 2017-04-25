`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2017 07:20:05 PM
// Design Name: 
// Module Name: Banco_Antirrebote
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Banco_Antirrebote(
input wire clk,
input wire reset,
input wire [3:0] sw,//4 interruptores
input wire [4:0] btn,//5 botones
output wire [3:0] sw_db,//debounce
output wire [4:0] btn_db//debounce
);

Antirrebote2 Instancia_antirrebote_SW0//SW0: config hora
(
.clk(clk), 
.reset(reset),
.boton(sw[0]),//Entrada original de botón, switch
.db(sw_db[0])//Entrada sin rebote de botón, switch
);

Antirrebote2 Instancia_antirrebote_SW1//SW1: config fecha
(
.clk(clk), 
.reset(reset),
.boton(sw[1]),//Entrada original de botón, switch
.db(sw_db[1])//Entrada sin rebote de botón, switch
);

Antirrebote2 Instancia_antirrebote_SW2//SW2: configura timer
(
.clk(clk), 
.reset(reset),
.boton(sw[2]),//Entrada original de botón, switch
.db(sw_db[2])//Entrada sin rebote de botón, switch
);

Antirrebote2 Instancia_antirrebote_SW3//SW3: formato hora
(
.clk(clk), 
.reset(reset),
.boton(sw[3]),//Entrada original de botón, switch
.db(sw_db[3])//Entrada sin rebote de botón, switch
);

Antirrebote2 Instancia_antirrebote_BTN0//UP
(
.clk(clk), 
.reset(reset),
.boton(btn[0]),//Entrada original de botón, switch
.db(btn_db[0])//Entrada sin rebote de botón, switch
);

Antirrebote2 Instancia_antirrebote_BTN1//DOWN
(
.clk(clk), 
.reset(reset),
.boton(btn[1]),//Entrada original de botón, switch
.db(btn_db[1])//Entrada sin rebote de botón, switch
);

Antirrebote2 Instancia_antirrebote_BTN2//LEFT
(
.clk(clk), 
.reset(reset),
.boton(btn[2]),//Entrada original de botón, switch
.db(btn_db[2])//Entrada sin rebote de botón, switch
);

Antirrebote2 Instancia_antirrebote_BTN3//RIGHT
(
.clk(clk), 
.reset(reset),
.boton(btn[3]),//Entrada original de botón, switch
.db(btn_db[3])//Entrada sin rebote de botón, switch
);

Antirrebote2 Instancia_antirrebote_BTN4//CENTER
(
.clk(clk), 
.reset(reset),
.boton(btn[4]),//Entrada original de botón, switch
.db(btn_db[4])//Entrada sin rebote de botón, switch
);

endmodule
