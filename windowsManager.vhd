
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity windowsManager is
    Port ( RS1 : in  STD_LOGIC_VECTOR (4 downto 0);
           RS2 : in  STD_LOGIC_VECTOR (4 downto 0);
           RD : in  STD_LOGIC_VECTOR (4 downto 0);
           OP : in  STD_LOGIC_VECTOR (1 downto 0);
           OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
           CWP : in  STD_LOGIC_VECTOR (4 downto 0);
           NCWP : out  STD_LOGIC_VECTOR (4 downto 0):= "00000";
           NRS1 : out  STD_LOGIC_VECTOR (5 downto 0);
           NRS2 : out  STD_LOGIC_VECTOR (5 downto 0);
           NRD : out  STD_LOGIC_VECTOR (5 downto 0));
end windowsManager;

architecture Behavioral of windowsManager is

begin
	
	process(OP, OP3, RS1, RS2, RD, CWP)
	begin
		

		----------------------------------------------------
			IF( RS1 >= "11000" AND RS1 <= "11111") THEN  -- MODIFICAR RS1
			
				--NRS1 <= ('0' & RS1 )  - (('0' & CWP )* ('0' &"10000"));
				if cwp = "00001" then
					NRS1 <= ('0' & RS1 ) - "10000"; 
				elsif cwp = "00000" then
					NRS1 <= ('0' & RS1 );
				end if;
				
				
			ELSIF ( RS1 >= "10000" AND RS1 <= "10111") THEN 
			
				--NRS1 <= ('0' & RS1 )  + (('0' & CWP) * ('0' &"10000"));
				if cwp = "00001" then
					NRS1 <= ('0' & RS1 ) + "10000"; 
				elsif cwp = "00000" then
					NRS1 <= ('0' & RS1 );
				end if;
				
				
			ELSIF ( RS1 >= "01000" AND RS1 <= "01111") THEN 
			
				--NRS1 <= ('0' & RS1 )  + (('0' &CWP )* ('0' &"10000"));
				if cwp = "00001" then
					NRS1 <= ('0' & RS1 ) + "10000"; 
				elsif cwp = "00000" then
					NRS1 <= ('0' & RS1 );
				end if;
				
			
			ELSE
				
				NRS1 <= ('0' & RS1 ); 
				
			END IF;
			------------------------------------------------
			IF( RS2 >= "11000" AND RS2 <= "11111") THEN  -- MODIFICAR RS2
			
				--NRS2 <= ('0' & RS2 )  - (('0' &CWP) * ('0' &"10000"));
				if cwp = "00001" then
					NRS2 <= ('0' & RS2 ) - "10000"; 
				elsif cwp = "00000" then
					NRS2 <= ('0' & RS2 );
				end if;
				 
				
			ELSIF ( RS2 >= "10000" AND RS2 <= "10111") THEN 
			
				--NRS2 <= ('0' & RS2 )  + (('0' &CWP )* ('0' &"10000"));
				if cwp = "00001" then
					NRS2 <= ('0' & RS2 )+ "10000"; 
				elsif cwp = "00000" then
					NRS2 <= ('0' & RS2 );
				end if;
				
				
			ELSIF ( RS2 >= "01000" AND RS2 <= "01111") THEN 
			
				--NRS2 <= ('0' & RS2 )  + (('0' &CWP) * ('0' &"10000"));
				if cwp = "00001" then
					NRS2 <= ('0' & RS2 )+ "10000"; 
				elsif cwp = "00000" then
					NRS2 <= ('0' & RS2 );
				end if;
				
			
			ELSE
				NRS2 <= ('0' & RS2 );

				
			END IF;
			--------------------------------------------------
			
		--if( OP = "10" AND OP3 = "111100" )  THEN-- SAVE
		
		--ELSIF(OP = "10" AND OP3 = "111101") THEN-- RESTORE
	
		--ELSE
			IF( RD >= "11000" AND RD <= "11111") THEN  -- MODIFICAR RD
			
				--NRD <= ('0' & RD )  - (('0' &CWP) * ('0' &"10000"));
				if cwp = "00001" then
					NRD <= ('0' & RD ) - "10000";
				elsif cwp = "00000" then
					NRD <= ('0' & RD ) ;
				end if;
				
				
			ELSIF ( RD >= "10000" AND RD <= "10111") THEN 
				--NRD <= ('0' & RD )  + (('0' &CWP )* ('0' & "10000"));
			if cwp = "00001" then
					NRD <= ('0' & RD ) + "10000";
				elsif cwp = "00000" then
					NRD <= ('0' & RD );
				end if;
			
				
				
				
			ELSIF ( RD >= "01000" AND RD <= "01111") THEN 
			
				--NRD <= ('0' & RD )  + (('0' &CWP )* ('0' &"10000"));
				if cwp = "00001" then
					NRD <= ('0' & RD ) + "10000";
				elsif cwp = "00000" then
					NRD <= ('0' & RD );
				end if;
			ELSE
				NRD <= ('0' & RD ); 
			END IF;
		
		--END IF;
		

	end process;
	

end Behavioral;

