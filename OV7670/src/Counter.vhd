library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.round;

entity Counter is
    port(
        clk : in std_logic;
        rst : in std_logic;
        counter_out : out std_logic_vector(7 downto 0)
    );
end Counter;

architecture behavioral of Counter is
    constant max_count : integer := 255;
    signal counter_up : std_logic_vector(7 downto 0) := "00000000";
    signal counter_clock : integer range 0 to max_count;
begin

    process(clk)
    begin
        --if((clk'event) and (rst = '0')) then
        if(rst = '0') then
            if rising_edge(clk) then
                if counter_clock < max_count then
                    counter_clock <= counter_clock + 1;
                    counter_up <=  std_logic_vector(unsigned(counter_up)+1);
                else
                    counter_clock <= 0;                    
                end if;
            end if;
        else
            counter_up <= "00000000";
        end if;
    end process;

    counter_out <= counter_up;

end architecture;