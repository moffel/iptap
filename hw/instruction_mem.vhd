
--
-- Definition of a single port ROM for KCPSM3 program defined by instruction_mem.psm
--
-- Generated by KCPSM3 Assembler 30-Apr-2015 23:47:36. 
--
-- Standard IEEE libraries
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--
-- The Unisim Library is used to define Xilinx primitives. It is also used during
-- simulation. The source can be viewed at %XILINX%\vhdl\src\unisims\unisim_VCOMP.vhd
--  
library unisim;
use unisim.vcomponents.all;
--
--
entity instruction_mem is
    Port (      address : in std_logic_vector(9 downto 0);
            instruction : out std_logic_vector(17 downto 0);
                    clk : in std_logic);
    end instruction_mem;
--
architecture low_level_definition of instruction_mem is
--
-- Attributes to define ROM contents during implementation synthesis. 
-- The information is repeated in the generic map for functional simulation
--
attribute INIT_00 : string; 
attribute INIT_01 : string; 
attribute INIT_02 : string; 
attribute INIT_03 : string; 
attribute INIT_04 : string; 
attribute INIT_05 : string; 
attribute INIT_06 : string; 
attribute INIT_07 : string; 
attribute INIT_08 : string; 
attribute INIT_09 : string; 
attribute INIT_0A : string; 
attribute INIT_0B : string; 
attribute INIT_0C : string; 
attribute INIT_0D : string; 
attribute INIT_0E : string; 
attribute INIT_0F : string; 
attribute INIT_10 : string; 
attribute INIT_11 : string; 
attribute INIT_12 : string; 
attribute INIT_13 : string; 
attribute INIT_14 : string; 
attribute INIT_15 : string; 
attribute INIT_16 : string; 
attribute INIT_17 : string; 
attribute INIT_18 : string; 
attribute INIT_19 : string; 
attribute INIT_1A : string; 
attribute INIT_1B : string; 
attribute INIT_1C : string; 
attribute INIT_1D : string; 
attribute INIT_1E : string; 
attribute INIT_1F : string; 
attribute INIT_20 : string; 
attribute INIT_21 : string; 
attribute INIT_22 : string; 
attribute INIT_23 : string; 
attribute INIT_24 : string; 
attribute INIT_25 : string; 
attribute INIT_26 : string; 
attribute INIT_27 : string; 
attribute INIT_28 : string; 
attribute INIT_29 : string; 
attribute INIT_2A : string; 
attribute INIT_2B : string; 
attribute INIT_2C : string; 
attribute INIT_2D : string; 
attribute INIT_2E : string; 
attribute INIT_2F : string; 
attribute INIT_30 : string; 
attribute INIT_31 : string; 
attribute INIT_32 : string; 
attribute INIT_33 : string; 
attribute INIT_34 : string; 
attribute INIT_35 : string; 
attribute INIT_36 : string; 
attribute INIT_37 : string; 
attribute INIT_38 : string; 
attribute INIT_39 : string; 
attribute INIT_3A : string; 
attribute INIT_3B : string; 
attribute INIT_3C : string; 
attribute INIT_3D : string; 
attribute INIT_3E : string; 
attribute INIT_3F : string; 
attribute INITP_00 : string;
attribute INITP_01 : string;
attribute INITP_02 : string;
attribute INITP_03 : string;
attribute INITP_04 : string;
attribute INITP_05 : string;
attribute INITP_06 : string;
attribute INITP_07 : string;
--
-- Attributes to define ROM contents during implementation synthesis.
--
attribute INIT_00 of ram_1024_x_18  : label is "00F2E0370086E0360080E03F0002E03E0000E03D0000E03C000AC00200014000";
attribute INIT_01 of ram_1024_x_18  : label is "6035C00200024021C00200000F23E0350000E03B0092E03A00ECE0390008E038";
attribute INIT_02 of ram_1024_x_18  : label is "58E7E434E333E232A400A300820164346333623250214000543121804101C080";
attribute INIT_03 of ram_1024_x_18  : label is "017901100007401D503D4006505F40004000541D4008400001790100000C4021";
attribute INIT_04 of ram_1024_x_18  : label is "000701670406501D2201018B013C00040174000601790117000A541D40014000";
attribute INIT_05 of ram_1024_x_18  : label is "4E00401DC002000401850012017F0117000A017F0136000AC0010002017F0110";
attribute INIT_06 of ram_1024_x_18  : label is "017901100004017400024A0001740005EC00DDE04D004C0040000E060E06AE0F";
attribute INIT_07 of ram_1024_x_18  : label is "4000541D4C00401D509B4A06507D4A010174C01410E0501D2201018B013C0004";
attribute INIT_08 of ram_1024_x_18  : label is "C301C0020010C301C3010300C0020008014317D016C0050101740003541D4008";
attribute INIT_09 of ram_1024_x_18  : label is "40504000017901140003401DC0020004C00200205492CD01C0014000CD04C301";
attribute INIT_0A of ram_1024_x_18  : label is "02060124001050C8400060354500EC00DD60060E060E4600017901160008541D";
attribute INIT_0B of ram_1024_x_18  : label is "401D50C0400250C74001603550E7251054E72505E234E233E2320200541D019F";
attribute INIT_0C of ram_1024_x_18  : label is "E1A7E0556319621861176016501D250240E340EA501DD0D010C00174C00E1060";
attribute INIT_0D of ram_1024_x_18  : label is "C102012001040812070006000198020E01100024E31DE21CE11BE01AE387E248";
attribute INIT_0E of ram_1024_x_18  : label is "10C001000104081017D016C0401DE0350000401DE0358001603540E3C1020104";
attribute INIT_0F of ram_1024_x_18  : label is "012040FA8101CD0150FF410640EF810150EF4106EC00CD01C001400050FAD0D0";
attribute INIT_10 of ram_1024_x_18  : label is "017F01100004017F013C0004C10201480143A60087140506401DC1020104C102";
attribute INIT_11 of ram_1024_x_18  : label is "011A0004017F01140002C0010050C5010500C002C701C601C101C00101060000";
attribute INIT_12 of ram_1024_x_18  : label is "C0010050C301C201C101C001A000A100B2C0B3D028026319621861176016017F";
attribute INIT_13 of ram_1024_x_18  : label is "4700B400E600C714C001C001C001C0010000C1020110C0010080C0010002C801";
attribute INIT_14 of ram_1024_x_18  : label is "C001A000811411701060C3010300C0010045C00200080167040041850006B400";
attribute INIT_15 of ram_1024_x_18  : label is "013C0004C301C301C0020010C5010001C0010080C301C301C001C0010055C101";
attribute INIT_16 of ram_1024_x_18  : label is "017F01360006017F01060006556720404001A000C0020020017F01100004017F";
attribute INIT_17 of ram_1024_x_18  : label is "7210A0005579C0018101F21042004175C0014100B0004000A000C401C0010008";
attribute INIT_18 of ram_1024_x_18  : label is "A2FD519043FF430002034187C001C101B00040000100A000557FC0018101C201";
attribute INIT_19 of ram_1024_x_18  : label is "7300A0005598C20181018001F3007310A000558CC0018101A2FE519454307410";
attribute INIT_1A of ram_1024_x_18  : label is "00000000000000000000000000008001A000559FC20181018001B40053407410";
attribute INIT_1B of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_1C of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_1D of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_1E of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_1F of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_20 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_21 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_22 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_23 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_24 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_25 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_26 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_27 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_28 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_29 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_2A of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_2B of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_2C of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_2D of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_2E of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_2F of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_30 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_31 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_32 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_33 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_34 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_35 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_36 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_37 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_38 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_39 of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_3A of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_3B of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_3C of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_3D of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_3E of ram_1024_x_18  : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_3F of ram_1024_x_18  : label is "41A8000000000000000000000000000000000000000000000000000000000000";
attribute INITP_00 of ram_1024_x_18 : label is "37DDD370C30C502838CC308C3370CC34C3DD34C3EA540DD22382222222222220";
attribute INITP_01 of ram_1024_x_18 : label is "36DDD58C0C0E39388C0C0AA0000DFC34F74DDA8F034168C34C388D86A288C0CD";
attribute INITP_02 of ram_1024_x_18 : label is "2D6349A8C30D28C30A888AA29422233265AA22228AA554030C222AA0C308D4E2";
attribute INITP_03 of ram_1024_x_18 : label is "00000000000000000000000000000000000000000003B5642D58B534343692D6";
attribute INITP_04 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INITP_05 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INITP_06 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INITP_07 of ram_1024_x_18 : label is "C000000000000000000000000000000000000000000000000000000000000000";
--
begin
--
  --Instantiate the Xilinx primitive for a block RAM
  ram_1024_x_18: RAMB16_S18
  --synthesis translate_off
  --INIT values repeated to define contents for functional simulation
  generic map ( INIT_00 => X"00F2E0370086E0360080E03F0002E03E0000E03D0000E03C000AC00200014000",
                INIT_01 => X"6035C00200024021C00200000F23E0350000E03B0092E03A00ECE0390008E038",
                INIT_02 => X"58E7E434E333E232A400A300820164346333623250214000543121804101C080",
                INIT_03 => X"017901100007401D503D4006505F40004000541D4008400001790100000C4021",
                INIT_04 => X"000701670406501D2201018B013C00040174000601790117000A541D40014000",
                INIT_05 => X"4E00401DC002000401850012017F0117000A017F0136000AC0010002017F0110",
                INIT_06 => X"017901100004017400024A0001740005EC00DDE04D004C0040000E060E06AE0F",
                INIT_07 => X"4000541D4C00401D509B4A06507D4A010174C01410E0501D2201018B013C0004",
                INIT_08 => X"C301C0020010C301C3010300C0020008014317D016C0050101740003541D4008",
                INIT_09 => X"40504000017901140003401DC0020004C00200205492CD01C0014000CD04C301",
                INIT_0A => X"02060124001050C8400060354500EC00DD60060E060E4600017901160008541D",
                INIT_0B => X"401D50C0400250C74001603550E7251054E72505E234E233E2320200541D019F",
                INIT_0C => X"E1A7E0556319621861176016501D250240E340EA501DD0D010C00174C00E1060",
                INIT_0D => X"C102012001040812070006000198020E01100024E31DE21CE11BE01AE387E248",
                INIT_0E => X"10C001000104081017D016C0401DE0350000401DE0358001603540E3C1020104",
                INIT_0F => X"012040FA8101CD0150FF410640EF810150EF4106EC00CD01C001400050FAD0D0",
                INIT_10 => X"017F01100004017F013C0004C10201480143A60087140506401DC1020104C102",
                INIT_11 => X"011A0004017F01140002C0010050C5010500C002C701C601C101C00101060000",
                INIT_12 => X"C0010050C301C201C101C001A000A100B2C0B3D028026319621861176016017F",
                INIT_13 => X"4700B400E600C714C001C001C001C0010000C1020110C0010080C0010002C801",
                INIT_14 => X"C001A000811411701060C3010300C0010045C00200080167040041850006B400",
                INIT_15 => X"013C0004C301C301C0020010C5010001C0010080C301C301C001C0010055C101",
                INIT_16 => X"017F01360006017F01060006556720404001A000C0020020017F01100004017F",
                INIT_17 => X"7210A0005579C0018101F21042004175C0014100B0004000A000C401C0010008",
                INIT_18 => X"A2FD519043FF430002034187C001C101B00040000100A000557FC0018101C201",
                INIT_19 => X"7300A0005598C20181018001F3007310A000558CC0018101A2FE519454307410",
                INIT_1A => X"00000000000000000000000000008001A000559FC20181018001B40053407410",
                INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
                INIT_3F => X"41A8000000000000000000000000000000000000000000000000000000000000",    
               INITP_00 => X"37DDD370C30C502838CC308C3370CC34C3DD34C3EA540DD22382222222222220",
               INITP_01 => X"36DDD58C0C0E39388C0C0AA0000DFC34F74DDA8F034168C34C388D86A288C0CD",
               INITP_02 => X"2D6349A8C30D28C30A888AA29422233265AA22228AA554030C222AA0C308D4E2",
               INITP_03 => X"00000000000000000000000000000000000000000003B5642D58B534343692D6",
               INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INITP_07 => X"C000000000000000000000000000000000000000000000000000000000000000")
  --synthesis translate_on
  port map(    DI => "0000000000000000",
              DIP => "00",
               EN => '1',
               WE => '0',
              SSR => '0',
              CLK => clk,
             ADDR => address,
               DO => instruction(15 downto 0),
              DOP => instruction(17 downto 16)); 
--
end low_level_definition;
--
------------------------------------------------------------------------------------
--
-- END OF FILE instruction_mem.vhd
--
------------------------------------------------------------------------------------

