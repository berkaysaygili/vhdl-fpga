library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter4bit_src is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           pause : in  STD_LOGIC;
           count_out : out  STD_LOGIC_VECTOR (3 downto 0));
end counter4bit_src;

architecture Behavioral of counter4bit_src is

signal temp_count : std_logic_vector (3 downto 0) := x"0";
signal slow_clk : std_logic;
signal clk_divider : std_logic_vector (23 downto 0) := x"000000";

begin

clk_division : process(clk, clk_divider)
begin
	if (clk = '1' and clk'event) then
		clk_divider <= clk_divider + 1;
	end if;
	
	slow_clk <= clk_divider(23);
end process;

counting : process(reset, pause, slow_clk, temp_count)
begin
	if reset = '1' then
		temp_count <= "0000";
	elsif pause = '1' then
		temp_count <= temp_count;
	else
		if (slow_clk'event and (slow_clk = '1')) then
			temp_count <= temp_count + 1;
		end if;
	end if;
	count_out <= temp_count;
end process;

end Behavioral;