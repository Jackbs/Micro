library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PROG_RAM is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           prog_addr : in STD_LOGIC_VECTOR (7 downto 0);
           prog_dout : out STD_LOGIC_VECTOR (15 downto 0));
end PROG_RAM;

architecture Behavioral of PROG_RAM is

begin


end Behavioral;
