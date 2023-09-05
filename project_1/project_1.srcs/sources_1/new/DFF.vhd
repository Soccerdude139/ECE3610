----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/05/2023 02:20:52 PM
-- Design Name: 
-- Module Name: Counter - Behavioral
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

entity DFF is
  Port (s_dff : in std_logic; 
        Q : out std_logic;
        en_dff : in std_logic;
        clk_dff : in std_logic);
end DFF;

architecture Behavioral of DFF is
-- SIGNAL DECLARATION
signal D : std_logic;
signal q_s : std_logic;

begin
D <= s_dff when en_dff = '1' else q_s;
process(clk_dff)
begin 
    if (rising_edge(clk_dff)) then
        q_s <= D;
    end if;

end process;
Q <= q_s;

end Behavioral;
