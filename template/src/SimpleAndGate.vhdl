library ieee;
use ieee.std_logic_1164.all;


entity SimpleAndGate is
    port (
        A : in  std_logic;
        B : in  std_logic;
        O : out std_logic
    );
end entity;


architecture behavioral of SimpleAndGate is
begin
    O <= A and B;
end architecture;
