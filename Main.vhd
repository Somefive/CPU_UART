----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:43:01 10/30/2016 
-- Design Name: 
-- Module Name:    Main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_SIGNED.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Main is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           SW : in  STD_LOGIC_VECTOR (7 downto 0);
           L : out  STD_LOGIC_VECTOR (7 downto 0);
           RamData : inout  STD_LOGIC_VECTOR (7 downto 0);
           RamOE : out  STD_LOGIC;
           RamWE : out  STD_LOGIC;
           RamEN : out  STD_LOGIC;
           data_ready : in  STD_LOGIC;
           rdn : out  STD_LOGIC;
           tbre : in  STD_LOGIC;
           tsre : in  STD_LOGIC;
           wrn : out  STD_LOGIC;
			  mode : in STD_LOGIC_VECTOR (1 downto 0));
end Main;

architecture Behavioral of Main is
	shared variable state: INTEGER range 0 to 63 := 0;
	shared variable count: INTEGER range 0 to 10000000 := 0;
	shared variable temp: STD_LOGIC_VECTOR (7 downto 0):= "00000000";
begin

	process(CLK,RST)
	begin
		if(RST='0') then
			state := 0;
			count := 0;
			RamData <= "ZZZZZZZZ";
			rdn <= '1';
			wrn <= '1';
			L <= "00000000";
			RamEN <= '1'; 
			RamOE <= '1';
			RamWE <= '1';
			temp := "00000000";
		elsif(CLK'EVENT and CLK='1') then
			if(count=1000000) then 
				case mode is
					when "00" => --Read
						case state is
							when 0 =>
								state := 1;
							when 1 =>
								rdn <= '1';
								RamData <= "ZZZZZZZZ";
								state := 2;
							when 2 =>
								if(data_ready='1')then
									rdn <= '0';
									state := 3;
								elsif(data_ready='0')then
									state := 1;
								end if;
							when 3 =>
								L <= RamData;
								state := 1;
							when others =>
								state := 0;
						end case;
					when "11" => --Write
						case state is
							when 10 =>
								wrn <= '1';
								state := 11;
							when 11 =>
								wrn <= '0';
								RamData <= SW;
								state := 12;
							when 12 =>
								wrn <= '1';
								state := 13;
							when 13 =>
								if(tbre='1')then
									state := 14;
								end if;
							when 14 =>
								if(tsre='1')then
									state := 10;
								end if;
							when others =>
								state := 10;
						end case;
					when others => --Response
						case state is
							when 20 =>
								wrn <= '1';
								rdn <= '1';
								RamData <= "ZZZZZZZZ";
								state := 21;
							when 21 =>
								if(data_ready='1')then
									rdn <= '0';
									state := 22;
								elsif(data_ready='0')then
									state := 20;
								end if;
							when 22 =>
								L <= RamData;
								temp := RamData;
								rdn <= '1';
								wrn <= '1';
								state := 23;
							when 23 =>
								wrn <= '0';
								RamData <= temp + 1;
								state := 24;
							when 24 =>
								wrn <= '1';
								state := 25;
							when 25 =>
								if(tbre='1')then
									state := 26;
								end if;
							when 26 =>
								if(tsre='1')then 
									state := 20;
								end if;
							when others =>
								state := 20;
						end case;
				end case;
			elsif(count<1000000)then
				count := count + 1;
			end if;
		end if;
	end process;
end Behavioral;

