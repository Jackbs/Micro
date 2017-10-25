----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/20/2017 03:33:45 PM
-- Design Name: 
-- Module Name: CONTROL - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CONTROL is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           wea : out STD_LOGIC_VECTOR(0 DOWNTO 0);
           dina  : out STD_LOGIC_VECTOR(7 DOWNTO 0);
           douta : in STD_LOGIC_VECTOR(7 DOWNTO 0);
           prog_addr : out STD_LOGIC_VECTOR (7 downto 0);
           prog_dout : in STD_LOGIC_VECTOR (15 downto 0));
end CONTROL;

architecture Behavioral of CONTROL is

signal state : std_logic_vector(1 downto 0) := (others => '0'); --state 00 is reset
--signal instruction : std_logic_vector(3 downto 0) := (others => '0'); --state 00 is reset
signal progcounter : std_logic_vector(7 downto 0) := (others => '0'); --state 00 is reset

signal ACC : std_logic_vector(7 downto 0) := (others => '0'); --state 00 is reset
signal CAR : std_logic_vector(7 downto 0) := (others => '0'); --state 00 is reset

signal Ram_input_in : std_logic_vector(7 downto 0) := (others => '0'); --ram_in

signal acc_update : std_logic_vector(1 downto 0) := (others => '0'); --bit1 gets set in the S_DECODE state if the 4 most significant bits of prog_dout corresponds to an LDI instruction
signal we_in : std_logic := '0'; 

begin

process (clk,prog_dout)
begin
    if rising_edge(clk) then   
        if we_in = '1' then
            we_in <= '0';
        end if;
        if state = "00" then
            state <= "01";
        elsif state = "01" then --Setting state from decode to Exactute
            state <= "10";
            if acc_update = "01" then --from LDI register, load IMM into CAR and ACC
                CAR(3 downto 0) <= prog_dout(11 downto 8); 
                ACC <= prog_dout(7 downto 0); 
                acc_update <= "00";
            elsif acc_update = "10" then --Is an LDR instruction, Load ACC from register
                ACC <= douta;
                acc_update <= "00";
            end if;     
        elsif state = "10" then --Setting state from Exactute to Store
            state <= "11"; 
            progcounter <= progcounter + 1;            
        elsif state = "11" then --Setting state from store to decode
            state <= "01";
            if prog_dout(15 downto 12) = "0100" then --Is an LDI instruction, set acc_update flag high
                acc_update <= "01";
            elsif prog_dout(15 downto 12) = "0101" then --Is an LDR instruction, Load ACC from register
                acc_update <= "10";
            elsif prog_dout(15 downto 12) = "0110" then --Is an STA instruction, store acc to register
                Ram_input_in <= ACC;
                we_in <= '1';
            elsif prog_dout(15 downto 12) = "0111" then --Is an STC instruction, store car to register
                Ram_input_in <= CAR;
                we_in <= '1';    
            end if;
        end if;
    end if;
    
end process;
wea(0) <= we_in;
prog_addr <= progcounter;
dina <= Ram_input_in;
end Behavioral;
