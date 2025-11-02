library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--
--
entity Pwm_tb is
    generic(
        clk_hz : time := 1 sec / 1.0e6
    );
    port (
        clk : buffer bit;
        rst_n : buffer bit;
        pwm_out : out std_logic
    );
end Pwm_tb;
architecture test of Pwm_tb is

 --   constant clk_hz : real := 1.0e6;
    -- constant clk_period : time := 1 sec / clk_hz;
--    constant pulse_hz : real := 50.0; -- PWM pulse frequency
--    constant min_pulse_us : real := 500.0; -- uS pulse width at min position
--    constant max_pulse_us : real := 2500.0; -- uS pulse width at max position
    constant step_bits : positive := 8; -- 0 to 255
    constant step_count : positive := 2**step_bits; -- Number of steps from  min to max
    constant cnt_bits : integer := 25;
--
--    signal rst : std_logic;
    signal cnt : unsigned(cnt_bits - 1 downto 0);
    signal position : integer range 0 to step_count -1;
    signal rom_addr : unsigned(step_bits -1 downto 0);
    signal rom_data : unsigned(step_bits -1 downto 0);
    signal clk_s : std_logic;
    signal counter_addr: std_logic_vector(7 downto 0);
    signal reset_t : std_logic;

    component Counter
        generic(
            clk_hz : real := 1.0e6;
            pulse_hz : real := 50.0 -- PWM pulse frequency
        );
        port(
            clk : in std_logic;
            rst : in std_logic;
            counter_out : out std_logic_vector(7 downto 0)
        );
    end component;

    component SinData
        port(
            addr : in unsigned(7 downto 0);
            ce : in std_logic;
            out_sin : out unsigned(7 downto 0)
        );
    end component;

    component Pwm 
        generic(
            clk_hz : real := 1.0e6;
            pulse_hz : real := 50.0; -- PWM pulse frequency
            min_pulse_us : real := 1000.0; -- uS pulse width at min position
            max_pulse_us : real := 2500.0; -- uS pulse width at max position
            step_count : positive := 256 -- Number of steps from  min to max
        );
        port (
            clk : in  std_logic;
            rst : in  std_logic;
            position : in  integer range 0 to step_count -1;
            pwm_out : out std_logic
        );
    end component;

begin
    reset : process
    begin
        reset_t <= '0'; wait for 10 ns;
        reset_t <= '1'; wait for 10 ns;
        reset_t <= '0'; wait;
    end process;


    teste: process
    begin
        wait for clk_hz/2;  clk <= not clk; 
            --position <= to_integer(rom_data);
            if clk = '1' then
                clk_s <= '1';
            else
                clk_s <= '0';
            end if;
    end process;
    
    sinal_counter: Counter port map(clk_s,reset_t, counter_addr);
    sinal_sin: SinData port map(unsigned(counter_addr),reset_t, rom_data);
    sinal_pwm : Pwm port map(clk_s,reset_t, to_integer(rom_data),pwm_out);
    --pwm_out <= counter_addr;

    --sinal_sin: SinData port map(rom_addr,'0', pwm_out);

    --SERVO : entity work.pwm(behavioral)
    --generic map (
    --    clk_hz => clk_hz,
    --    pulse_hz => pulse_hz, -- PWM pulse frequency
    --    min_pulse_us => min_pulse_us, -- uS pulse width at min position
    --    max_pulse_us => max_pulse_us, -- uS pulse width at max position
    --    step_count => step_count -- Number of steps from  min to max
    --)
    --port map(
    --    clk => clk,
    --    rst => rst,
    --    position => position,
    --    pwm_out => pwm_out
    --);

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

-- entity pwm_tb is
--     generic(
--         t_ck : TIME := 30 ns;
--         t_alto : TIME := 10 ns;
--         t_baixo : TIME := 20 ns;
--         t_rol : TIME := 10 ns
--     );
--     port
--     (
--         clk,  s1, s3 : BUFFER std_logic
--     );
-- end pwm_tb;
-- architecture behavioral of pwm_tb is
-- begin 
--     abc: process begin
--         wait for t_ck/2; clk <= not clk;
--     end process;
-- end architecture;

--(128, 131, 134, 137, 140, 143, 146, 149,
--152, 156, 159, 162, 165, 168, 171, 174,
--176, 179, 182, 185, 188, 191, 193, 196,
--199, 201, 204, 206, 209, 211, 213, 216,
--218, 220, 222, 224, 226, 228, 230, 232,
--234, 235, 237, 239, 240, 242, 243, 244,
--246, 247, 248, 249, 250, 251, 251, 252,
--253, 253, 254, 254, 254, 255, 255, 255,
--255, 255, 255, 255, 254, 254, 253, 253,
--252, 252, 251, 250, 249, 248, 247, 246,
--245, 244, 242, 241, 239, 238, 236, 235,
--233, 231, 229, 227, 225, 223, 221, 219,
--217, 215, 212, 210, 207, 205, 202, 200,
--197, 195, 192, 189, 186, 184, 181, 178,
--175, 172, 169, 166, 163, 160, 157, 154,
--151, 148, 145, 142, 138, 135, 132, 129,
--126, 123, 120, 117, 113, 110, 107, 104,
--101, 98, 95, 92, 89, 86, 83, 80,
--77, 74, 71, 69, 66, 63, 60, 58,
--55, 53, 50, 48, 45, 43, 40, 38,
--36, 34, 32, 30, 28, 26, 24, 22,
--20, 19, 17, 16, 14, 13, 11, 10,
--9, 8, 7, 6, 5, 4, 3, 3,
--2, 2, 1, 1, 0, 0, 0, 0,
--0, 0, 0, 1, 1, 1, 2, 2,
--3, 4, 4, 5, 6, 7, 8, 9,
--11, 12, 13, 15, 16, 18, 20, 21,
--23, 25, 27, 29, 31, 33, 35, 37,
--39, 42, 44, 46, 49, 51, 54, 56,
--59, 62, 64, 67, 70, 73, 76, 79,
--81, 84, 87, 90, 93, 96, 99, 103,
--106, 109, 112, 115, 118, 121, 124);