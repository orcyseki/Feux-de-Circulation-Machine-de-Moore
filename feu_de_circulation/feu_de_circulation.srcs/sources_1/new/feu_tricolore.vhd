library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity feu_tricolore is
    port(
        clk   : in std_logic;
        rst   : in std_logic;
        reqH  : in std_logic;  -- demande piéton voie horizontale
        reqV  : in std_logic;  -- demande piéton voie verticale
        RH, YH, VH : out std_logic;
        RV, YV, VV : out std_logic
    );
end entity;

architecture rtl of feu_tricolore is

    -- états Moore
    type etat_type is (V_H, O_H, V_V, O_V);
    signal etat, etat_suiv : etat_type;

    -- mémoires piétons
    signal memH, memV : std_logic := '0';
    signal delayH, delayV : integer range 0 to 3 := 0;

    -- compteurs génériques
    signal c_vert :unsigned(13 downto 0);
    signal c_orange :unsigned(1 downto 0);
begin

    -- instanciation compteurs
    compteur_vert : entity work.compteur_bin
        generic map(N => 14)
        port map(clk => clk, rst => rst, q => c_vert);

    compteur_orange : entity work.compteur_bin
        generic map(N => 2)
        port map(clk => clk, rst => rst, q => c_orange);

    -- processus principal FSM
    process(clk, rst)
    begin
        if rst = '1' then
            etat <= V_H;
            memH <= '0';
            memV <= '0';
            delayH <= 0;
            delayV <= 0;
        elsif rising_edge(clk) then

            -- gestion des demandes piétons
            if reqH = '1' then
                if delayH < 3 then
                    delayH <= delayH + 1;
                else
                    if etat = V_H then
                        memH <= '1';
                    end if;
                    delayH <= 0;
                end if;
            end if;

            if reqV = '1' then
                if delayV < 3 then
                    delayV <= delayV + 1;
                else
                    if etat = V_V then
                        memV <= '1';
                    end if;
                    delayV <= 0;
                end if;
            end if;

            -- transitions FSM
            case etat is
                when V_H =>
                    if c_vert = 13 or memH = '1' then
                        etat <= O_H;
                        memH <= '0';  -- reset mémoire
                    end if;

                when O_H =>
                    if c_orange = 2 then
                        etat <= V_V;
                    end if;

                when V_V =>
                    if c_vert = 14 or memV = '1' then
                        etat <= O_V;
                        memV <= '0';
                    end if;

                when O_V =>
                    if c_orange = 2 then
                        etat <= V_H;
                    end if;
            end case;

        end if;
    end process;

    -- sorties Moore
    RH <= '0' when etat = V_H or etat = O_H else '1';
    YH <= '1' when etat = O_H else '0';
    VH <= '1' when etat = V_H else '0';

    RV <= '0' when etat = V_V or etat = O_V else '1';
    YV <= '1' when etat = O_V else '0';
    VV <= '1' when etat = V_V else '0';

end architecture;
