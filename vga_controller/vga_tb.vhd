
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY vga_tb IS
END vga_tb;
 
ARCHITECTURE behavior OF vga_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT vga_src
    PORT(
         clk : IN  std_logic;
         hsync : OUT  std_logic;
         vsync : OUT  std_logic;
         R : OUT  std_logic_vector(1 downto 0);
         G : OUT  std_logic_vector(1 downto 0);
         B : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';

 	--Outputs
   signal hsync : std_logic;
   signal vsync : std_logic;
   signal R : std_logic_vector(1 downto 0);
   signal G : std_logic_vector(1 downto 0);
   signal B : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: vga_src PORT MAP (
          clk => clk,
          hsync => hsync,
          vsync => vsync,
          R => R,
          G => G,
          B => B
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
