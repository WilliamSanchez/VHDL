----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:40:12 11/01/2025 
-- Design Name: 
-- Module Name:    servo - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.round;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity servo is
	generic(
		clk_hz : real := 50.0e6;
      pulse_hz : real := 50.0; -- PWM pulse frequency
      min_pulse_us : real := 1000.0; -- uS pulse width at min position
      max_pulse_us : real := 2500.0; -- uS pulse width at max position
      step_count : positive := 256 -- Number of steps from  min to max		
    );		  
    Port ( clk : in  STD_LOGIC;           
           rst : in  STD_LOGIC;
           up : in  STD_LOGIC;
           down : in  STD_LOGIC;
			  pwm : out  STD_LOGIC;
			  upled : out  STD_LOGIC;
			  downled : out  STD_LOGIC);
end servo;

architecture Behavioral of servo is
    function cycles_per_us(us_count : real ) return integer is
        begin
            return integer(round(pulse_hz/clk_hz*us_count));
    end function;

    constant max_counter : integer := integer(round(clk_hz / pulse_hz)) - 1; 
    constant min_count : integer := max_counter/20; --cycles_per_us(min_pulse_us);
    constant max_count : integer := 2*max_counter/20; --cycles_per_us(max_pulse_us);
	 constant counter_steps : integer := (max_count - min_count)/(2**4-1);	 
    
	 signal counter_up : std_logic_vector(7 downto 0);
    signal counter_clock : integer range 0 to max_counter;
	 signal duty_cycle : integer range 0 to max_counter; --max_count;
	 signal pwm_out : std_logic := '0';
	 signal position : integer range 0 to 2**4 - 1 := 0;
begin
    process(clk, rst)
    begin
        --if((clk'event) and (rst = '0')) then
        if(rst = '1') then
            if rising_edge(clk) then
                if counter_clock < max_counter then
                    counter_clock <= counter_clock + 1;
                else
                    counter_clock <= 0;
						  --pwm_out <= not pwm_out;
                end if;
            end if;
        end if;
    end process;
	 
	 PWM_PROC : process(clk)
    begin
        if rising_edge(clk) then
            if rst = '0' then
                pwm_out <= '0';
            else
                pwm_out <= '0';
                if counter_clock < duty_cycle then                    
                    pwm_out <= '1';
                end if;
            end if;
        end if ;
    end process;
	 
	 POS : process(position, up, down)
	 begin
	 --	upled <= up;
	 --   downled <= down;
		if up = '0' then 
			position <= position + 1;
		elsif down = '0' then
			position <= position - 1;
		end if;	 
	 end process;
	 
	 DUTY_CYCLE_PROC : process(clk)
    begin
        if rising_edge(clk) then
            if rst = '0' then
                duty_cycle <= min_count;
            else
                --duty_cycle <= position * cycles_per_step + min_count;
                duty_cycle <= counter_steps*position + min_count;        
            end if ;
        end if ;
    end process;
	
	pwm <= pwm_out;
	upled <= not up;
   downled <= not down;	
	
end Behavioral;

