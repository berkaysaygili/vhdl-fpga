
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm_src is
    Port ( clk : in  STD_LOGICü;
				p: in std_logic;
				reset : in std_logic;
				r : out std_logic);
end fsm_src;

architecture Behavioral of fsm_src is

type state_type is (a,b,c,d);
signal state : state_type;

begin

	process(clk, reset)
	begin
		if (reset = '1') then
			state <= A;
		
		elsif rising_edge(clk) then
		
			case state is
				when A =>
					if p = '1' then
						state <= b;
					end if;
				
				when b =>
					if p = '1' then
						state <= c;
					end if;
				
				when c => 
					if p = '1' then
						state <= d;
					end if;
				
				when d =>
					if p = '1' then
						state <= b;
					else
						state <= a;
					end if;
				
				when others =>
					state <= a;
			end case;
		end if;
	end process;				
					
end Behavioral;

