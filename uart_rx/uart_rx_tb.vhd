--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:    21:40:20 04/28/2020 
-- Design Name:   
-- Module Name:   C:/Users/ACER/Desktop/programming/FPGA- vhdl- nexys2/uart_rx/uart_rx_tb.vhd
-- Project Name:  uart_rx
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: uart_rx_src
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
 
ENTITY uart_rx_tb IS
END uart_rx_tb;
 
ARCHITECTURE behavior OF uart_rx_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT uart_rx_src
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         input : IN  std_logic;
         enable : IN  std_logic;
         done : OUT  std_logic;
         output : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    
   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '1';
   signal input : std_logic := '1';
   signal enable : std_logic := '1';

 	--Outputs
   signal done : std_logic;
   signal output : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: uart_rx_src PORT MAP (
          clk => clk,
          reset => reset,
          input => input,
          enable => enable,
          done => done,
          output => output
        );

   -- Clock process definitions
   clk <= not clk after clk_period/2;
 
   -- Stimulus process
   stim_proc: process
	begin
		wait for 200 us;
		reset<='0';
		wait for 100 us;
		input<='0';
		wait for 100 us;
		input<='1';
		wait for 100 us;
		input<='0';
		wait for 100 us;
		input<='1';
		wait for 100 us;
		input<='1';
		wait for 100 us;
		input<='0';
		wait for 100 us;
		input<='0';
		wait for 100 us;
		input<='1';
		wait for 100 us;
		input<='0';
		wait for 100 us;
		input<='1';
		wait for 200 us;
		assert false
		report "simulation over"
		severity failure;
	end process;
END;