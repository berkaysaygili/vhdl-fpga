-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
		 COMPONENT uart_src
		 Port ( clk : in  STD_LOGIC;
				reset : in  STD_LOGIC;
				--input : in  STD_LOGIC_VECTOR (7 downto 0);
				--start : in  STD_LOGIC;
				--done : out  STD_LOGIC;
				switch1 : in std_logic;
				led1: out std_logic;
				output : out  STD_LOGIC);
		 END COMPONENT;

-- Inputs
signal clk : std_logic := '0';
signal reset : std_logic := '0';
signal input : std_logic_vector(7 downto 0) := (others => '0');
signal start : std_logic := '0';
signal switch1: std_logic := '1';
-- Outputs
signal done : std_logic := '0';
signal output : std_logic;
signal led1 : std_logic;

-- Clock period
constant clk_period : time := 20 ns;

BEGIN

-- Component Instantiation
		 uut: uart_src PORT MAP(
										 clk => clk,
										 reset => reset,
										 switch1 => switch1,
										 led1 => led1,
										 --input => input,
										 --start => start,
										 --done => done,
										 output => output
		 );

-- Clock definition
clk <= not clk after clk_period/2;

--  Test Bench Statements
tb : PROCESS
BEGIN
	reset <= '1';
	wait for 100 us; -- wait until global set/reset completes
	
	reset <= '0';
	switch1 <= '1';
	wait for 100 us;

	wait for 1 ms;
	
	assert false
	report "simulation over"
	severity failure;
end process;
END;
