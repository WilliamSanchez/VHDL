library ieee;
use ieee.std_logic_1164.all;

entity teste is
    Port ( key4 : in  STD_LOGIC;
           key3 : in  STD_LOGIC;
           led0 : out  STD_LOGIC;
           led1 : out  STD_LOGIC);
end teste;

architecture Behavioral of teste is

begin

    led0 <= not key4;
	 led1 <= key3;


end Behavioral;

--abc: process(clk, rst,  key)
--begin
--   --clk_out <= clk;
--   if rst = '0' then led <= "0000";
--   else led <= "1111";
--   end if;
--end process abc;
--clk_out <= clk;
