library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.round;


entity ov7670 is
    --generic(
    --    clk_hz : real := 50.0e6
    --);
    port (
        clk :  in  std_logic;  
        led1 : out  STD_LOGIC;     
        pixel : in std_logic_vector(7 downto 0);        -- Camera   --> FPGA
        pclk:  in std_logic;                            -- Camera   --> FPGA
        Hsync: in std_logic;                            -- Camera   --> FPGA
        Vsync: in std_logic;                            -- Camera   --> FPGA
        out_pixel: out std_logic_vector(7 downto 0);    -- FPGA     --> MCP
        out_Hsync: out std_logic;                       -- FPGA     --> MCP
        out_Vsync: out std_logic;                       -- FPGA     --> MCP
        out_pclk: out std_logic;                        -- FPGA     --> MCP
        xclk : out std_logic                            -- FPGA     --> Camera
    );
end ov7670;

architecture behavioral of ov7670 is 
    signal out_clk : std_logic := '0';
    signal frame : std_logic := '0';
    signal spixel: std_logic_vector(7 downto 0);

begin
    process (clk)
    begin
        if rising_edge(clk) then
            out_clk <= not out_clk;
        end if;
    end process;

    process (Vsync)
    begin
        if Vsync = '1' then
            frame <= not frame;
        end if;
    end process;

    process (pclk, clk)
    begin
        if rising_edge(pclk) then
            if Hsync = '1' then
                spixel <= pixel;
            else
                spixel <= "00000000";
            end if; 
            
        end if;
    end process;
    
    led1 <= frame;
    xclk <= out_clk;
    out_pclk <= pclk;       -- FPGA --> MicroProcessor
    out_pixel <= spixel;    -- FPGA --> MicroProcessor   
    out_Vsync <= Vsync;     -- FPGA --> MicroProcessor
    out_Hsync <= Hsync;     -- FPGA --> MicroProcessor

end architecture;
