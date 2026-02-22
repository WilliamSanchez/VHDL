library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ov7670_tb is
    generic(
        clk_hz : time := 1 sec / 1.0e6
    );
    port(
        clk : buffer bit;
        out_pixel: out std_logic_vector(7 downto 0);
        out_pclk : out std_logic;
        out_vsync: out std_logic;
        out_Hsync: out std_logic;
        xclk : out std_logic  
    );
end ov7670_tb;
architecture test of ov7670_tb is

    signal clk_s : std_logic;
    signal xclk_s : std_logic := '1';
    signal pclk_r : std_logic := '1';
    signal pclk_s : std_logic;
    signal rom_addr : unsigned(7 downto 0);
    signal rom_data : unsigned(7 downto 0) := "01110001";
    signal counter_addr: std_logic_vector(7 downto 0);
    signal reset_t : std_logic := '0';
    signal href_r : std_logic := '1';
    signal href_s : std_logic;
    signal vref_s : std_logic;
    signal pixel_s: std_logic_vector(7 downto 0);

    component Counter
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

    component ov7670
        generic (
            clk_hz : real := 1.0e6
        );
        port(
            clk :  in  std_logic;        
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
    end component;

begin

    teste: process
    begin
        wait for clk_hz/2;  clk <= not clk; 
            if clk = '1' then
                clk_s <= '1';
            else
                clk_s <= '0';
            end if;
    end process;
    
    sinal_counter: Counter port map(pclk_r,reset_t, counter_addr);
    sinal_sin: SinData port map(unsigned(counter_addr),reset_t, rom_data);
    sinal_pclk : ov7670 port map(clk_s,std_logic_vector(rom_data),pclk_r,href_r,href_r,pixel_s,href_s,vref_s,pclk_s,xclk_s);
    pclk_r <= xclk_s;
    out_pclk <= pclk_s;
    out_pixel <= pixel_s;
    out_Hsync <= href_s;
    out_Vsync <= vref_s;


end architecture;
