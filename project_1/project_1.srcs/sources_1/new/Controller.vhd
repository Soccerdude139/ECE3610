----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/12/2023 12:42:38 PM
-- Design Name: 
-- Module Name: Controller - Behavioral
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

entity Controller is
    Generic (full_count : unsigned(9 downto 0) := "");
    Port (clk_ctrl  : in std_logic; 
          rst_ctrl  : in std_logic;
          sda_ctrl  : in std_logic;     -- line that data will be received from
          clk_o_ctrl     : in std_logic;        -- when '1' indicates the counter is done counting. connected to clk_o
          ld_val    : out unsigned (9 downto 0);
          data_out  : out std_logic_vector;    -- data to be sent to counter
          ld_ctrl   : out std_logic;    -- '1' indicates we want to load a new value to count to 
          en_ctrl   : out std_logic;    -- '1' indicates to the counter to begin counting
          pdata_rdy : out std_logic;    -- '1' indicates send the data from the shift register 
          rdy_ctrl  : out std_logic     -- when '1' indicats receiver is ready to read more data 
          );
end Controller;

architecture Behavioral of Controller is

type STATE_TYPE is (idle,
                    read, 
                    start_bit,
                    stop);
signal state : STATE_TYPE := idle; 

-- SIGNAL DECLARATION
signal counter : unsigned (3 downto 0);


-- CONSTANT DECLARATION
constant FC : unsigned (9 downto 0) := full_count;      -- time for the counter
constant HC : unsigned (9 downto 0) := full_count/2;    -- half the time for the counter

 
begin

process(clk_ctrl, rst_ctrl)
begin
    if rst_ctrl = '1' then      -- if device resets
        en_ctrl <= '0';
        ld_ctrl <= '0';
        rdy_ctrl <= '0'; 
        pdata_rdy <= '0';
    
    elsif rising_edge (clk_ctrl) then
        case state is
----------------------------------------------
-- While in this state we are waiting for a start signal on the SDA line
            when idle =>
                rdy_ctrl <= '1';        -- we are ready to receive data
                ld_val <= HC;
                ld_ctrl <= '1';
                pdata_rdy <= '0';
                counter <= "0000";
                if sda_ctrl = '0' then      -- we receive a start bit
                    state <= start_bit;
                    en_ctrl <= '1';
                end if;
-------------------------------------------------
-- Reading the start bit
            when start_bit =>
                ld_ctrl <= '0'; 
                ld_val <= FC;
                if clk_o_ctrl = '1' then    -- counter finished counting and read the start bit
                    state <= read;
                    en_ctrl <= '1';             -- start counter
                end if;
--------------------------------------------------
-- state when reading 8 bits
            when read =>
                ld_ctrl <= '0';
                ld_val <= FC;
                if clk_o_ctrl = '1' then    -- counter finished counting and read a data bit
                        ld_ctrl <= '1';
                        counter <= counter + "0001";    -- subtract counter by 1
                        en_ctrl <= '1';
                        if counter = "1111" then        -- if we have read 8 bits
                            ld_ctrl <= '1';             -- load new count value
                            ld_val <= FC;
                            en_ctrl <= '0';             -- stop using the counter to shift the register
                            state <= stop;
                        end if;
                end if;
            when stop =>
                ld_ctrl <= '0';
                pdata_rdy <= '1';       -- send the data in the registers
                state <= idle;
        end case;
    end if;


end process;

end Behavioral;
