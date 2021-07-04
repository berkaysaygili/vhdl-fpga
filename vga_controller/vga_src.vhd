
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_src is
    Port ( sw0 : in std_logic;
				sw1 : in std_logic;
				sw2 : in std_logic;
				sw3 : in std_logic;
           clk : in  STD_LOGIC;
			  hsync, vsync : out std_logic;
           R, G : out  STD_LOGIC_VECTOR (2 downto 0);
			   B : out std_logic_vector(1 downto 0));
end vga_src;

architecture Behavioral of vga_src is

-- slow counter to move arrows
signal clk_counter : unsigned(17 downto 0);
signal slowed_clk : std_logic := '0';
signal h_counter : integer range 0 to 800 := 300;
signal v_counter : integer range 0 to 600 := 200;

-- horizontal timing
constant hva : integer := 800; -- visible area
constant hfp : integer := 56; -- front porch
constant hsp : integer := 120; -- sync pulse
constant hbp : integer := 64; -- back porch

-- vertical timing
constant vva : integer := 600; -- visible area
constant vfp : integer := 37; -- front porch
constant vsp : integer := 6; -- sync pulse
constant vbp : integer := 23; -- back porch

signal hpos : integer range 0 to 1040 := 0;
signal vpos : integer range 0 to 666 := 0;

begin

-- slowing clock to make counter
slow_down : process(clk, clk_counter)
begin

	if (rising_edge(clk)) then
		clk_counter <= clk_counter + 1;
	end if;
	slowed_clk <= clk_counter(17);
end process;

-- horizontal switches
h_switch_control : process(slowed_clk)
begin
	if rising_edge(slowed_clk) then
		if (sw0 = '1' and sw1 = '0') then
			h_counter <= h_counter + 1;		
		elsif (sw0 = '0' and sw1 = '1') then
			h_counter <= h_counter - 1;
		else
			h_counter <= h_counter;
		end if;
	end if;
end process;

-- vertical switches
v_switch_control : process(slowed_clk)
begin
	if rising_edge(slowed_clk) then
		if (sw2 = '1' and sw3 = '0') then
			v_counter <= v_counter + 1;		
		elsif (sw2 = '0' and sw3 = '1') then
			v_counter <= v_counter - 1;
		else
			v_counter <= v_counter;
		end if;
	end if;
end process;

-- horizontal, vertical position
position : process(clk)
begin
	-- new row when its completed
	if rising_edge(clk) then
		if hpos < (hva+hfp+hsp+hbp) then
			hpos <= hpos + 1;
		else
			hpos <= 0;
			if vpos < (vva+vfp+vsp+vbp) then
				vpos <= vpos + 1;
			else
				vpos <= 0;
			end if;
		end if;
		
		-- sync output is '0' during hsync phase
		if hpos > (hva + hfp) and hpos < (hva+hfp+hsp) then
			hsync <= '0';
		else
			hsync <= '1';
		end if;
		
		-- sync output is '0' during vsync phase
		if vpos > (vva + vfp) and vpos < (vva+vfp+vsp) then
			vsync <= '0';
		else
			vsync <= '1';
		end if;
		
		if (hpos>hva) or (vpos>vva) then
			r <= (others=>'0');
			g <= (others=>'0');
			b <= (others=>'0');
		else
			-- red background
			r <= (others=>'1');
			g <= (others=>'0');
			b <= (others=>'0');
			
			-- white cross-hair
			if(hpos > h_counter and hpos < (h_counter+10)) or (vpos > v_counter and vpos < (v_counter+10)) then
				r <= (others=>'1');
				g <= (others=>'1');
				b <= (others=>'1');
			end if;
		end if;
	end if;
end process; 

end Behavioral;

