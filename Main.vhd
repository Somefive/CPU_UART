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
           data_ready : out  STD_LOGIC;
           rdn : out  STD_LOGIC;
           tbre : out  STD_LOGIC;
           tsre : out  STD_LOGIC;
           wrn : out  STD_LOGIC;
			  mode : in STD_LOGIC_VECTOR (1 downto 0));
end Main;

architecture Behavioral of Main is
	signal state: INTEGER range 0 to 10 := 0;
begin
	process(CLK,RST)
	begin
		if(RST='0') then
			state <= 0;
			RamData <= "ZZZZZZZZ";
			RamEN <= '1';
			RamOE <= '1';
			RamWE <= '1';
			data_ready <= '1';
			rdn <= '1';
			tbre <= '1';
			tsre <= '1';
			wrn <= '1';
			L <= "00000000";
		elsif(CLK'EVENT and CLK='1') then
		end if;
	end process;
end Behavioral;

