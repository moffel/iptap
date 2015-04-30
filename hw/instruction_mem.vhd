
--
-- Definition of a single port ROM for KCPSM3 program defined by instruction_mem.psm
--
-- Generated by KCPSM3 Assembler 01-May-2015 00:25:08. 
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
attribute INIT_02 of ram_1024_x_18  : label is "58EAE434E333E232A400A300820164346333623250214000543121804101C080";
attribute INIT_03 of ram_1024_x_18  : label is "018F01100007401D503D4006505F40004000541D40084000018F0100000C4021";
attribute INIT_04 of ram_1024_x_18  : label is "0007017D0406501D220101A1013C0004018A0006018F0117000A541D40014000";
attribute INIT_05 of ram_1024_x_18  : label is "4E00401DC0020004019B001201950117000A01950136000AC001000201950110";
attribute INIT_06 of ram_1024_x_18  : label is "018F01100004018A00024A00018A0005EC00DDE04D004C0040000E060E06AE0F";
attribute INIT_07 of ram_1024_x_18  : label is "4000541D4C00401D509B4A06507D4A01018AC01410E0501D220101A1013C0004";
attribute INIT_08 of ram_1024_x_18  : label is "C301C0020010C301C3010300C0020008015917D016C00501018A0003541D4008";
attribute INIT_09 of ram_1024_x_18  : label is "40504000018F01140003401DC0020004C00200205492CD01C0014000CD04C301";
attribute INIT_0A of ram_1024_x_18  : label is "02060124001050CB400060354500EC00DD60060E060E4600018F01160008541D";
attribute INIT_0B of ram_1024_x_18  : label is "50CA4001603550EA251054EA2505E234E233E232020054EA01B50208541D01B5";
attribute INIT_0C of ram_1024_x_18  : label is "621861176016501D250240E640ED501DD0D010C0018AC00E1060401D50C34002";
attribute INIT_0D of ram_1024_x_18  : label is "08120700060001AE020E01100024E31DE21CE11BE01AE387E248E1A7E0556319";
attribute INIT_0E of ram_1024_x_18  : label is "081017D016C0401DE0350000401DE0358001603540E6C1020104C10201200107";
attribute INIT_0F of ram_1024_x_18  : label is "CD015102410640F2810150F24106EC00CD01C001400050FDD0D010C001000107";
attribute INIT_10 of ram_1024_x_18  : label is "0195013C0004C10201480159A60087140506401DC1020104C102012040FD8101";
attribute INIT_11 of ram_1024_x_18  : label is "01280002C0010050C5010500C002C701C601C101C00101060000019501240004";
attribute INIT_12 of ram_1024_x_18  : label is "A000A100B260B3702802C301C201C101C00163316230612F602EE600C7140195";
attribute INIT_13 of ram_1024_x_18  : label is "C201C101C001A000A100B2C0B3D02802632D622C612B602AE331E230E12FE02E";
attribute INIT_14 of ram_1024_x_18  : label is "C0010000C1020110C0010080C0010002C801C0010050E32DE22CE12BE02AC301";
attribute INIT_15 of ram_1024_x_18  : label is "0300C0010045C0020008017D0400419B0006B4004700B4004600C001C001C001";
attribute INIT_16 of ram_1024_x_18  : label is "C5010001C0010080C301C301C001C0010055C101C001A000811411701060C301";
attribute INIT_17 of ram_1024_x_18  : label is "557D20404001A000C00200200195011000040195013C0004C301C301C0020010";
attribute INIT_18 of ram_1024_x_18  : label is "4200418BC0014100B0004000A000C401C0010008019501360006019501060006";
attribute INIT_19 of ram_1024_x_18  : label is "C001C101B00040000100A0005595C0018101C2017210A000558FC0018101F210";
attribute INIT_1A of ram_1024_x_18  : label is "F3007310A00055A2C0018101A2FE51AA54307410A2FD51A643FF43000203419D";
attribute INIT_1B of ram_1024_x_18  : label is "00008001A00055B5C20181018001B400534074107300A00055AEC20181018001";
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
attribute INIT_3F of ram_1024_x_18  : label is "41BE000000000000000000000000000000000000000000000000000000000000";
attribute INITP_00 of ram_1024_x_18 : label is "37DDD370C30C502838CC308C3370CC34C3DD34C3EA540DD22382222222222220";
attribute INITP_01 of ram_1024_x_18 : label is "B7756303038E4E230302A800037F0D3DD376A3CF034168C34C388D86A288C0CD";
attribute INITP_02 of ram_1024_x_18 : label is "D28C30A888AA29422233266A8888A2AAA95500AA556A8017088AA830C235388D";
attribute INITP_03 of ram_1024_x_18 : label is "000000000000000000000000000000003B5642D58B534343692D62D6349A8C30";
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
                INIT_02 => X"58EAE434E333E232A400A300820164346333623250214000543121804101C080",
                INIT_03 => X"018F01100007401D503D4006505F40004000541D40084000018F0100000C4021",
                INIT_04 => X"0007017D0406501D220101A1013C0004018A0006018F0117000A541D40014000",
                INIT_05 => X"4E00401DC0020004019B001201950117000A01950136000AC001000201950110",
                INIT_06 => X"018F01100004018A00024A00018A0005EC00DDE04D004C0040000E060E06AE0F",
                INIT_07 => X"4000541D4C00401D509B4A06507D4A01018AC01410E0501D220101A1013C0004",
                INIT_08 => X"C301C0020010C301C3010300C0020008015917D016C00501018A0003541D4008",
                INIT_09 => X"40504000018F01140003401DC0020004C00200205492CD01C0014000CD04C301",
                INIT_0A => X"02060124001050CB400060354500EC00DD60060E060E4600018F01160008541D",
                INIT_0B => X"50CA4001603550EA251054EA2505E234E233E232020054EA01B50208541D01B5",
                INIT_0C => X"621861176016501D250240E640ED501DD0D010C0018AC00E1060401D50C34002",
                INIT_0D => X"08120700060001AE020E01100024E31DE21CE11BE01AE387E248E1A7E0556319",
                INIT_0E => X"081017D016C0401DE0350000401DE0358001603540E6C1020104C10201200107",
                INIT_0F => X"CD015102410640F2810150F24106EC00CD01C001400050FDD0D010C001000107",
                INIT_10 => X"0195013C0004C10201480159A60087140506401DC1020104C102012040FD8101",
                INIT_11 => X"01280002C0010050C5010500C002C701C601C101C00101060000019501240004",
                INIT_12 => X"A000A100B260B3702802C301C201C101C00163316230612F602EE600C7140195",
                INIT_13 => X"C201C101C001A000A100B2C0B3D02802632D622C612B602AE331E230E12FE02E",
                INIT_14 => X"C0010000C1020110C0010080C0010002C801C0010050E32DE22CE12BE02AC301",
                INIT_15 => X"0300C0010045C0020008017D0400419B0006B4004700B4004600C001C001C001",
                INIT_16 => X"C5010001C0010080C301C301C001C0010055C101C001A000811411701060C301",
                INIT_17 => X"557D20404001A000C00200200195011000040195013C0004C301C301C0020010",
                INIT_18 => X"4200418BC0014100B0004000A000C401C0010008019501360006019501060006",
                INIT_19 => X"C001C101B00040000100A0005595C0018101C2017210A000558FC0018101F210",
                INIT_1A => X"F3007310A00055A2C0018101A2FE51AA54307410A2FD51A643FF43000203419D",
                INIT_1B => X"00008001A00055B5C20181018001B400534074107300A00055AEC20181018001",
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
                INIT_3F => X"41BE000000000000000000000000000000000000000000000000000000000000",    
               INITP_00 => X"37DDD370C30C502838CC308C3370CC34C3DD34C3EA540DD22382222222222220",
               INITP_01 => X"B7756303038E4E230302A800037F0D3DD376A3CF034168C34C388D86A288C0CD",
               INITP_02 => X"D28C30A888AA29422233266A8888A2AAA95500AA556A8017088AA830C235388D",
               INITP_03 => X"000000000000000000000000000000003B5642D58B534343692D62D6349A8C30",
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

