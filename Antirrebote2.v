`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2017 08:31:01 PM
// Design Name: 
// Module Name: Antirrebote2
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


module Antirrebote2
(
    input wire clk, reset,
    input wire boton,//Entrada original de botón, switch
    output reg db//Entrada sin rebote de botón, switch
);

// Declaración de estados simbólica
localparam  [1:0]
Alaire = 2'b00, //Estado que indica que el boton aun no se presiona
wait_one = 2'b01, //Estado que espera que el boton se presione
Presionado = 2'b10, //Estado que indica que el boton esta siendo presionado
wait_zero = 2'b11; //Estado que espera que el boton deje de ser presionado


// Bits del contador para generar una señal periódica de (2^N)*10ns
localparam N =22; 

// Declaración de señales
reg [N-1:0] contador_reg;//Variable del contador en un estado actual
reg [N-1:0] contador_next;//Variable del contador en un estado siguiente, cuando hace alguna cuenta
wire m_tick;//Pulso que se pone en uno solamente si el contador llega a (2^N) conteos
reg [1:0] state_reg, state_next; //Variables para asignar un estado presente y uno siguiente
reg reset_count;//Resetea al contador


//Descripción del comportamiento

//=============================================
// Contador para generar un pulso de(2^N)*10ns
//=============================================
always @(posedge clk, posedge reset_count)
begin
    if (reset_count) contador_reg <= 0; //Cuando el reset es 1 entonces el contador empieza desde 0
	 else contador_reg <= contador_next; //Y si no, entonces sigue contando o empieza a contar
end
always@*
begin
contador_next = contador_reg + 1'b1; //Cumple que el estado siguiente del contador siempre va a ser la suma del estado actual mas uno
end
// Pulso de salida
assign m_tick = (contador_reg == 4194303) ? 1'b1 : 1'b0;//Tiempo que se espera para asegurar el dato de entrada

//=============================================
//=============================================
//              FSM antirrebote
//=============================================
//=============================================
// Registros de estado
always @(posedge clk, posedge reset)
  if (reset)
     state_reg <= Alaire; //Al activar el reset se queda en el estado Alaire
  else
     state_reg <= state_next;//Si no, salta al estado siguiente. 

// Lógica de estado siguiente y salida
   
always @*
   begin
	state_next = state_reg;  //Convierte el estado siguiente en el estado actual cada vez que hace un salto 
    db = 1'b0;               // 
	
	case(state_reg)
	
	Alaire:
	begin
	reset_count = 1'b1;//el reset es uno porque no tiene que hacer cuenta
	db = 1'b0; //No se ha producido el rebote
		if(boton) //si se presiona un boton entonces se pasa al estado siguiente
		begin
		state_next = wait_one; //estado siguiente
		end

		else
		begin
		state_next = Alaire; //Si no, se queda en el estado actual
		end
	end
		
	wait_one:
	begin
	reset_count = 1'b0; //reset del contador es cero porque el contador empieza a contar hasta producir el pulso
	db = 1'b0; //aun no hay rebote producido
		if(m_tick) //Si existe el pulso
		begin
		state_next = Presionado; //Pasa al siguiente estado
		end
		
		else
		begin
		state_next = wait_one; //Si no,se queda el estado actual
		end
	end
	
	Presionado:
	begin
	reset_count = 1'b1; //el contador no cuenta
	db = 1'b1; //se produce la senal de rebote
		if(~boton) //Suelta el boton
		begin
		state_next = wait_zero; //Pasa a un estado siguiente
		end
		
		else
		begin
		state_next = Presionado; //Si no, se queda en el estado actual
		end
	end
	
	wait_zero:
	begin
	reset_count = 1'b0; //Contador empieza a contar hasta generar el pulso
		db = 1'b1; //Senal de rebote producida
		if(m_tick) // Si hay un pulso, entonces pase al estado siguiente
		begin
		state_next = Alaire;
		end
		
		else
		begin
		state_next = wait_zero; //Si no, quedese en el actual
		end
	end	
	endcase
	
   end

endmodule