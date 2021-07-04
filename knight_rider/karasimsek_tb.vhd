LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY karasimsek_tb IS
END karasimsek_tb;
 
ARCHITECTURE behavior OF karasimsek_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT karasimsek_src
    PORT(
         a : IN  std_logic;
         output : OUT  std_logic_vector(7 downto 0);
         b : IN  std_logic;
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic := '0';
   signal b : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal output : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: karasimsek_src PORT MAP (
          a => a,
          output => output,
          b => b,
          clk => clk
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

      a <= '1';
		b <= '0';

      wait;
   end process;

END;
