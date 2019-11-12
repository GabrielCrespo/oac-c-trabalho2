--		Organização e Arquitetura de Computadores - Turma C - 2019/2	
--				Trabalho 2 - ULA e GERADOR DE IMEDIATOS RISC-V
--
--Nome:											Matrícula: 
--Nome: Gabriel Crespo de Souza			Matrícula: 14/0139982
--Nome: Wellington da Silva Stanley 	Matrícula: 11/0143981

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

--Esse bloco é usado para definir a entidade genImm32. Ou seja, especifica-se suas características, como entradas 
--e saídas que serão parte do hardware que a representa e seus respectivos tamanhos. Nesse caso, há a definição
--de uma constante DATA_WIDTH de valor 32. Na definição do nosso gerador de imediatos, há uma entrada e
--uma saída. A entrada é uma instrução, identificada pelo nome "inst" e de tamanho de DATA_WIDTH, ou seja, "inst"
--é um vetor lógico de 32 bits. A saída é um imediato, identificado pelo nome "imm32" e de tamanho de DATA_WIDTH, 
--ou seja, "imm32" é um vetor lógico de 32 bits.
entity genImm32 is
		--Constante de tamanho 32.
		generic (DATA_WIDTH : natural := 32);
		port (
				--A entrada "inst" é um vetor lógico de tamanho 32 bits
				inst 	: in std_logic_vector(DATA_WIDTH-1 downto 0);
				--A saída "imm32" é um vetor lógico de tamanho 32 bits
				imm32 : out std_logic_vector(DATA_WIDTH-1 downto 0)		
		);
end entity genImm32;

--Esse bloco é associado à entidade genImm32 e utilizado para descrever o comportamento e o fluxo de dados interno 
--da entidade genImm32. Ou seja, como deve ser realizada a geração de imediatos a depender da instrução recebida
--como entrada.
architecture genImm32 of genImm32 is

--"op" é um vetor lógico de tamanho 7, ou seja, uma palavra de 7 bits. A responsabilidade dessa variável é
--guardar os 7 bits menos significativos da instrução recebida como entrada(inst), pois esses bits identificam
--qual o tipo da instrução devemos lidar para gerar seu respectivo imediato, caso seja necessário. 
signal op: std_logic_vector(6 downto 0);

