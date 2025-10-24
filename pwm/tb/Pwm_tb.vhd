library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity pwm_tb is
    port (
        clk : in std_logic;
        rst_n : in std_logic; --PullUp
        pwm_out : out std_logic
    );
end pwm_tb;
architecture test of pwm_tb is

    constant clk_hz : real := 12.0e6;
    constant pulse_hz : real := 50.0; -- PWM pulse frequency
    constant min_pulse_us : real := 500.0; -- uS pulse width at min position
    constant max_pulse_us : real := 2500.0; -- uS pulse width at max position
    constant step_bits : positive := 8; -- 0 to 255
    constant step_count : positive := 2**step_bits; -- Number of steps from  min to max
    constant cnt_bits : integer := 25;

    signal rst : std_logic;
    signal cnt : unsigned(cnt_bits - 1 downto 0);
    signal position : integer range 0 to step_count -1;
    signal rom_addr : unsigned(step_bits -1 downto 0);
    signal rom_data : unsigned(step_bits -1 downto 0);

begin

    position <= to_integer(rom_data);
    rom_addr <= cnt(cnt'left downto cnt'left - step_bits + 1);

    SERVO : entity work.pwm(behavioral)
    generic map (
        clk_hz => clk_hz,
        pulse_hz => pulse_hz, -- PWM pulse frequency
        min_pulse_us => min_pulse_us, -- uS pulse width at min position
        max_pulse_us => max_pulse_us, -- uS pulse width at max position
        step_count => step_count -- Number of steps from  min to max
    )
    port map(
        clk => clk,
        rst => rst,
        position => position,
        pwm_out => pwm_out
    );

    --COUNTER : entity work.counter(behavioral)
    --generic map(
    --    counter_bits => cnt_bits
    --)
    --port map(
    --    clk => clk,
    --    rst => rst,
    --    count_enable => '1',
    --    counter => cnt
    --);

    --SINE_ROM : entity work.sine_rom(behavioral)
    --generic map(
    --    data_bits => step_bits,
    --    addr_bits => step_bits
    --)
    --port map(
    --    clk => clk,
    --    addr => rom_addr,
    --    data => rom_data
    --);

end architecture;
