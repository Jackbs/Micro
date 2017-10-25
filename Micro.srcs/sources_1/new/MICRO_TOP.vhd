
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MICRO_TOP is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC);
end MICRO_TOP;

architecture Behavioral of MICRO_TOP is

signal prog_addr_in : std_logic_vector(7 downto 0) := (others => '0');
signal prog_dout_in : std_logic_vector(15 downto 0) := (others => '0');

signal RamIn : std_logic_vector(7 downto 0) := (others => '0');
signal RamOut : std_logic_vector(7 downto 0) := (others => '0');
signal RamAddress : std_logic_vector(7 downto 0) := (others => '0');
signal reg_we : std_logic := '0';


component CONTROL is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           wea : out STD_LOGIC_VECTOR(0 DOWNTO 0);
           dina  : out STD_LOGIC_VECTOR(7 DOWNTO 0);
           douta : in STD_LOGIC_VECTOR(7 DOWNTO 0);
           prog_addr : out STD_LOGIC_VECTOR (7 downto 0);
           prog_dout : in STD_LOGIC_VECTOR (15 downto 0));
end component;

component blk_mem_gen_0 is
    Port ( clka : IN STD_LOGIC;
           ena : IN STD_LOGIC;
           addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
           douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
end component;

component REGISTERS is
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
end component;

begin

MainCONTROL: CONTROL PORT MAP(  
    clk => clk,
    reset => reset,
    dina => RamIn,
    douta => RamOut,
    wea(0) => reg_we,
    prog_addr => prog_addr_in,
    prog_dout => prog_dout_in
);

ProgRam: blk_mem_gen_0 PORT MAP(
    clka => clk,
    ena => '1',
    addra => prog_addr_in,
    douta => prog_dout_in
);

MainReg: REGISTERS PORT MAP(
    clk => clk,
    reset => reset,
    reg_addr => RamAddress,
    reg_din => RamIn,
    reg_dout => RamOut,
    reg_we => reg_we,
    switches => "01100110"
);

RamAddress <= prog_dout_in(7 downto 0);

end Behavioral;
