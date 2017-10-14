
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity windowsManager is
    Port ( RS1 : in  STD_LOGIC_VECTOR (4 downto 0);
           RS2 : in  STD_LOGIC_VECTOR (4 downto 0);
           RD : in  STD_LOGIC_VECTOR (4 downto 0);
           OP : in  STD_LOGIC_VECTOR (1 downto 0);
           OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
           CWP : in  STD_LOGIC_VECTOR (4 downto 0);
           NCWP : out  STD_LOGIC_VECTOR (4 downto 0);
           NRS1 : out  STD_LOGIC_VECTOR (5 downto 0);
           NRS2 : out  STD_LOGIC_VECTOR (5 downto 0);
           NRD : out  STD_LOGIC_VECTOR (5 downto 0));
end windowsManager;

architecture Behavioral of windowsManager is

begin


end Behavioral;

