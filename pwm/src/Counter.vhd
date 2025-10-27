library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Counter is
    port(
        clk : in std_logic;
        rst : in std_logic;
        counter_out : out std_logic_vector(7 downto 0)
    );
end Counter;

architecture behavioral of Counter is
    signal counter_up : std_logic_vector(7 downto 0);
begin

    process(clk)
    begin
        if((clk'event) and (rst = '0')) then
            counter_up <=  std_logic_vector(unsigned(counter_up)+1);
        else
            counter_up <= "00000000";
        end if;
    end process;

    counter_out <= counter_up;

end architecture;