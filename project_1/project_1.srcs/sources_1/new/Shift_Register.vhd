----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/05/2023 03:02:25 PM
-- Design Name: 
-- Module Name: Shift_Register - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Shift_Register is
  Port (clk_reg : in std_logic;
        sda_reg : in std_logic;
        pdata_reg : out std_logic_vector(7 downto 0) );
end Shift_Register;

architecture Behavioral of Shift_Register is
-- Module definitions
component DFF is
  Port (s_dff : in std_logic; 
        Q : out std_logic;
        en_dff : in std_logic;
        clk_dff : in std_logic);
end component;

-- signal declaraction
signal iS0 : std_logic;
signal iS1 : std_logic;
signal iS2 : std_logic;
signal iS3 : std_logic;
signal iS4 : std_logic;
signal iS5 : std_logic;
signal iS6 : std_logic;
signal iS7 : std_logic;
signal ena : std_logic;
signal cnt : unsigned := x"08";     -- counts number of bits that have been loaded

begin
-- declare components
D1: DFF port map(s_dff => sda_reg,
                 Q => iS0,
                 en_dff => ena,
                 clk_dff => clk_reg
                );
D2: DFF port map(s_dff => iS0,
                 Q => iS1,
                 en_dff => ena,
                 clk_dff => clk_reg
                );
D3: DFF port map(s_dff => iS1,
                 Q => iS2,
                 en_dff => ena,
                 clk_dff => clk_reg
                );
D4: DFF port map(s_dff => iS2,
                 Q => iS3,
                 en_dff => ena,
                 clk_dff => clk_reg
                );
D5: DFF port map(s_dff => iS3,
                 Q => iS4,
                 en_dff => ena,
                 clk_dff => clk_reg
                );
D6: DFF port map(s_dff => iS4,
                 Q => iS5,
                 en_dff => ena,
                 clk_dff => clk_reg
                );
D7: DFF port map(s_dff => iS5,
                 Q => iS6,
                 en_dff => ena,
                 clk_dff => clk_reg
                );
D8: DFF port map(s_dff => iS6,
                 Q => iS7,
                 en_dff => ena,
                 clk_dff => clk_reg
                );
                
process(clk_reg)
begin
    if rising_edge(clk_reg) then
        if 
    end if;     -- end iff for rising edge


end process;

end Behavioral;
