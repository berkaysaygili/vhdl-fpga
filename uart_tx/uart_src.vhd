----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:43:48 04/27/2020 
-- Design Name: 
-- Module Name:    uart_src - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity uart_src is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           --input : in  STD_LOGIC_VECTOR (7 downto 0);
           --start : in  STD_LOGIC;
           --done : out  STD_LOGIC;
           output : out  STD_LOGIC;
			  
			  switch1 : in std_logic;
			  led1 : out std_logic);
			  
end uart_src;

architecture Behavioral of uart_src is
	-- constant clk_coefficient : integer := 5200; -- this value is calculated with baudrate and clock
	-- formula: clk_coefficient = 1/Baudrate * clk_frequency
	-- 5200 = 1/9600 * 50000000 (Baudrate = 9600, 50 MHz clock)
	-- we need this coefficient, because we need a slower clock to achieve 9600 bits per second
	
	 -- for more generic code, bottom can be uncommented
	 constant baudrate : integer := 9600;
	 constant clock_freq : integer := 50000000;
	 constant clk_coefficient : integer := clock_freq / baudrate;
	
	type state_type is (idle, start_txd, send_txd, stop_txd);
	signal state, state_next : state_type;
	signal N, N_next : integer; -- N = data bits (5-6-7-8 bits send in a packet in UART, usually 8 bits are sent)
	signal count, count_next : integer; -- counter for slower clock
	signal data, data_next : std_logic;
	
	signal input : std_logic_vector(7 downto 0);
	signal start : STD_LOGIC := '0';
	signal done : std_logic := '0';
	signal count_done : integer := 0;
	signal word : std_logic_vector(47 downto 0) := x"6265726b6179"; -- ASCII code of berkay 

begin

	start <= switch1;
	led1 <= switch1;
	
	process(clk, done, count_done)
	begin
		if done = '1' and clk = '1' and clk'event then
			input <= word(47-(8*count_done) downto 40-(8*count_done));
			count_done <= count_done + 1;
		end if;
		if count_done = 6 then
			count_done <= 0;
		end if;
	end process;
	
	process(clk, reset)
	begin
		if reset = '1' then
			state <= idle;
			count <= 0;
			data <= '1';
			N <= 0;
		elsif clk = '1' and clk'event then
			state <= state_next;
			count <= count_next;
			data <= data_next;
			N <= N_next;
		end if;
	end process;
	
	process(state, count, data, N, start, reset, count_done, word)
	begin
		data_next <= '1';
		count_next <= count;
		state_next <= state;
		N_next <= N;
		done <= '0';
		case state is
			when IDLE =>
				if start = '1' and reset = '0' then
					state_next <= start_txd;
				end if;
			when START_TxD =>
				count_next <= count + 1;
				data_next <= '0';
				if count = clk_coefficient then
					count_next <= 0;
					state_next <= send_txd;
				end if;
			when SEND_TxD =>
				count_next <= count + 1;
				data_next <= input(N);
				if count = clk_coefficient then
					if N = 7 then
						state_next <= stop_txd;
						N_next <= 0;
					else
						N_next <= N + 1;
					end if;
					count_next <= 0;
				end if;
			when STOP_TxD =>
				count_next <= count + 1;
				if count = clk_coefficient then
					count_next <= 0;
					done <= '1';
					state_next <= idle;
					
--					input <= word(47-(8*count_done) downto 40-(8*count_done));
--					count_done <= count_done + 1;
--					if count_done = 3 then
--						count_done <= 0;
--					end if;
					
					
				end if;
		end case;
	end process;
	output <= data;
end Behavioral;

