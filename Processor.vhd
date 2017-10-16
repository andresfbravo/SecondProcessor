library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity Processor is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           ALURESULT : out  STD_LOGIC_VECTOR (31 downto 0));
end Processor;

architecture Behavioral of Processor is

	COMPONENT ALU
	PORT(
		CRS1 : IN std_logic_vector(31 downto 0);
		CRS2mux : IN std_logic_vector(31 downto 0);
		ALUOP : IN std_logic_vector(5 downto 0);
		C : IN std_logic;          
		ALURESULT : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;


	COMPONENT PSR_modifier
	PORT(
		ALUOP : IN std_logic_vector(5 downto 0);
		RESULT : IN std_logic_vector(31 downto 0);
		RS1 : IN std_logic_vector(31 downto 0);
		RS2 : IN std_logic_vector(31 downto 0);          
		NZVC : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;


	COMPONENT mux01
	PORT(
		crs2 : IN std_logic_vector(31 downto 0);
		i : IN std_logic;
		seuin : IN std_logic_vector(31 downto 0);          
		muxout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;




	COMPONENT RegisterFile
	PORT(
		rs1 : IN std_logic_vector(5 downto 0);
		rs2 : IN std_logic_vector(5 downto 0);
		rd : IN std_logic_vector(5 downto 0);
		DtoWrite : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;          
		crs1 : OUT std_logic_vector(31 downto 0);
		crs2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;


	COMPONENT psr
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		nzvc : IN std_logic_vector(3 downto 0);
		ncwp : IN std_logic_vector(4 downto 0);          
		cwp : OUT std_logic_vector(4 downto 0);
		c : OUT std_logic
		);
	END COMPONENT;


	COMPONENT SEU
	PORT(
		imm13 : IN std_logic_vector(12 downto 0);          
		seuout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;


	COMPONENT ControlUnit
	PORT(
		OP : IN std_logic_vector(1 downto 0);
		OP3 : IN std_logic_vector(5 downto 0);          
		ALUOP : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	
	COMPONENT windowsManager
	PORT(
		RS1 : IN std_logic_vector(4 downto 0);
		RS2 : IN std_logic_vector(4 downto 0);
		RD : IN std_logic_vector(4 downto 0);
		OP : IN std_logic_vector(1 downto 0);
		OP3 : IN std_logic_vector(5 downto 0);
		CWP : IN std_logic_vector(4 downto 0);          
		NCWP : OUT std_logic_vector(4 downto 0);
		NRS1 : OUT std_logic_vector(5 downto 0);
		NRS2 : OUT std_logic_vector(5 downto 0);
		NRD : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;

	COMPONENT InstruccionMemory
	PORT(
		address : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;          
		instruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;




	COMPONENT sumador32bits
	PORT(
		datainA : IN std_logic_vector(31 downto 0);
		datainB : IN std_logic_vector(31 downto 0);          
		Salida : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;


	COMPONENT regis
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		datain : IN std_logic_vector(31 downto 0);          
		dataout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;


--señales auxiliares

signal aux_npcsumpc: std_logic_vector(31 downto 0);
signal aux_sumnpc: std_logic_vector(31 downto 0);
signal aux_pcim: std_logic_vector(31 downto 0);
signal aux_outIM: std_logic_vector(31 downto 0);
signal aux_cwp: std_logic_vector(4 downto 0);
signal aux_ncwp: std_logic_vector(4 downto 0);
signal aux_nrs1: std_logic_vector(5 downto 0);
signal aux_nrs2: std_logic_vector(5 downto 0);
signal aux_nrd: std_logic_vector(5 downto 0);
signal aux_aluop: std_logic_vector(5 downto 0);
signal aux_seumux: std_logic_vector(31 downto 0);
signal aux_C: std_logic;
signal aux_nzvc: std_logic_vector(3 downto 0);
signal aux_aluresult: std_logic_vector(31 downto 0); --alu
signal aux_crs1: std_logic_vector(31 downto 0); --alu
signal aux_crs2mux: std_logic_vector(31 downto 0); -- registe al mux
signal aux_crs2: std_logic_vector(31 downto 0); -- mux a la alu y al psrmodifier

begin

	Inst_ALU: ALU PORT MAP(
		CRS1 => aux_crs1 ,
		CRS2mux => aux_crs2,
		ALUOP => aux_aluop,
		C => aux_C,
		ALURESULT => aux_aluresult
	);
	
	Inst_PSR_modifier: PSR_modifier PORT MAP(
		ALUOP => aux_aluop,
		RESULT => aux_aluresult,
		RS1 => aux_crs1,
		RS2 => aux_crs2,
		NZVC => aux_nzvc
	);
	
	
	multiplexorCRS2: mux01 PORT MAP(
		crs2 =>aux_crs2mux ,
		i => aux_outIM(13),
		seuin => aux_seumux,
		muxout => aux_crs2
	);
	
	Inst_RegisterFile: RegisterFile PORT MAP(
		rs1 =>aux_nrs1 ,
		rs2 => aux_nrs2,
		rd => aux_nrd ,
		DtoWrite => aux_aluresult,
		rst => rst,
		crs1 => aux_crs1,
		crs2 => aux_crs2mux
	);
	
	I_psr: psr PORT MAP(
		clk => clk,
		rst => rst,
		nzvc => aux_nzvc,
		ncwp => aux_ncwp,
		cwp => aux_cwp,
		c => aux_C
	);
	
	ExtDeSig: SEU PORT MAP(
		imm13 => aux_outIM(12 downto 0),
		seuout => aux_seumux
	);
	
	UC: ControlUnit PORT MAP(
		OP => aux_outIM(31 downto 30) ,
		OP3 => aux_outIM(24 downto 19) ,
		ALUOP => aux_aluop
	);


	WinManager: windowsManager PORT MAP(
		RS1 => aux_outIM(18 downto 14) ,
		RS2 => aux_outIM(4 downto 0) ,
		RD => aux_outIM(29 downto 25) ,
		OP => aux_outIM(31 downto 30) ,
		OP3 => aux_outIM(24 downto 19) ,
		CWP => aux_cwp,
		NCWP => aux_ncwp,
		NRS1 => aux_nrs1,
		NRS2 => aux_nrs2,
		NRD => aux_nrd
	);
	
	IM: InstruccionMemory PORT MAP(
		address => aux_pcim,
		rst => RST,
		instruction => aux_outIM
	);

	SUMADOR_PC: sumador32bits PORT MAP(
		datainA => "00000000000000000000000000000001",
		datainB => aux_npcsumpc,
		Salida => aux_sumnpc
	);

	PC: regis PORT MAP(
		clk => CLK,
		rst => RST,
		datain => aux_npcsumpc ,
		dataout => aux_pcim
	);
	
	NPC: regis PORT MAP(
		clk => CLK,
		rst => RST,
		datain => aux_sumnpc,
		dataout => aux_npcsumpc
	);
	
	ALURESULT <= aux_aluresult;
end Behavioral;

