----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:37:30 03/30/2019 
-- Design Name: 
-- Module Name:    buttons_leds_src - Behavioral 
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

entity buttons_leds_src is
    Port ( button1 : in  STD_LOGIC;
           button2 : in  STD_LOGIC;
           button3 : in  STD_LOGIC;
           button4 : in  STD_LOGIC;
           led1 : out  STD_LOGIC;
           led2 : out  STD_LOGIC;
           led3 : out  STD_LOGIC;
           led4 : out  STD_LOGIC);
end buttons_leds_src;

architecture Behavioral of buttons_leds_src is

begin

	work:process(button1, button2, button3, button4) is
	begin

		if (button1 = '1') then
			led1 <= '1';
		else
			led1 <= '0';
		end if;
		
		if (button2 = '1') then
			led2 <= '1';
		else
			led2 <= '0';
		end if;
		
		if (button3 = '1') then
			led3 <= '1';
		else
			led3 <= '0';
		end if;
		
		if (button4 = '1') then
			led4 <= '1';
		else
			led4 <= '0';
		end if;

	end process;
end Behavioral;

