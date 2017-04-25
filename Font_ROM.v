module Font_ROM(
    input wire clk,
    input wire [10:0] addr,
    output reg [7:0] data
   );
   
   // signal declaration
   reg [10:0] addr_reg; 

   // body
   always @(posedge clk) 
      addr_reg <= addr;
      
   always @*
case (addr_reg)
         //code x00
         11'h000: data = 8'b00000000; //  cambiar a 8
         11'h001: data = 8'b00000000; // 
         11'h002: data = 8'b00000000; // 
         11'h003: data = 8'b00000000; // 
         11'h004: data = 8'b00000000; // 
         11'h005: data = 8'b00000000; // 
         11'h006: data = 8'b00000000; // 
         11'h007: data = 8'b00000000; // 
         11'h008: data = 8'b00000000; // 
         11'h009: data = 8'b00000000; // 
         11'h00a: data = 8'b00000000; // 
         11'h00b: data = 8'b00000000; // 
         11'h00c: data = 8'b00000000; // 
         11'h00d: data = 8'b00000000; // 
         11'h00e: data = 8'b00000000; // 
         11'h00f: data = 8'b00000000; // 
         
         //code x2f
         11'h2f0: data = 8'b00000000; // 
         11'h2f1: data = 8'b00000000; // 
         11'h2f2: data = 8'b00000000; // 
         11'h2f3: data = 8'b00000000; // 
         11'h2f4: data = 8'b00000010; //       *
         11'h2f5: data = 8'b00000110; //      **
         11'h2f6: data = 8'b00001100; //     **
         11'h2f7: data = 8'b00011000; //    **
         11'h2f8: data = 8'b00110000; //   **
         11'h2f9: data = 8'b01100000; //  **
         11'h2fa: data = 8'b11000000; // **
         11'h2fb: data = 8'b10000000; // *
         11'h2fc: data = 8'b00000000; // 
         11'h2fd: data = 8'b00000000; // 
         11'h2fe: data = 8'b00000000; // 
         11'h2ff: data = 8'b00000000; // 
         
         //code x30
         11'h300: data = 8'b00000000; // 
         11'h301: data = 8'b00000000; // 
         11'h302: data = 8'b01111100; //  *****
         11'h303: data = 8'b11000110; // **   **
         11'h304: data = 8'b11000110; // **   **
         11'h305: data = 8'b11001110; // **  ***
         11'h306: data = 8'b11011110; // ** ****
         11'h307: data = 8'b11110110; // **** **
         11'h308: data = 8'b11100110; // ***  **
         11'h309: data = 8'b11000110; // **   **
         11'h30a: data = 8'b11000110; // **   **
         11'h30b: data = 8'b01111100; //  *****
         11'h30c: data = 8'b00000000; // 
         11'h30d: data = 8'b00000000; // 
         11'h30e: data = 8'b00000000; // 
         11'h30f: data = 8'b00000000; // 
         //code x31
         11'h310: data = 8'b00000000; // 
         11'h311: data = 8'b00000000; // 
         11'h312: data = 8'b00011000; // 
         11'h313: data = 8'b00111000; // 
         11'h314: data = 8'b01111000; //    **
         11'h315: data = 8'b00011000; //   ***
         11'h316: data = 8'b00011000; //  ****
         11'h317: data = 8'b00011000; //    **
         11'h318: data = 8'b00011000; //    **
         11'h319: data = 8'b00011000; //    **
         11'h31a: data = 8'b00011000; //    **
         11'h31b: data = 8'b01111110; //    **
         11'h31c: data = 8'b00000000; //    **
         11'h31d: data = 8'b00000000; //  ******
         11'h31e: data = 8'b00000000; // 
         11'h31f: data = 8'b00000000; // 
          //code x32
         11'h320: data = 8'b00000000; // 
         11'h321: data = 8'b00000000; // 
         11'h322: data = 8'b01111100; //  *****
         11'h323: data = 8'b11000110; // **   **
         11'h324: data = 8'b00000110; //      **
         11'h325: data = 8'b00001100; //     **
         11'h326: data = 8'b00011000; //    **
         11'h327: data = 8'b00110000; //   **
         11'h328: data = 8'b01100000; //  **
         11'h329: data = 8'b11000000; // **
         11'h32a: data = 8'b11000110; // **   **
         11'h32b: data = 8'b11111110; // *******
         11'h32c: data = 8'b00000000; // 
         11'h32d: data = 8'b00000000; // 
         11'h32e: data = 8'b00000000; // 
         11'h32f: data = 8'b00000000; // 
         //code x33
         11'h330: data = 8'b00000000; // 
         11'h331: data = 8'b00000000; // 
         11'h332: data = 8'b01111100; //  *****
         11'h333: data = 8'b11000110; // **   **
         11'h334: data = 8'b00000110; //      **
         11'h335: data = 8'b00000110; //      **
         11'h336: data = 8'b00111100; //   ****
         11'h337: data = 8'b00000110; //      **
         11'h338: data = 8'b00000110; //      **
         11'h339: data = 8'b00000110; //      **
         11'h33a: data = 8'b11000110; // **   **
         11'h33b: data = 8'b01111100; //  *****
         11'h33c: data = 8'b00000000; // 
         11'h33d: data = 8'b00000000; // 
         11'h33e: data = 8'b00000000; // 
         11'h33f: data = 8'b00000000; // 
         //code x34
         11'h340: data = 8'b00000000; // 
         11'h341: data = 8'b00000000; // 
         11'h342: data = 8'b00001100; //     **
         11'h343: data = 8'b00011100; //    ***
         11'h344: data = 8'b00111100; //   ****
         11'h345: data = 8'b01101100; //  ** **
         11'h346: data = 8'b11001100; // **  **
         11'h347: data = 8'b11111110; // *******
         11'h348: data = 8'b00001100; //     **
         11'h349: data = 8'b00001100; //     **
         11'h34a: data = 8'b00001100; //     **
         11'h34b: data = 8'b00011110; //    ****
         11'h34c: data = 8'b00000000; // 
         11'h34d: data = 8'b00000000; // 
         11'h34e: data = 8'b00000000; // 
         11'h34f: data = 8'b00000000; // 
          //code x35
         11'h350: data = 8'b00000000; // 
         11'h351: data = 8'b00000000; // 
         11'h352: data = 8'b11111110; // *******
         11'h353: data = 8'b11000000; // **
         11'h354: data = 8'b11000000; // **
         11'h355: data = 8'b11000000; // **
         11'h356: data = 8'b11111100; // ******
         11'h357: data = 8'b00000110; //      **
         11'h358: data = 8'b00000110; //      **
         11'h359: data = 8'b00000110; //      **
         11'h35a: data = 8'b11000110; // **   **
         11'h35b: data = 8'b01111100; //  *****
         11'h35c: data = 8'b00000000; // 
         11'h35d: data = 8'b00000000; // 
         11'h35e: data = 8'b00000000; // 
         11'h35f: data = 8'b00000000; // 
         //code x36
         11'h360: data = 8'b00000000; // 
         11'h361: data = 8'b00000000; // 
         11'h362: data = 8'b00111000; //   ***
         11'h363: data = 8'b01100000; //  **
         11'h364: data = 8'b11000000; // **
         11'h365: data = 8'b11000000; // **
         11'h366: data = 8'b11111100; // ******
         11'h367: data = 8'b11000110; // **   **
         11'h368: data = 8'b11000110; // **   **
         11'h369: data = 8'b11000110; // **   **
         11'h36a: data = 8'b11000110; // **   **
         11'h36b: data = 8'b01111100; //  *****
         11'h36c: data = 8'b00000000; // 
         11'h36d: data = 8'b00000000; // 
         11'h36e: data = 8'b00000000; // 
         11'h36f: data = 8'b00000000; // 
          //code x37
         11'h370: data = 8'b00000000; // 
         11'h371: data = 8'b00000000; // 
         11'h372: data = 8'b11111110; // *******
         11'h373: data = 8'b11000110; // **   **
         11'h374: data = 8'b00000110; //      **
         11'h375: data = 8'b00000110; //      **
         11'h376: data = 8'b00001100; //     **
         11'h377: data = 8'b00011000; //    **
         11'h378: data = 8'b00110000; //   **
         11'h379: data = 8'b00110000; //   **
         11'h37a: data = 8'b00110000; //   **
         11'h37b: data = 8'b00110000; //   **
         11'h37c: data = 8'b00000000; // 
         11'h37d: data = 8'b00000000; // 
         11'h37e: data = 8'b00000000; // 
         11'h37f: data = 8'b00000000; // 
        //code x38
         11'h380: data = 8'b00000000; // 
         11'h381: data = 8'b00000000; // 
         11'h382: data = 8'b01111100; //  *****
         11'h383: data = 8'b11000110; // **   **
         11'h384: data = 8'b11000110; // **   **
         11'h385: data = 8'b11000110; // **   **
         11'h386: data = 8'b01111100; //  *****
         11'h387: data = 8'b11000110; // **   **
         11'h388: data = 8'b11000110; // **   **
         11'h389: data = 8'b11000110; // **   **
         11'h38a: data = 8'b11000110; // **   **
         11'h38b: data = 8'b01111100; //  *****
         11'h38c: data = 8'b00000000; // 
         11'h38d: data = 8'b00000000; // 
         11'h38e: data = 8'b00000000; // 
         11'h38f: data = 8'b00000000; // 
         //code x39
         11'h390: data = 8'b00000000; // 
         11'h391: data = 8'b00000000; // 
         11'h392: data = 8'b01111100; //  *****
         11'h393: data = 8'b11000110; // **   **
         11'h394: data = 8'b11000110; // **   **
         11'h395: data = 8'b11000110; // **   **
         11'h396: data = 8'b01111110; //  ******
         11'h397: data = 8'b00000110; //      **
         11'h398: data = 8'b00000110; //      **
         11'h399: data = 8'b00000110; //      **
         11'h39a: data = 8'b00001100; //     **
         11'h39b: data = 8'b01111000; //  ****
         11'h39c: data = 8'b00000000; // 
         11'h39d: data = 8'b00000000; // 
         11'h39e: data = 8'b00000000; // 
         11'h39f: data = 8'b00000000; //
         //code x3a 
         11'h3a0: data = 8'b00000000; // 
         11'h3a1: data = 8'b00000000; // 
         11'h3a2: data = 8'b00000000; // 
         11'h3a3: data = 8'b00000000; // 
         11'h3a4: data = 8'b00011000; //    **
         11'h3a5: data = 8'b00011000; //    **
         11'h3a6: data = 8'b00000000; // 
         11'h3a7: data = 8'b00000000; // 
         11'h3a8: data = 8'b00000000; // 
         11'h3a9: data = 8'b00011000; //    **
         11'h3aa: data = 8'b00011000; //    **
         11'h3ab: data = 8'b00000000; // 
         11'h3ac: data = 8'b00000000; // 
         11'h3ad: data = 8'b00000000; // 
         11'h3ae: data = 8'b00000000; // 
         11'h3af: data = 8'b00000000; // 
         //code x41 
         11'h410: data = 8'b00000000; // 
         11'h411: data = 8'b00000000; // 
         11'h412: data = 8'b00010000; //    *
         11'h413: data = 8'b00111000; //   ***
         11'h414: data = 8'b01101100; //  ** **
         11'h415: data = 8'b11000110; // **   **
         11'h416: data = 8'b11000110; // **   **
         11'h417: data = 8'b11111110; // *******
         11'h418: data = 8'b11000110; // **   **
         11'h419: data = 8'b11000110; // **   **
         11'h41a: data = 8'b11000110; // **   **
         11'h41b: data = 8'b11000110; // **   **
         11'h41c: data = 8'b00000000; // 
         11'h41d: data = 8'b00000000; // 
         11'h41e: data = 8'b00000000; // 
         11'h41f: data = 8'b00000000; // 
         //code x42 
         11'h420: data = 8'b00000000; // 
         11'h421: data = 8'b00000000; // 
         11'h422: data = 8'b11111100; // ******
         11'h423: data = 8'b01100110; //  **  **
         11'h424: data = 8'b01100110; //  **  **
         11'h425: data = 8'b01100110; //  **  **
         11'h426: data = 8'b01111100; //  *****
         11'h427: data = 8'b01100110; //  **  **
         11'h428: data = 8'b01100110; //  **  **
         11'h429: data = 8'b01100110; //  **  **
         11'h42a: data = 8'b01100110; //  **  **
         11'h42b: data = 8'b11111100; // ******
         11'h42c: data = 8'b00000000; // 
         11'h42d: data = 8'b00000000; // 
         11'h42e: data = 8'b00000000; // 
         11'h42f: data = 8'b00000000; // 
         //code x43 
         11'h430: data = 8'b00000000; // 
         11'h431: data = 8'b00000000; // 
         11'h432: data = 8'b00111100; //   ****
         11'h433: data = 8'b01100110; //  **  **
         11'h434: data = 8'b11000010; // **    *
         11'h435: data = 8'b11000000; // **
         11'h436: data = 8'b11000000; // **
         11'h437: data = 8'b11000000; // **
         11'h438: data = 8'b11000000; // **
         11'h439: data = 8'b11000010; // **    *
         11'h43a: data = 8'b01100110; //  **  **
         11'h43b: data = 8'b00111100; //   ****
         11'h43c: data = 8'b00000000; // 
         11'h43d: data = 8'b00000000; // 
         11'h43e: data = 8'b00000000; // 
         11'h43f: data = 8'b00000000; // 
         //code x44 
         11'h440: data = 8'b00000000; // 
         11'h441: data = 8'b00000000; // 
         11'h442: data = 8'b11111000; // *****
         11'h443: data = 8'b01101100; //  ** **
         11'h444: data = 8'b01100110; //  **  **
         11'h445: data = 8'b01100110; //  **  **
         11'h446: data = 8'b01100110; //  **  **
         11'h447: data = 8'b01100110; //  **  **
         11'h448: data = 8'b01100110; //  **  **
         11'h449: data = 8'b01100110; //  **  **
         11'h44a: data = 8'b01101100; //  ** **
         11'h44b: data = 8'b11111000; // *****
         11'h44c: data = 8'b00000000; // 
         11'h44d: data = 8'b00000000; // 
         11'h44e: data = 8'b00000000; // 
         11'h44f: data = 8'b00000000; // 
         //code x45 
         11'h450: data = 8'b00000000; // 
         11'h451: data = 8'b00000000; // 
         11'h452: data = 8'b11111110; // *******
         11'h453: data = 8'b01100110; //  **  **
         11'h454: data = 8'b01100010; //  **   *
         11'h455: data = 8'b01101000; //  ** *
         11'h456: data = 8'b01111000; //  ****
         11'h457: data = 8'b01101000; //  ** *
         11'h458: data = 8'b01100000; //  **
         11'h459: data = 8'b01100010; //  **   *
         11'h45a: data = 8'b01100110; //  **  **
         11'h45b: data = 8'b11111110; // *******
         11'h45c: data = 8'b00000000; // 
         11'h45d: data = 8'b00000000; // 
         11'h45e: data = 8'b00000000; // 
         11'h45f: data = 8'b00000000; // 
         //code x46 
         11'h460: data = 8'b00000000; // 
         11'h461: data = 8'b00000000; // 
         11'h462: data = 8'b11111110; // *******
         11'h463: data = 8'b01100110; //  **  **
         11'h464: data = 8'b01100010; //  **   *
         11'h465: data = 8'b01101000; //  ** *
         11'h466: data = 8'b01111000; //  ****
         11'h467: data = 8'b01101000; //  ** *
         11'h468: data = 8'b01100000; //  **
         11'h469: data = 8'b01100000; //  **
         11'h46a: data = 8'b01100000; //  **
         11'h46b: data = 8'b11110000; // ****
         11'h46c: data = 8'b00000000; // 
         11'h46d: data = 8'b00000000; // 
         11'h46e: data = 8'b00000000; // 
         11'h46f: data = 8'b00000000; // 
         //code x47 
         11'h470: data = 8'b00000000; // 
         11'h471: data = 8'b00000000; // 
         11'h472: data = 8'b00111100; //   ****
         11'h473: data = 8'b01100110; //  **  **
         11'h474: data = 8'b11000010; // **    *
         11'h475: data = 8'b11000000; // **
         11'h476: data = 8'b11000000; // **
         11'h477: data = 8'b11011110; // ** ****
         11'h478: data = 8'b11000110; // **   **
         11'h479: data = 8'b11000110; // **   **
         11'h47a: data = 8'b01100110; //  **  **
         11'h47b: data = 8'b00111010; //   *** *
         11'h47c: data = 8'b00000000; // 
         11'h47d: data = 8'b00000000; // 
         11'h47e: data = 8'b00000000; // 
         11'h47f: data = 8'b00000000; // 
         //code x48 
         11'h480: data = 8'b00000000; // 
         11'h481: data = 8'b00000000; // 
         11'h482: data = 8'b11000110; // **   **
         11'h483: data = 8'b11000110; // **   **
         11'h484: data = 8'b11000110; // **   **
         11'h485: data = 8'b11000110; // **   **
         11'h486: data = 8'b11111110; // *******
         11'h487: data = 8'b11000110; // **   **
         11'h488: data = 8'b11000110; // **   **
         11'h489: data = 8'b11000110; // **   **
         11'h48a: data = 8'b11000110; // **   **
         11'h48b: data = 8'b11000110; // **   **
         11'h48c: data = 8'b00000000; // 
         11'h48d: data = 8'b00000000; // 
         11'h48e: data = 8'b00000000; // 
         11'h48f: data = 8'b00000000; // 
         //code x49 
         11'h490: data = 8'b00000000; // 
         11'h491: data = 8'b00000000; // 
         11'h492: data = 8'b00111100; //   ****
         11'h493: data = 8'b00011000; //    **
         11'h494: data = 8'b00011000; //    **
         11'h495: data = 8'b00011000; //    **
         11'h496: data = 8'b00011000; //    **
         11'h497: data = 8'b00011000; //    **
         11'h498: data = 8'b00011000; //    **
         11'h499: data = 8'b00011000; //    **
         11'h49a: data = 8'b00011000; //    **
         11'h49b: data = 8'b00111100; //   ****
         11'h49c: data = 8'b00000000; // 
         11'h49d: data = 8'b00000000; // 
         11'h49e: data = 8'b00000000; // 
         11'h49f: data = 8'b00000000; // 
  //code x4a   
         11'h4a0: data = 8'b00000000; // 
         11'h4a1: data = 8'b00000000; // 
         11'h4a2: data = 8'b00011110; //    ****
         11'h4a3: data = 8'b00001100; //     **
         11'h4a4: data = 8'b00001100; //     **
         11'h4a5: data = 8'b00001100; //     **
         11'h4a6: data = 8'b00001100; //     **
         11'h4a7: data = 8'b00001100; //     **
         11'h4a8: data = 8'b11001100; // **  **
         11'h4a9: data = 8'b11001100; // **  **
         11'h4aa: data = 8'b11001100; // **  **
         11'h4ab: data = 8'b01111000; //  ****
         11'h4ac: data = 8'b00000000; // 
         11'h4ad: data = 8'b00000000; // 
         11'h4ae: data = 8'b00000000; // 
         11'h4af: data = 8'b00000000; // 
         //code x4b   
         11'h4b0: data = 8'b00000000; // 
         11'h4b1: data = 8'b00000000; // 
         11'h4b2: data = 8'b11100110; // ***  **
         11'h4b3: data = 8'b01100110; //  **  **
         11'h4b4: data = 8'b01100110; //  **  **
         11'h4b5: data = 8'b01101100; //  ** **
         11'h4b6: data = 8'b01111000; //  ****
         11'h4b7: data = 8'b01111000; //  ****
         11'h4b8: data = 8'b01101100; //  ** **
         11'h4b9: data = 8'b01100110; //  **  **
         11'h4ba: data = 8'b01100110; //  **  **
         11'h4bb: data = 8'b11100110; // ***  **
         11'h4bc: data = 8'b00000000; // 
         11'h4bd: data = 8'b00000000; // 
         11'h4be: data = 8'b00000000; // 
         11'h4bf: data = 8'b00000000; // 
         //code x4c   
         11'h4c0: data = 8'b00000000; // 
         11'h4c1: data = 8'b00000000; // 
         11'h4c2: data = 8'b11110000; // ****
         11'h4c3: data = 8'b01100000; //  **
         11'h4c4: data = 8'b01100000; //  **
         11'h4c5: data = 8'b01100000; //  **
         11'h4c6: data = 8'b01100000; //  **
         11'h4c7: data = 8'b01100000; //  **
         11'h4c8: data = 8'b01100000; //  **
         11'h4c9: data = 8'b01100010; //  **   *
         11'h4ca: data = 8'b01100110; //  **  **
         11'h4cb: data = 8'b11111110; // *******
         11'h4cc: data = 8'b00000000; // 
         11'h4cd: data = 8'b00000000; // 
         11'h4ce: data = 8'b00000000; // 
         11'h4cf: data = 8'b00000000; // 
          //code x4d   
         11'h4d0: data = 8'b00000000; // 
         11'h4d1: data = 8'b00000000; // 
         11'h4d2: data = 8'b11000011; // **    **
         11'h4d3: data = 8'b11100111; // ***  ***
         11'h4d4: data = 8'b11111111; // ********
         11'h4d5: data = 8'b11111111; // ********
         11'h4d6: data = 8'b11011011; // ** ** **
         11'h4d7: data = 8'b11000011; // **    **
         11'h4d8: data = 8'b11000011; // **    **
         11'h4d9: data = 8'b11000011; // **    **
         11'h4da: data = 8'b11000011; // **    **
         11'h4db: data = 8'b11000011; // **    **
         11'h4dc: data = 8'b00000000; // 
         11'h4dd: data = 8'b00000000; // 
         11'h4de: data = 8'b00000000; // 
         11'h4df: data = 8'b00000000; // 
         //code x4e   
         11'h4e0: data = 8'b00000000; // 
         11'h4e1: data = 8'b00000000; // 
         11'h4e2: data = 8'b11000110; // **   **
         11'h4e3: data = 8'b11100110; // ***  **
         11'h4e4: data = 8'b11110110; // **** **
         11'h4e5: data = 8'b11111110; // *******
         11'h4e6: data = 8'b11011110; // ** ****
         11'h4e7: data = 8'b11001110; // **  ***
         11'h4e8: data = 8'b11000110; // **   **
         11'h4e9: data = 8'b11000110; // **   **
         11'h4ea: data = 8'b11000110; // **   **
         11'h4eb: data = 8'b11000110; // **   **
         11'h4ec: data = 8'b00000000; // 
         11'h4ed: data = 8'b00000000; // 
         11'h4ee: data = 8'b00000000; // 
         11'h4ef: data = 8'b00000000; // 
         //code x4f   
         11'h4f0: data = 8'b00000000; // 
         11'h4f1: data = 8'b00000000; // 
         11'h4f2: data = 8'b01111100; //  *****
         11'h4f3: data = 8'b11000110; // **   **
         11'h4f4: data = 8'b11000110; // **   **
         11'h4f5: data = 8'b11000110; // **   **
         11'h4f6: data = 8'b11000110; // **   **
         11'h4f7: data = 8'b11000110; // **   **
         11'h4f8: data = 8'b11000110; // **   **
         11'h4f9: data = 8'b11000110; // **   **
         11'h4fa: data = 8'b11000110; // **   **
         11'h4fb: data = 8'b01111100; //  *****
         11'h4fc: data = 8'b00000000; // 
         11'h4fd: data = 8'b00000000; // 
         11'h4fe: data = 8'b00000000; // 
         11'h4ff: data = 8'b00000000; // 
         //code x50   
         11'h500: data = 8'b00000000; // 
         11'h501: data = 8'b00000000; // 
         11'h502: data = 8'b11111100; // ******
         11'h503: data = 8'b01100110; //  **  **
         11'h504: data = 8'b01100110; //  **  **
         11'h505: data = 8'b01100110; //  **  **
         11'h506: data = 8'b01111100; //  *****
         11'h507: data = 8'b01100000; //  **
         11'h508: data = 8'b01100000; //  **
         11'h509: data = 8'b01100000; //  **
         11'h50a: data = 8'b01100000; //  **
         11'h50b: data = 8'b11110000; // ****
         11'h50c: data = 8'b00000000; // 
         11'h50d: data = 8'b00000000; // 
         11'h50e: data = 8'b00000000; //  
         11'h50f: data = 8'b00000000; //    
        //code x510f
         11'h510: data = 8'b00000000; // 
         11'h511: data = 8'b00000000; // 
         11'h512: data = 8'b01111100; //  *****
         11'h513: data = 8'b11000110; // **   **
         11'h514: data = 8'b11000110; // **   **
         11'h515: data = 8'b11000110; // **   **
         11'h516: data = 8'b11000110; // **   **
         11'h517: data = 8'b11000110; // **   **
         11'h518: data = 8'b11000110; // **   **
         11'h519: data = 8'b11010110; // ** * **
         11'h51a: data = 8'b11011110; // ** ****
         11'h51b: data = 8'b01111100; //  *****
         11'h51c: data = 8'b00001100; //     **
         11'h51d: data = 8'b00001110; //     ***
         11'h51e: data = 8'b00000000; // 
         11'h51f: data = 8'b00000000; // 
         //code x52   
         11'h520: data = 8'b00000000; // 
         11'h521: data = 8'b00000000; // 
         11'h522: data = 8'b11111100; // ******
         11'h523: data = 8'b01100110; //  **  **
         11'h524: data = 8'b01100110; //  **  **
         11'h525: data = 8'b01100110; //  **  **
         11'h526: data = 8'b01111100; //  *****
         11'h527: data = 8'b01101100; //  ** **
         11'h528: data = 8'b01100110; //  **  **
         11'h529: data = 8'b01100110; //  **  **
         11'h52a: data = 8'b01100110; //  **  **
         11'h52b: data = 8'b11100110; // ***  **
         11'h52c: data = 8'b00000000; // 
         11'h52d: data = 8'b00000000; // 
         11'h52e: data = 8'b00000000; // 
         11'h52f: data = 8'b00000000; // 
         //code x53   
         11'h530: data = 8'b00000000; // 
         11'h531: data = 8'b00000000; // 
         11'h532: data = 8'b01111100; //  *****
         11'h533: data = 8'b11000110; // **   **
         11'h534: data = 8'b11000110; // **   **
         11'h535: data = 8'b01100000; //  **
         11'h536: data = 8'b00111000; //   ***
         11'h537: data = 8'b00001100; //     **
         11'h538: data = 8'b00000110; //      **
         11'h539: data = 8'b11000110; // **   **
         11'h53a: data = 8'b11000110; // **   **
         11'h53b: data = 8'b01111100; //  *****
         11'h53c: data = 8'b00000000; // 
         11'h53d: data = 8'b00000000; // 
         11'h53e: data = 8'b00000000; // 
         11'h53f: data = 8'b00000000; // 
          //code x54   
         11'h540: data = 8'b00000000; // 
         11'h541: data = 8'b00000000; // 
         11'h542: data = 8'b11111111; // ********
         11'h543: data = 8'b11011011; // ** ** **
         11'h544: data = 8'b10011001; // *  **  *
         11'h545: data = 8'b00011000; //    **
         11'h546: data = 8'b00011000; //    **
         11'h547: data = 8'b00011000; //    **
         11'h548: data = 8'b00011000; //    **
         11'h549: data = 8'b00011000; //    **
         11'h54a: data = 8'b00011000; //    **
         11'h54b: data = 8'b00111100; //   ****
         11'h54c: data = 8'b00000000; // 
         11'h54d: data = 8'b00000000; // 
         11'h54e: data = 8'b00000000; // 
         11'h54f: data = 8'b00000000; // 
         //code x55   
         11'h550: data = 8'b00000000; // 
         11'h551: data = 8'b00000000; // 
         11'h552: data = 8'b11000110; // **   **
         11'h553: data = 8'b11000110; // **   **
         11'h554: data = 8'b11000110; // **   **
         11'h555: data = 8'b11000110; // **   **
         11'h556: data = 8'b11000110; // **   **
         11'h557: data = 8'b11000110; // **   **
         11'h558: data = 8'b11000110; // **   **
         11'h559: data = 8'b11000110; // **   **
         11'h55a: data = 8'b11000110; // **   **
         11'h55b: data = 8'b01111100; //  *****
         11'h55c: data = 8'b00000000; // 
         11'h55d: data = 8'b00000000; // 
         11'h55e: data = 8'b00000000; // 
         11'h55f: data = 8'b00000000; // 
         //code x56   
         11'h560: data = 8'b00000000; // 
         11'h561: data = 8'b00000000; // 
         11'h562: data = 8'b11000011; // **    **
         11'h563: data = 8'b11000011; // **    **
         11'h564: data = 8'b11000011; // **    **
         11'h565: data = 8'b11000011; // **    **
         11'h566: data = 8'b11000011; // **    **
         11'h567: data = 8'b11000011; // **    **
         11'h568: data = 8'b11000011; // **    **
         11'h569: data = 8'b01100110; //  **  **
         11'h56a: data = 8'b00111100; //   ****
         11'h56b: data = 8'b00011000; //    **
         11'h56c: data = 8'b00000000; // 
         11'h56d: data = 8'b00000000; // 
         11'h56e: data = 8'b00000000; // 
         11'h56f: data = 8'b00000000; // 
         //code x57   
         11'h570: data = 8'b00000000; // 
         11'h571: data = 8'b00000000; // 
         11'h572: data = 8'b11000011; // **    **
         11'h573: data = 8'b11000011; // **    **
         11'h574: data = 8'b11000011; // **    **
         11'h575: data = 8'b11000011; // **    **
         11'h576: data = 8'b11000011; // **    **
         11'h577: data = 8'b11011011; // ** ** **
         11'h578: data = 8'b11011011; // ** ** **
         11'h579: data = 8'b11111111; // ********
         11'h57a: data = 8'b01100110; //  **  **
         11'h57b: data = 8'b01100110; //  **  **
         11'h57c: data = 8'b00000000; // 
         11'h57d: data = 8'b00000000; // 
         11'h57e: data = 8'b00000000; // 
         11'h57f: data = 8'b00000000; // 
         //code x58   
         11'h580: data = 8'b00000000; // 
         11'h581: data = 8'b00000000; // 
         11'h582: data = 8'b11000011; // **    **
         11'h583: data = 8'b11000011; // **    **
         11'h584: data = 8'b01100110; //  **  **
         11'h585: data = 8'b00111100; //   ****
         11'h586: data = 8'b00011000; //    **
         11'h587: data = 8'b00011000; //    **
         11'h588: data = 8'b00111100; //   ****
         11'h589: data = 8'b01100110; //  **  **
         11'h58a: data = 8'b11000011; // **    **
         11'h58b: data = 8'b11000011; // **    **
         11'h58c: data = 8'b00000000; // 
         11'h58d: data = 8'b00000000; // 
         11'h58e: data = 8'b00000000; // 
         11'h58f: data = 8'b00000000; // 
          //code x59   
         11'h590: data = 8'b00000000; // 
         11'h591: data = 8'b00000000; // 
         11'h592: data = 8'b11000011; // **    **
         11'h593: data = 8'b11000011; // **    **
         11'h594: data = 8'b11000011; // **    **
         11'h595: data = 8'b01100110; //  **  **
         11'h596: data = 8'b00111100; //   ****
         11'h597: data = 8'b00011000; //    **
         11'h598: data = 8'b00011000; //    **
         11'h599: data = 8'b00011000; //    **
         11'h59a: data = 8'b00011000; //    **
         11'h59b: data = 8'b00111100; //   ****
         11'h59c: data = 8'b00000000; // 
         11'h59d: data = 8'b00000000; // 
         11'h59e: data = 8'b00000000; // 
         11'h59f: data = 8'b00000000; // 
         //code x5a   
         11'h5a0: data = 8'b00000000; // 
         11'h5a1: data = 8'b00000000; // 
         11'h5a2: data = 8'b11111111; // ********
         11'h5a3: data = 8'b11000011; // **    **
         11'h5a4: data = 8'b10000110; // *    **
         11'h5a5: data = 8'b00001100; //     **
         11'h5a6: data = 8'b00011000; //    **
         11'h5a7: data = 8'b00110000; //   **
         11'h5a8: data = 8'b01100000; //  **
         11'h5a9: data = 8'b11000001; // **     *
         11'h5aa: data = 8'b11000011; // **    **
         11'h5ab: data = 8'b11111111; // ********
         11'h5ac: data = 8'b00000000; // 
         11'h5ad: data = 8'b00000000; // 
         11'h5ae: data = 8'b00000000; // 
         11'h5af: data = 8'b00000000; //  
         default: data= 8'b00000000; //  
         endcase  
                     
       endmodule         