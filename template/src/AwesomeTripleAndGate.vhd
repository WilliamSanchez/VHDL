library ieee;
use ieee.std_logic_1164.all;


entity AwesomeTripleAndGate is
    port (
        A : in  std_logic;
        B : in  std_logic;
        C : in  std_logic;
        O : out std_logic
    );
end entity;


architecture behavioral of AwesomeTripleAndGate is
    signal temp : std_logic;
begin
     AND0: entity work.SimpleAndGate(teste) port map (A, B, temp);
     AND1: entity work.SimpleAndGate(teste) port map (C, temp, O);
    -- O <= A and B and C;
end architecture;
