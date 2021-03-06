--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:55:15 04/08/2019
-- Design Name:   
-- Module Name:   C:/Users/ACER/FPGA/seven_segment/seven_tb.vhd
-- Project Name:  seven_segment
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: seven_segment_src
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
 
ENTITY seven_tb IS
END seven_tb;
 
ARCHITECTURE behavior OF seven_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT seven_segment_src
    PORT(
         bcd : IN  std_logic_vector(3 downto 0);
         clk : IN  std_logic;
         sel : IN  std_logic_vector(1 downto 0);
         anodes : OUT  std_logic_vector(3 downto 0);
         decode : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal bcd : std_logic_vector(3 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal sel : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal anodes : std_logic_vector(3 downto 0);
   signal decode : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: seven_segment_src PORT MAP (
          bcd => bcd,
          clk => clk,
          sel => sel,
          anodes => anodes,
          decode => decode
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

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
