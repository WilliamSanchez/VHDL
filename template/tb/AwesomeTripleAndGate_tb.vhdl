library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity AwesomeTripleAndGate_tb is
end entity;


architecture test of AwesomeTripleAndGate_tb is
    signal A : std_logic;
    signal B : std_logic;
    signal C : std_logic;
    signal O : std_logic;

    signal temp : std_logic_vector (2 downto 0) := "000";
begin
    T0: entity work.AwesomeTripleAndGate(behavioral) port map (A, B, C, O);

    test: process
    begin
        -- For inputs 000 through 110, output should be zero
        for i in 0 to 6 loop
            temp <= std_logic_vector(to_unsigned(i, 3));
            wait for 1 ns;
            
            A <= temp(0);
            B <= temp(1);
            C <= temp(2);

            wait for 1 ns;
            assert O = '0' report "Output is wrong for inputs other than 111" severity error;
        end loop;

        A <= '1';
        B <= '1';
        C <= '1';

        wait for 1 ns;
        assert O = '1' report "Output is wrong for input 111" severity error;
    end process;
end architecture;
