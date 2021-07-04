library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seven_segment_src is
    Port (  bcd : in std_logic_vector(3 downto 0);
				clk : in std_logic;
				sel : in std_logic_vector(1 downto 0);
				anodes : out std_logic_vector(3 downto 0);
				decode : out std_logic_vector(6 downto 0));

end seven_segment_src;

architecture Behavioral of seven_segment_src is

signal allsevensegment : std_logic_vector(15 downto 0);
signal refresh_counter : unsigned(19 downto 0); -- 10.5 ms refresh rate
signal led_refreshing_clk : std_logic_vector(1 downto 0);
signal led_bcd : std_logic_vector(3 downto 0);
begin

sevensegment_map : process(led_bcd)
begin
case led_bcd is
	when "0000" =>
		decode <= "1000000"; -- 0
	when "0001" =>
		decode <= "1111001"; -- 1
	when "0010" =>
		decode <= "0100100"; -- 2
	when "0011" =>
		decode <= "0110000"; -- 3
	when "0100" =>
		decode <= "0011001"; -- 4
	when "0101" =>
		decode <= "0010010"; -- 5
	when "0110" =>
		decode <= "0000010"; -- 6
	when "0111" =>
		decode <= "1111000"; -- 7
	when "1000" =>
		decode <= "0000000"; -- 8
	when "1001" =>
		decode <= "0010000"; -- 9
	when "1010" =>
		decode <= "0001000"; -- A
	when "1011" =>
		decode <= "0000011"; -- b
	when "1100" =>
		decode <= "1000110"; -- C
	when "1101" =>
		decode <= "0100001"; -- d
	when "1110" =>
		decode <= "0000110"; -- E
	when "1111" =>
		decode <= "0001110"; -- F
	when others =>
		decode <= "1111111";
end case;
end process;


refresh : process(clk)
begin
	if rising_edge(clk) then
		refresh_counter <= refresh_counter + 1;
	end if;
	led_refreshing_clk <= std_logic_vector(refresh_counter(19 downto 18));
end process;


refreshing : process(led_refreshing_clk)
begin
	case led_refreshing_clk is
		when "00" =>
			anodes <= "1110";
			led_bcd <= allsevensegment(3 downto 0);
		when "01" =>
			anodes <= "1101";
			led_bcd <= allsevensegment(7 downto 4);
		when "10" =>
			anodes <= "1011";
			led_bcd <= allsevensegment(11 downto 8);
		when "11" =>
			anodes <= "0111";
			led_bcd <= allsevensegment(15 downto 12);
		when others =>
			anodes <= "1110";
			led_bcd <= allsevensegment(3 downto 0);
	end case;
end process;


selective : process(sel, bcd)
begin
	case sel is
		when "00" =>
			allsevensegment(3 downto 0) <= bcd;
		when "01" =>
			allsevensegment(7 downto 4) <= bcd;
		when "10" =>
			allsevensegment(11 downto 8) <= bcd;
		when "11" =>
			allsevensegment(15 downto 12) <= bcd;
		when others =>
			allsevensegment(3 downto 0) <= bcd;
		end case;

end process;

end Behavioral;

