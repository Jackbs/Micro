----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/24/2017 05:35:09 PM
-- Design Name: 
-- Module Name: REGISTERS - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REGISTERS is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           reg_addr : in STD_LOGIC_VECTOR (7 downto 0);
           reg_din : in STD_LOGIC_VECTOR (7 downto 0);
           reg_we : in STD_LOGIC;
           reg_dout : out STD_LOGIC_VECTOR (7 downto 0);
           switches : in STD_LOGIC_VECTOR (7 downto 0);
           leds : out STD_LOGIC_VECTOR (7 downto 0);
           ssd_a : out STD_LOGIC_VECTOR (7 downto 0);
           ssd_c : out STD_LOGIC_VECTOR (7 downto 0));
end REGISTERS;

architecture Behavioral of REGISTERS is

signal reg_we_in : STD_LOGIC := '0';
signal reg_dout_ram : std_logic_vector(7 downto 0) := (others => '0');
signal reg_dout_in : std_logic_vector(7 downto 0) := (others => '0');

signal Led_in : std_logic_vector(7 downto 0) := (others => '0');
signal Switches_in : std_logic_vector(7 downto 0) := (others => '0');
signal SDD_Low_Byte_in : std_logic_vector(7 downto 0) := (others => '0');
signal SSD_High_Byte_in : std_logic_vector(7 downto 0) := (others => '0');

component DATA_RAM IS
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
end component;

begin

DataRam: DATA_RAM  PORT MAP(
    clka => clk,
    ena => '1',
    wea(0) => reg_we_in,
    addra => reg_addr,
    dina => reg_din,
    douta => reg_dout_ram
);

process (reg_addr,reg_dout_ram) --drive output from either the SFR or the data_ram depending on the address
    begin    
       if reg_addr = "00000000" then --LEDS      
            reg_dout <= Led_in;
       elsif reg_addr = "00000001" then --Switches
            reg_dout <= Switches_in;
       elsif reg_addr = "00000010" then --SSD LOW
            reg_dout <= SDD_Low_Byte_in;
       elsif reg_addr = "00000100" then --SSD HIGH
            reg_dout <= SSD_High_Byte_in;
       else
            reg_dout <= reg_dout_ram;
       end if;      
end process;

process (reg_we)
begin
    reg_we_in <= '0';
    if rising_edge(reg_we) then   
       if reg_addr = "00000000" then --LEDS      
            Led_in <= reg_din;
       elsif reg_addr = "00000010" then --SSD LOW
            SDD_Low_Byte_in <= reg_din;
       elsif reg_addr = "00000100" then --SSD HIGH
            SSD_High_Byte_in <= reg_din;
       else
            reg_we_in <= reg_we;
       end if;
    end if;   
end process;

--reg_dout <= reg_dout_in;
Switches_in <= switches;

end Behavioral;
