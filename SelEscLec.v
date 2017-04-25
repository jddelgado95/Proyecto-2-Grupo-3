`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2017 08:29:53 PM
// Design Name: 
// Module Name: SelEscLec
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


module SelEscLec(
    input clk, 
	input reset,
	input in_flag_dato,//bandera para capturar dato
	input in_direccion_dato,
	input [7:0]in_dato_inicio,
	input in_flag_inicio,
	input [7:0]in_dato,//Datos de entrada para rtc
	output reg [7:0]out_reg_dato,//Datos de salida para banco de registros
	input [7:0]addr_RAM,//Dato de direccion para RAM
	inout tri [7:0]dato, //Dato de RTC
	input controlador_dato //Para controlar condicional si leer o escribir
	);
 
reg [7:0]dato_secundario;
reg [7:0]in_reg_dato;

//*********************************************************
 
// ASIGNACION DE BUS DE 3 ESTADOS
assign dato = (in_flag_dato)? dato_secundario : 8'bZ; //Indica que si se tiene un dato capturado entonces 
//asigne a dato el valor de dato secundario
//Y si no, asigne 8 bits en alta impedancia

 
//CONTROLADOR DE SALIDA
//Mux que controla que entra al banco de registros y que sale o entra a este modulo
always @(dato,controlador_dato,in_direccion_dato,in_reg_dato,addr_RAM)
begin
	case({controlador_dato,in_direccion_dato})
		2'b00: begin dato_secundario = 8'd0; // OPCION LEER DIRECCION NO DEBE PASAR
		out_reg_dato = 8'b0;
		end
		2'b01: begin dato_secundario = 8'd0;//Lee un dato
		out_reg_dato = dato; //Dato va al banco de registros
		end 
		2'b10: begin dato_secundario = addr_RAM;// Escribe una direccion RAM en el bloque de direcciones para el RTC
		out_reg_dato = 8'b0;//no sale nada
		end 
		2'b11: begin  dato_secundario = in_reg_dato;// Escribe un dato en la RTC, ya sea de inicializacion o del usuario
		out_reg_dato = 8'd0;//No sale nada
	end
	endcase
end

//assign dato_direccion = addr_RAM;
always@(posedge clk, posedge reset) 
begin
if (reset) in_reg_dato <= 8'd0; // Si hay un reset entonces no va a entrar ningun dato
else begin
if (in_flag_inicio) in_reg_dato <= in_dato_inicio; //esa bandera indica que se esta en proceso de inicializacion, entonces los datos 
//que entran son los de iniciar la RTC. Se le asignan esos valores al in_reg_dato
else in_reg_dato <= in_dato;//Y si no, es un dato cualquiera que se ingresa. 
end
end

endmodule
