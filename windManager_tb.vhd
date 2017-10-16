
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use IEEE.STD_LOGIC_ARITH.ALL;


 
ENTITY windManager_tb IS
END windManager_tb;
 
ARCHITECTURE behavior OF windManager_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT windowsManager
    PORT(
         RS1 : IN  std_logic_vector(4 downto 0);
         RS2 : IN  std_logic_vector(4 downto 0);
         RD : IN  std_logic_vector(4 downto 0);
         OP : IN  std_logic_vector(1 downto 0);
         OP3 : IN  std_logic_vector(5 downto 0);
         CWP : IN  std_logic_vector(4 downto 0);
         NCWP : OUT  std_logic_vector(4 downto 0);
         NRS1 : OUT  std_logic_vector(5 downto 0);
         NRS2 : OUT  std_logic_vector(5 downto 0);
         NRD : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RS1 : std_logic_vector(4 downto 0) := (others => '0');
   signal RS2 : std_logic_vector(4 downto 0) := (others => '0');
   signal RD : std_logic_vector(4 downto 0) := (others => '0');
   signal OP : std_logic_vector(1 downto 0) := (others => '0');
   signal OP3 : std_logic_vector(5 downto 0) := (others => '0');
   signal CWP : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal NCWP : std_logic_vector(4 downto 0);
   signal NRS1 : std_logic_vector(5 downto 0);
   signal NRS2 : std_logic_vector(5 downto 0);
   signal NRD : std_logic_vector(5 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: windowsManager PORT MAP (
          RS1 => RS1,
          RS2 => RS2,
          RD => RD,
          OP => OP,
          OP3 => OP3,
          CWP => CWP,
          NCWP => NCWP,
          NRS1 => NRS1,
          NRS2 => NRS2,
          NRD => NRD
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
     
			 CWP <= "00000";
			 --CWP <= "00001";
			 OP <= "00";
          OP3 <= "000000";
			 RS1 <= "00000"; --0
          RS2 <= "00001"; --1
          RD <= "00111"; --7
 wait for 10 ns;	
 

			 RS1 <= "11111"; --31
          RS2 <= "10000"; --16
          RD <= "00100"; -- 8
 wait for 10 ns;	

 
			CWP <= "00001";
 			 RS1 <= "11111"; --31
          RS2 <= "10110"; --16
          RD <= "01100"; -- 8
 wait for 10 ns;	

 
			CWP <= "00000";
 			 RS1 <= "10011";--19
          RS2 <= "00010"; --2
          RD <= "11010"; --26
 wait for 10 ns;	
 

			CWP <= "00001";
 			 RS1 <= "01111"; --15
          RS2 <= "00000"; -- 0
          RD <= "10110";  --21
 wait for 10 ns;	
 


      -- insert stimulus here 

      wait;
   end process;

END;
