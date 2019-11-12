--		Organização e Arquitetura de Computadores - Turma C - 2019/2	
--				Trabalho 2 - ULA e GERADOR DE IMEDIATOS RISC-V
--
--Nome:											Matrícula: 
--Nome: Gabriel Crespo de Souza			Matrícula: 14/0139982
--Nome: Wellington da Silva Stanley 	Matrícula: 11/0143981

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Esse bloco é usado para definir a entidade ULA_tb. Só que não há necessidade de se especificar as
--características da mesma, pois já há essa especificação no arquivo ULA.vhd.	
entity ULA_tb is
end ULA_tb;		

--Esse bloco é associado à entidade genImm32_tb e utilizado para descrever o comportamento da entidade
--ULA_tb
architecture ULA_tb of ULA_tb is
--As variáveis A, B e result definidas abaixo são vetores lógicos de tamanho 32, ou seja,
--são palavras de 32 bits. Já a variável op é um vetor lógico de tamanho 4, ou seja, é uma palavra
--de 4 bits
signal A: std_logic_vector(31 downto 0);
signal B: std_logic_vector(31 downto 0);
signal result: std_logic_vector(31 downto 0);
signal op: std_logic_vector(3 downto 0);

--O componente "ULA" de 32 bits é definido aqui, definindo suas portas de entrada
--e de saída. As entradas "A, B" recebem uma palavra de 32 bits que representam os operandos. A saída 
--"result" também recebe uma palavra de 32 bits que representa o resultado da operação realizada entre "A, B".
--E a entrada "op" recebe uma palavra de 4 bits que define a operação a ser realizada.
component ULA
	port (
	
		A, B: in std_logic_vector(31 downto 0);
		op: in std_logic_vector(3 downto 0);
		result: out std_logic_vector(31 downto 0)
	
	);
end component;
begin
--i1 é uma instância do componente ULA. Dentro dessa instância, estamos mapeando as variáveis
--do tipo signal para as portas de entrada e saída, respectivamente.
	i1: ULA
	port map(
		--mapeamento das variáveis para as portas da instância i1.
		A => A,
		B => B,
		op => op,
		result => result
	
	);

--Nesse bloco, inicia-se a especificação dos casos de teste a serem processados para a verificação do 
--funcionamento correto da unidade lógica e aritmética. A execução por completo deve demorar 56 picosegundos,
--pois são 15 instruções que levam 4 picosegundos para serem executadas de maneira individual.	
init: process
begin 
		--Nesse caso estamos realizando a operação de "+", representado pelo código "op = 0000".
		--Os operandos A e B são valores inteiros e positivos, tais que "A=15" e "B=5". O resultado
		--esperado em result é o inteiro 20.
		A <= x"0000000F"; B <= x"00000005"; op <= x"0";
		wait for 4 ps;
		
		--Nesse caso estamos realizando a operação de "-", representado pelo código "op = 0001".
		--Os operandos A e B são valores inteiros e positivos, tais que "A=15" e "B=10". O resultado
		--esperado em result é o inteiro 5.
		A <= x"0000000F"; B <= x"0000000A"; op <= x"1";
		wait for 4 ps;
		
		--Nesse caso estamos realizando a operação "SLL" , representado pelo código "op = 0010".
		--Os operandos A e B são valores inteiros e positivos, tais que "A=15" e "B=2". O resultado
		--esperado em result é o inteiro 60, que representa o valor 15 em binário, deslocado de 2 bits à esquerda.
		--Ou simplesmente o valor 15 multiplicado por 4.
		A <= x"0000000F"; B <= x"00000002"; op <= x"2";
		wait for 4 ps;
		
		--Nesse caso estamos realizando a operação "SLT" , representado pelo código "op = 0011".
		--Os operandos A e B são valores inteiros e positivos, tais que "A=-2" e "B=15". O resultado
		--esperado em result é o inteiro 1, pois o instrução verifica se "A < B" e "-2 < 15" é verdadeiro.
		A <= x"FFFFFFFE"; B <= x"0000000F"; op <= x"3";
		wait for 4 ps;
		
		--Nesse caso estamos realizando a operação "SLT" , representado pelo código "op = 0011".
		--Os operandos A e B são valores inteiros e positivos, tais que "A=16" e "B=-4". O resultado
		--esperado em result é o inteiro 0, pois o instrução verifica se "A < B" e "31 < -4" é falso.
		A <= x"0000001F"; B <= x"FFFFFFFC"; op <= x"3";
		wait for 4 ps;
		
		
		--Set Less Than Unsigned
		A <= x"00000002"; B <= x"0000000F"; op <= x"4";
		wait for 4 ps;
		
		--XOR
		A <= x"000A03B6"; B <= x"0001DFF2"; op <= x"5";
		wait for 4 ps;
		
		--Shift Right Logical
		A <= x"0000000F"; B <= x"00000002"; op <= x"6";
		wait for 4 ps;
		
		--Shift Right Aritmethical 
		A <= x"0000000F"; B <= x"00000002"; op <= x"7";
		wait for 4 ps;
		
		--OR
		A <= x"000A03B6"; B <= x"0001DFF2"; op <= x"8";
		wait for 4 ps;
		
		--AND
		A <= x"000A03B6"; B <= x"0001DFF2"; op <= x"9";
		wait for 4 ps;
		
		--SEQ
		A <= x"0000000F"; B <= x"0000000F"; op <= x"A";
		wait for 4 ps;
		
		--SNE
		A <= x"0000000F"; B <= x"00000002"; op <= x"B";
		wait for 4 ps;
			
		--SGE
		A <= x"0000000F"; B <= x"00000002"; op <= x"C";
		wait for 4 ps;
		
		--SGEU
		A <= x"0000000F"; B <= x"00000002"; op <= x"D";
		wait for 4 ps;	
		
	--Fim do processemaneto e a definição dos testes.	
	end process init;
--Fim da arquitetura da entidade ULA_tb
end ULA_tb;