library ieee;
use ieee.std_logic_1164.all;

entity teste is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        d : in  std_logic_vector(3 downto 0);
        q : buffer std_logic_vector(3 downto 0)
    );
end entity;

architecture behavioral of teste is
begin
     abc: process(clk, rst,  d)
     begin
        if rst = '0' then q <= "0000";
        elsif rising_edge(clk) then q <= d;
        end if;
     end process abc;
end architecture;
