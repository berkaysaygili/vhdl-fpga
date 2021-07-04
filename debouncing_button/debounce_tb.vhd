--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:37:29 04/02/2019
-- Design Name:   
-- Module Name:   C:/Users/ACER/FPGA/debounce_button/debounce_tb.vhd
-- Project Name:  debounce_button
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: debounce_src
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY debounce_tbb IS
END debounce_tbb;
 
ARCHITECTURE behavior OF debounce_tbb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT debounce_src
    PORT(
         clk : IN  std_logic;
         button : IN  std_logic;
         output : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal button : std_logic := '0';

 	--Outputs
   signal output : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: debounce_src PORT MAP (
          clk => clk,
          button => button,
          output => output
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      button <= '1';
		wait for 40 ns;
		button <= '0';
		wait for 200 ns;
		button <= '1';
		wait for 180 ns;
		button <= '0';
		

      -- insert stimulus here 

      wait;
   end process;

END;