begin
	--O gerador de imediatos genImm32 deverá processar 2 entradas.
	process(op, inst)
	begin	
	--"op" recebe os 7 bits menos significativos da instrução(inst) recebida como entrada, para que possamos
	--descobrir para qual instrução devemos gerar o imediato.
	op <= inst(6 downto 0);
		
		--Ínicio do bloco que verifica as opções para os tipos de intruções possíveis do RISC-V
		--com o objetivo de gerar seu respectivo imediato.
		case op is 
	
			--Verifica se o valor de "op" é 0x03, caso seja, estamos tratando uma instrução Tipo-I.
			--Depois verifica se o bit mais significativo da instrução é igual a "1" ou igual a "0".
			--Caso seja igual a "1", então a saída imm32 recebe vinte 1's seguidos, simulando a extensão de sinal, 
			--concatenados com os 12 bits mais significativos da instrução.
			--Caso contrário, então a saída imm32 recebe vinte 0's seguidos, simulando a extensão de sinal, 
			--concatenados com os 12 bits mais significativos da instrução.
			when "0000011" =>
				if(inst(31) = '1') then				
					imm32 <= x"FFFFF" & inst(31 downto 20);
				elsif(inst(31) = '0') then
					imm32 <= x"00000" & inst(31 downto 20);
				end if;
			
			--Verifica se o valor de "op" é 0x13, caso seja, estamos tratando uma instrução Tipo-I.
			--Depois verifica se o bit mais significativo da instrução é igual a "1" ou igual a "0".
			--Caso seja igual a "1", então a saída imm32 recebe vinte 1's seguidos, simulando a extensão de sinal, 
			--concatenados com os 12 bits mais significativos da instrução.
			--Caso contrário, então a saída imm32 recebe vinte 0's seguidos, simulando a extensão de sinal, 
			--concatenados com os 12 bits mais significativos da instrução.
			when "0010011" =>
				if(inst(31) = '1') then
					imm32 <= x"FFFFF" & inst(31 downto 20);
				elsif(inst(31) = '0') then
					imm32 <= x"00000" & inst(31 downto 20);
				end if;
				
			--Verifica se o valor de "op" é 0x67, caso seja, estamos tratando uma instrução Tipo-I.
			--Depois verifica se o bit mais significativo da instrução é igual a "1" ou igual a "0".
			--Caso seja igual a "1", então a saída imm32 recebe vinte 1's seguidos, simulando a extensão de sinal, 
			--concatenados com os 12 bits mais significativos da instrução.
			--Caso contrário, então a saída imm32 recebe vinte 0's seguidos, simulando a extensão de sinal, 
			--concatenados com os 12 bits mais significativos da instrução.
			when "1100111" =>
				if(inst(31) = '1') then
					imm32 <= x"FFFFF" & inst(31 downto 20);
				elsif(inst(31) = '0') then
					imm32 <= x"00000" & inst(31 downto 20);
				end if;
				
			--Verifica se o valor de "op" é 0x23, caso seja, estamos tratando uma instrução Tipo-S.
			--Depois verifica se o bit mais significativo da instrução é igual a "1" ou igual a "0".
			--Caso seja igual a "1", então a saída imm32 recebe vinte 1's seguidos, simulando a extensão de sinal, 
			--concatenados com os 6 bits mais significativos e com os bits de 11 a 7 da instrução.
			--Caso contrário, então a saída imm32 recebe vinte 0's seguidos, simulando a extensão de sinal, 
			--concatenados com os 6 bits mais significativos e com os bits de 11 a 7 da instrução.
			when "0100011" =>
				if(inst(31) = '1') then
					imm32 <= x"FFFFF" & inst(31 downto 25) & inst(11 downto 7);
				elsif(inst(31) = '0') then
					imm32 <= x"00000" & inst(31 downto 25) & inst(11 downto 7);
				end if;
			
			--Verifica se o valor de "op" é 0x63, caso seja, estamos tratando uma instrução Tipo-B.
			--Depois verifica se o bit mais significativo da instrução é igual a "1" ou igual a "0".
			--Caso seja igual a "1", então a saída imm32 recebe vinte 1's seguidos, simulando a extensão de sinal, 
			--concatenados com o bit 7, com os bits da posição 30 a 25, com os bits de 11 a 8 da instrução.
			--e com o valor '0', pois imediatos do tipo B são sempre múltiplos de 2.
			when "1100011" =>
				if(inst(31) = '1') then
					imm32 <= x"FFFFF" & inst(7) & inst(30 downto 25) & inst(11 downto 8) & '0';
				elsif(inst(31) = '0') then
					imm32 <= x"00000" & inst(7) & inst(30 downto 25) & inst(11 downto 8) & '0';
				end if;
					
			--Verifica se o valor de "op" é 0x17, caso seja, estamos tratando uma instrução Tipo-U.
			--Nesse tipo de instrução, não há a extensão de sinal, visto que o imediato já corresponde
			--ao 20 bits mais significativos da instrução. Portanto, a saída imm32 recebe os 20 bits mais
			--significativos da instrução concatenados com 12 0's seguidos para completarmos o 32 bits.
			when "0010111" =>
				imm32 <= inst(31 downto 12) & x"000";
					
			--Verifica se o valor de "op" é 0x37, caso seja, estamos tratando uma instrução Tipo-U.
			--Nesse tipo de instrução, não há a extensão de sinal, visto que o imediato já corresponde
			--ao 20 bits mais significativos da instrução. Portanto, a saída imm32 recebe os 20 bits mais
			--significativos da instrução concatenados com 12 0's seguidos para completarmos o 32 bits.
			when "0110111" =>
				imm32 <= inst(31 downto 12) & x"000";
					
			--Verifica se o valor de "op" é 0x6F, caso seja, estamos tratando uma instrução Tipo-J.
			--Depois verifica se o bit mais significativo da instrução é igual a "1" ou igual a "0".
			--Caso seja igual a "1", então a saída imm32 recebe doze 1's seguidos, simulando a extensão de sinal, 
			--concatenados com os bits da posição 19 a 12, com os bit 20, com os bits da posição 31 a 21 da instrução
			--e com o valor '0', pois imediatos do tipo J são sempre múltiplos de 2.
			when "1101111" =>
				if(inst(31) = '1') then
					imm32 <= x"FFF" & inst(19 downto 12) & inst(20) & inst(30 downto 21) & '0';
				elsif(inst(31) = '0') then
					imm32 <= x"000" & inst(19 downto 12) & inst(20) & inst(30 downto 21) & '0';
				end if;	
				
			--Verifica se o valor de "op" é 0x33, caso seja, estamos tratando uma instrução Tipo-R.
			--Instruções Tipo-R não tem imediato, por isso, quando uma instrução é desse tipo,
			--então a saída imm32 recebe o valor '0' representado em 32 bits.
			when "0110011" =>
				imm32 <= x"00000000";
			
			--Qualquer outro caso de instrução diferente das especificadas acima, a saída imm32 recebe
			--uma palavra de 32 bits com um valor não identificado. Só para fins de especificação da não
			--existência de tal instrução.
			when others =>
				imm32 <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
				
		--Fim das especificações dos casos.
		end case;
	--Fim do processamento. 
	end process;
--Fim da especificação da arquitetura de genImm32.
end genImm32;
			