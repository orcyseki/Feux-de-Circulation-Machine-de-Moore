library ieee;
use ieee.std_logic_1164.all;

entity tb_feu_tricolore is
end entity;

architecture sim of tb_feu_tricolore is

    -- signaux de test
    signal clk   : std_logic := '0';
    signal rst   : std_logic := '1';
    signal reqH  : std_logic := '0';
    signal reqV  : std_logic := '0';
    signal RH, YH, VH : std_logic;
    signal RV, YV, VV : std_logic;

    constant periode_clk : time := 10 ns;

begin

    -- instanciation de l'ALU
    uut: entity work.feu_tricolore
        port map(
            clk  => clk,
            rst  => rst,
            reqH => reqH,
            reqV => reqV,
            RH   => RH,
            YH   => YH,
            VH   => VH,
            RV   => RV,
            YV   => YV,
            VV   => VV
        );

    -- génération horloge
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for periode_clk / 2;
            clk <= '1';
            wait for periode_clk / 2;
        end loop;
    end process;

    -- stimulus
    stim_proc : process
    begin
        -- reset initial
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 20 ns;

        -- test sans demande piétons
        wait for 200 ns;

        -- demande piéton sur la voie horizontale
        reqH <= '1';
        wait for 5 * periode_clk;  -- active pendant 5 cycles
        reqH <= '0';

        wait for 100 ns;

        -- demande piéton sur la voie verticale
        reqV <= '1';
        wait for 5 * periode_clk;
        reqV <= '0';

        wait for 200 ns;

        -- fin simulation
        wait;
    end process;

end architecture;
