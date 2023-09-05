----------------------------------------------------------------------------------
-- Company: Weber State University 
-- Engineer: Brendon Simonsen and Joseph Morrison
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

entity Counter is
  Port (ld_val_cntr : in unsigned(9 downto 0);
        en_cntr : in std_logic;
        ld_cntr : in std_logic;
        clk_cntr : in std_logic;
        rst_cntr : in std_logic;
        clk_o_cntr : out std_logic);
end Counter;

architecture Behavioral of Counter is

-- SIGNAL DECLARATION
signal cnt : unsigned(9 downto 0);

begin

process (clk_cntr,rst_cntr)
begin

    if rst_cntr = '0' then 
        cnt <= ld_val_cntr;
        clk_o_cntr <= '0';
    elsif rising_edge (clk_cntr) then    -- operate on rising edge of clk
        clk_o_cntr <= '0';
        if ld_cntr = '1' then            -- load the count value
            cnt <= ld_val_cntr;
        elsif en_cntr = '1' then         -- indicates device needs to start counting
            if cnt = 0 then         -- completed counting
                clk_o_cntr <= '1';       -- outputs device has completed counting
            else
                cnt <= cnt -1;      -- count 
            end if;
        end if;     -- end of ld = '1' if statement
    end if;     -- end of reset if

end process;    -- end of process


end Behavioral;
