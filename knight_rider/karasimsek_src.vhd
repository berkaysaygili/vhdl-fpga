
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity karasimsek_src is
    Port ( a : in  STD_LOGIC;
           output : out  std_logic_vector(7 downto 0);
           b : in  STD_LOGIC;
			  clk : in STD_LOGIC);
end karasimsek_src;

architecture Behavioral of karasimsek_src is

signal slow_clk : std_logic := '0';
signal clock_count : unsigned(23 downto 0) := x"000000";
signal temp_output : unsigned(7 downto 0) := x"02";

begin

	slowing_clock : process(clk, clock_count)
	begin
		
		if (clk = '1' and clk'event) then
			clock_count <= clock_count + 1;
		end if;
		
		slow_clk <= std_logic(clock_count(23));
		
	end process;

	action : process(slow_clk, a, b, temp_output)
	begin
	
		if (slow_clk'event and slow_clk = '1') then
			if (a = '1' and b = '0') then
				temp_output <= temp_output rol 1;
			elsif (b = '1' and a = '0') then
				temp_output <= temp_output ror 1;
			elsif (a = '1' and b = '1') then
				temp_output <= temp_output;
			else
				temp_output <= "00000011";
			end if;
		end if;
		output <= std_logic_vector(temp_output);
		
	end process;
end Behavioral;