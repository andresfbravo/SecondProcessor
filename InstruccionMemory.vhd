
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

--int k = 6


entity InstruccionMemory is
    Port ( address : in  STD_LOGIC_VECTOR (31 downto 0);
           rst : in  STD_LOGIC;
           instruction : out  STD_LOGIC_VECTOR (31 downto 0));
end InstruccionMemory;

architecture syn of InstruccionMemory is
    type rom_type is array (0 to 63) of std_logic_vector (31 downto 0);                 
    signal ROM : rom_type:= ("10000010000100000010000000000101",
										"10100000000100000011111111111000",
										"10100010000100000010000000000100",
										"10110001001010000110000000000010",
										"10110011001101000110000000000001",
										"10000001111010000010000000000000",
										"10100000000000000110000000000011",
										"10000001111000000010000000000000",
										"10000000001000000010000000000100",
										"10000100010000000000000000000001",
										"10010000000100000000000000010000",
                            others => "00000000000000000000000000000000");                                              
begin

    process (rst,Address)
    begin
        if (rst = '1') then
            
            instruction <=  "00000000000000000000000000000000"; 
--				Address =>  "00000000000000000000000000000000";  la salida se pone en 0 mientras reset es 1
-- pero cuando este valor es 0 vuelve y toma el actual del address.
			else
				instruction <= ROM(conv_integer(address));
            
        end if;
    end process;


end syn;

