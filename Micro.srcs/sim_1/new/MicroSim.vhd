----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/25/2017 02:55:32 PM
-- Design Name: 
-- Module Name: counter_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity MicroSim is

end MicroSim;

architecture Behavioral of MicroSim is

component MICRO_TOP is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC);
end component;

signal clock : STD_LOGIC := '0';
constant clk_period : time := 10 ns;

begin

uut: MICRO_TOP PORT MAP (
    clk => clock,
    reset => '0'
);

clock <= not clock after clk_period;

process
begin

end process;    
end Behavioral;
