--		Organização e Arquitetura de Computadores - Turma C - 2019/2	
--				Trabalho 2 - ULA e GERADOR DE IMEDIATOS RISC-V
--
--Nome:											Matrícula: 
--Nome: Gabriel Crespo de Souza			Matrícula: 14/0139982
--Nome: Wellington da Silva Stanley 	Matrícula: 11/0143981


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Esse bloco é usado para definir a entidade genImm32_tb. Só que não há necessidade de se especificar as
--características da mesma, pois já há essa especificação no arquivo genImm32.vhd.		
entity genImm32_tb is
end genImm32_tb;		

--Esse bloco é associado à entidade genImm32_tb e utilizado para descrever o comportamento da entidade
--genImm32
architecture genImm32_tb of genImm32_tb is
--As variáveis definidas abaixo são vetores lógicos de tamanho 32, ou seja,
--são palavras de 32 bits.
signal inst: std_logic_vector(31 downto 0);
signal imm32: std_logic_vector(31 downto 0);

--O componente "gerador de imediatos" de 32 bits é definido aqui, definindo suas portas de entrada
--e de saída. A entrada "inst" recebe uma palavra de 32 bits que representa a instrução e a saída 
--imm32 também recebe uma palavra de 32 bits que representa o imediato gerado.
component genImm32
	port(
	
		inst: in std_logic_vector(31 downto 0);
		imm32: out std_logic_vector(31 downto 0)
	
	);
end component;

begin
--i1 é uma instância do componente genImm32. Dentro dessa instância, estamos mapeando as variáveis
--do tipo signal para as portas de entrada e saída, respectivamente.
	i1: genImm32
	port map(
		--mapeamento das variáveis para as portas da instância i1.
		inst => inst,
		imm32 => imm32	
	);
--Nesse bloco, inicia-se a especificação dos casos de teste a serem processados para a verificação do 
--funcionamento correto da unidade geradora de imediatos. A execução por completo deve demorar 48 picosegundos,
--pois são 11 instruções que levam 4 picosegundos para serem executadas de maneira individual.
init: process
begin 

		--Instrução Tipo-R
		--O valor hexadecimal 0x000002B3 representa a instrução "add t0, zero, zero". Após execução, o resultado
		--esperado é o valor "0" em 32 bits pois não existem imediatos nesse tipo de instrução.
		inst <= x"000002B3";
		wait for 4 ps;

		--Instrução Tipo-I
		--O valor hexadecimal 0x01002283 representa a instrução "lw t0, 16(zero)". Após execução, o resultado
		--esperado é o imediato "16" em 32 bits.
		inst <= x"01002283";
		wait for 4 ps;
		
		--Instrução Tipo-I 
		--O valor hexadecimal 0xF9C00313 representa a instrução "addi t1, zero, -100". Após execução, o resultado
		--esperado é o imediato "-100" em 32 bits.
		inst <= x"F9C00313";
		wait for 4 ps;		
		
		--Instrução Tipo-I
		--O valor hexadecimal 0xFFF2C293 representa a instrução "xori t0, t0, -1". Após execução, o resultado
		--esperado é o imediato "-1" em 32 bits.
		inst <= x"FFF2C293";
		wait for 4 ps;
		
		--Instrução Tipo-I
		--O valor hexadecimal 0x16200313 representa a instrução "addi t1, zero, 354". Após execução, o resultado
		--esperado é o imediato "354" em 32 bits.
		inst <= x"16200313";
		wait for 4 ps;
		
		--Instrução Tipo-I
		--O valor hexadecimal 0x01800067 representa a instrução "jalr zero, zero, 0x18". Após execução, o resultado
		--esperado é o imediato "0x18/24" em 32 bits.
		inst <= x"01800067";
		wait for 4 ps;
		
		--Instrução Tipo-U
		--O valor hexadecimal 0x00002437 representa a instrução "lui s0, 2". Após execução, o resultado
		--esperado é o imediato "0x2000/8192" em 32 bits.
		inst <= x"00002437";
		wait for 4 ps;
		
		--Instrução Tipo-U
		--O valor hexadecimal 0x00002417 representa a instrução "lui s0, 2". Após execução, o resultado
		--esperado é o imediato "0x2000/8192" em 32 bits. 
		inst <= x"00002417";
		wait for 4 ps;
		
		--Instrução Tipo-S
		--O valor hexadecimal 0x02542E23 representa a instrução "sw t0, 60(s0)". Após execução, o resultado
		--esperado é o imediato "60" em 32 bits.
		inst <= x"02542E23";
		wait for 4 ps;
		
		--Instrução Tipo-B
		--O valor hexadecimal 0xFE5290E3 representa a instrução "bne t0, t0, main". Após execução, o resultado
		--esperado é o imediato "-32" em 32 bits.
		inst <= x"FE5290E3";
		wait for 4 ps;
			
		--Instrução Tipo-J
		--O valor hexadecimal 0x00C000EF representa a instrução "jal rot". Após execução, o resultado
		--esperado é o imediato "0xC/12" em 32 bits.
		inst <= x"00C000EF";
		wait for 4 ps;
		
		--Instrução Inexistente
		--O valor hexadecimal 0x00C000EF representa uma instrução inexistente. Após execução, o resultado
		--esperado é o valor "Z" em 32 bits. 
		--Esse caso 
		inst <= x"00C000FF";
		wait for 4 ps;
			
	--Fim do processemaneto e a definição dos testes.	
	end process init;
--Fim da arquitetura da entidade gemImm32_tb
end genImm32_tb;