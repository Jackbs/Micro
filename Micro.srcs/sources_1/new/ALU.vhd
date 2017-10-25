

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port ( alu_a : in STD_LOGIC_VECTOR (7 downto 0);
           alu_b : in STD_LOGIC_VECTOR (7 downto 0);
           alu_op : in STD_LOGIC_VECTOR (2 downto 0);
           alu_r : out STD_LOGIC_VECTOR (15 downto 0));
end ALU;

architecture Behavioral of ALU is
signal result : STD_LOGIC_VECTOR (15 downto 0);
begin

process(alu_a,alu_b,alu_op)
begin
    if alu_op = "000" then --Add
        result <= alu_a + alu_b;
    elsif alu_op = "001" then --Subtract
        result <= alu_a - alu_b;    
    elsif alu_op = "010" then --Multiply
        result <= alu_a * alu_b;
    elsif
end process;

alu_r <= result;

end Behavioral;
