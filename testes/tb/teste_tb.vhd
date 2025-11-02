library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity teste_tb is
    port(
        ck_t : BUFFER std_logic;
        rst_t : BUFFER std_logic;
        d_t : BUFFER std_logic_vector(3 downto 0);
        q_t : BUFFER std_logic_vector(3 downto 0);
        q : BUFFER std_logic_vector(3 downto 0);
        clk_o : out std_logic
    );
end entity;

architecture behavioral of teste_tb is
    type sinais is
        record ck, rst :  std_logic;
                d :  std_logic_vector(3 downto 0); 
                q :  std_logic_vector(3 downto 0);
        end record;
    
    type conjunto_sinais is array (natural range <>) of sinais;
    constant vetores : conjunto_sinais := 
    (('U','1',"UUUU","UUUU"),('U','0',"UUUU","0000"),('1','1',"UUUU","0000"),
     ('0','1',"ZZZZ","0000"),('0','1',"1010","0000"),('1','1',"1010","1010"),
     ('0','1',"ZZZZ","1010"),('0','1',"0101","1010"),('1','1',"0101","0101"),
     ('0','1',"ZZZZ","0101"),('0','1',"1100","0101"),('1','1',"0011","0011"));

     component teste
        port(
            clk : in  std_logic;
            rst : in  std_logic;
            d : in  std_logic_vector(3 downto 0);
            q : buffer std_logic_vector(3 downto 0);
            clk_out : out std_logic
        );
     end component;

    -- signal q_td : std_logic_vector(3 downto 0);

begin
    operacao : process
    begin
        for i in 0 to vetores'length loop
            ck_t  <= vetores(i).ck;
            rst_t <= vetores(i).rst;
            d_t   <= vetores(i).d;
            q_t   <= vetores(i).q;
            wait for 10 ns;
        end loop;
        wait;
    end process;

    iguais : postponed process(q, q_t)
    begin
        assert q = q_t
        report "valor da saida q difere do valor proposto" severity error;
    end process;

    x1 : teste port map(ck_t, rst_t, d_t, q, clk_o);

end architecture;