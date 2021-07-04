
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

entity debounce_src is
    Port ( clk : in  STD_LOGIC;
           button : in  STD_LOGIC;
           output : out  STD_LOGIC);
end debounce_src;

architecture Behavioral of debounce_src is

signal q1 : std_logic;
signal q2 : std_logic;
signal counter_set : std_logic;
signal counter_out : unsigned(2 downto 0) := "000";


begin
	
	counter_set <= q1 xnor q2;
	
	process(clk)
	begin
		if rising_edge(clk) then
			q1 <= button;
			q2 <= q1;
			if counter_set = '1' then
				counter_out <= counter_out + 1;
			else
				counter_out <= (others=>'0');
			end if;
			
			if counter_out = "111" then
					output <= q2;
			end if;
		end if;
	end process;
	
end Behavioral;