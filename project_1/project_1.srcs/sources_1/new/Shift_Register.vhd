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
        en_reg  : in std_logic;     -- '1' indicates the register can shift
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
signal pdata_s : std_logic_vector (7 downto 0);
signal ena : std_logic;
signal cnt : unsigned := x"08";     -- counts number of bits that have been loaded

begin
ena <= en_reg;
pdata_reg <= pdata_s;
-- declare components
D1: DFF port map(s_dff => sda_reg,
                 Q => pdata_s(7),
                 en_dff => ena,
                 clk_dff => clk_reg
                );
D2: DFF port map(s_dff => pdata_s(7),
                 Q => pdata_s(6),
                 en_dff => ena,
                 clk_dff => clk_reg
                );
D3: DFF port map(s_dff => pdata_s(6),
                 Q => pdata_s(5),
                 en_dff => ena,
                 clk_dff => clk_reg
                );
D4: DFF port map(s_dff => pdata_s(5),
                 Q => pdata_s(4),
                 en_dff => ena,
                 clk_dff => clk_reg
                );
D5: DFF port map(s_dff => pdata_s(4),
                 Q => pdata_s(3),
                 en_dff => ena,
                 clk_dff => clk_reg
                );
D6: DFF port map(s_dff => pdata_s(3),
                 Q => pdata_s(2),
                 en_dff => ena,
                 clk_dff => clk_reg
                );
D7: DFF port map(s_dff => pdata_s(2),
                 Q => pdata_s(1),
                 en_dff => ena,
                 clk_dff => clk_reg
                );
D8: DFF port map(s_dff => pdata_s(1),
                 Q => pdata_s(0),
                 en_dff => ena,
                 clk_dff => clk_reg
                );



end Behavioral;
