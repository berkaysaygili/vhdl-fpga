----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:40:20 04/28/2020 
-- Design Name: 
-- Module Name:    uart_rx_src - Behavioral 
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity uart_rx_src is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           input : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           done : out  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end uart_rx_src;

architecture Behavioral of uart_rx_src is

constant clk_coefficient : integer := 5200; -- explanation was made in uart code
type state_type is (idle_rxd, start_rxd, receive_rxd, stop_rxd);
signal state, state_next: state_type;
signal data, data_next : std_logic_vector(7 downto 0);
signal n, n_next : integer;
signal data_receive, input_next: std_logic;
signal counter, counter_next : integer;
signal start_bit, stop_bit : std_logic;

begin
	process(clk, reset)
	begin
		if reset = '1' then
			state <= idle_rxd;
			data <= (others => '0');
			n <= 0;
			input_next <= '0';
			counter <= 0;
		elsif clk = '1' and clk'event then
			state <= state_next;
			n <= n_next;
			data <= data_next;
			counter <= counter_next;
			input_next <= input;
		end if;
	end process;
	
	data_receive <= input_next and (not input); -- incoming data line is '1' in idle, it will be '0' at the
	-- beginning of data transfer. data_receive parameter will let the hardware know when to start receiving
	
	process(enable, data_receive, n, data, state, counter, reset)
	begin
		state_next <= state;
		n_next <= n;
		data_next <= data;
		counter_next <= counter;
		done <= '0';
		case state is
			when IDLE_RxD =>
				if enable = '1' and data_receive = '1' and reset = '0' then
					state_next <= start_rxd;
				end if;
			when START_RxD =>
				counter_next <= counter + 1;
				if counter = clk_coefficient/2 then -- sampling is done in middle of a bit, not at edges, thats why counter divided by 2
					if input = '0' then
						state_next <= receive_rxd;
					else
						state_next <= idle_rxd;
					end if;
					counter_next <= 0;
				end if;
			when RECEIVE_RxD =>
				counter_next <= counter + 1;
				if counter = clk_coefficient then
					data_next(n) <= input;
					counter_next <= 0;
					if n = 7 then
						n_next <= 0;
						state_next <= stop_rxd;
					else
						n_next <= n + 1;
					end if;
				end if;
			when STOP_RxD =>
				counter_next <= counter + 1;
				if counter = clk_coefficient then
					counter_next <= 0;
					if input = '1' then
						done <= '1';
					end if;
					state_next <= idle_rxd;
				end if;
		end case;
	end process;
	output <= data;
end Behavioral;






















