LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY counter4bit_tb IS
END counter4bit_tb;
 
ARCHITECTURE behavior OF counter4bit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT counter4bit_src
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         pause : IN  std_logic;
         count_out : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal pause : std_logic := '0';

 	--Outputs
   signal count_out : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: counter4bit_src PORT MAP (
          clk => clk,
          reset => reset,
          pause => pause,
          count_out => count_out
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

      -- insert stimulus here 

      wait;
   end process;

END;
