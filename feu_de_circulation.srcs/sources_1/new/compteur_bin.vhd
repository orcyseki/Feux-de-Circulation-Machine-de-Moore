----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.11.2025 22:23:42
-- Design Name: 
-- Module Name: compteur_bin - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

entity compteur_bin is
    generic(
        N : integer := 14  -- nombre de bits maximums du compteur
    );
    port(
        clk : in std_logic;
        rst : in std_logic;
        q   : out unsigned(N-1 downto 0)
    );
end entity;

architecture rtl of compteur_bin is   
  signal compteur : unsigned(N-1 downto 0) := (others => '0');
begin

    process(clk, rst)
    begin
        if rst = '1' then
            compteur <= (others => '0');  -- remise à zéro
        elsif rising_edge(clk) then
            compteur <= compteur + 1;     -- incrémentation
        end if;
    end process;

    q <= compteur; -- sortie

end rtl;

