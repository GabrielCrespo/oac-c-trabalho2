--		Organização e Arquitetura de Computadores - Turma C - 2019/2	
--				Trabalho 2 - ULA e GERADOR DE IMEDIATOS RISC-V
--
--Nome:											Matrícula: 
--Nome: Gabriel Crespo de Souza			Matrícula: 14/0139982
--Nome: Wellington da Silva Stanley 	Matrícula: 11/0143981

--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


--Esse bloco é usado para definir a entidade ULA. Ou seja, especifica-se suas características, como entradas e saídas
--que serão parte do hardware que a representa e seus respectivos tamanhos. Nesse caso, a ULA definida abaixo recebe
--três entradas(A, B e op) e uma saída(result). As entradas "A", "B" representam os valores a serem operados
--pela ULA, a entrada "op" representa qual operação a ULA deve executar sobre os operandos A, B. A saída "result"
--representa o valor resultante da operação op sobre os valores A, B.
entity ULA is
--DATA_WIDTH é uma constante natural de tamanho 32
		 generic (DATA_WIDTH : natural := 32);
		--A definição das portas de entrada e saída é feita abaixo:
		 port (
				--A e B são vetores lógicos com mesmo tamanho de DATA_WIDTH,
				--ou seja, A e B são palavras de 32 bits.
				A, B : in std_logic_vector(DATA_WIDTH -1 downto 0);
				--op é um vetor lógico de tamanho 4, ou seja, op é uma palavra de 4 bits.
				op : in std_logic_vector(3 downto 0);
				--result é um vetor lógico com mesmo tamanho de DATA_WIDTH,
				--ou seja, result é uma palavra de 32 bits
				result : out std_logic_vector(DATA_WIDTH -1 downto 0)
			 ); 
end entity ULA;

--Esse bloco é associado à entidade ULA é utilizado para descrever o comportamento e o fluxo de dados interno 
--da entidade ULA. Ou seja, quais operações a ULA deve realizar e como realiza-las.
architecture ULA of ULA is
begin
		--Esse comando indica que a ULA irá processar três valores de entrada.
		process(A, B, op)
		--Aqui inicia-se o processamento da ULA.
		begin	
			--Para que uma operação seja realizada pela ULA, 
			--antes é necessária a verificação do código da operação.
			case op is			
			
			--Quando a entrada "op" recebe o valor "0000", então a ULA deve realizar a operação de adição
			--entre as outras entradas A, B e o a saída result recebe o resultado dessa soma. A operação "+"
			--necessita que as entradas A, B sejam convertidas para o tipo signed e depois se converte o 
			--resultado para o tipo std_logic_vector, pois essa operação não é bem definida para esse tipo.
			when "0000" => 
				result <= std_logic_vector(signed(A) + signed(B));
			
			--Quando a entrada "op" recebe o valor "0001", então a ULA deve realizar a operação de subtração
			--entre as outras entradas A, B e o a saída result recebe o resultado dessa subtração. A operação "-"
			--necessita que as entradas A, B sejam convertidas para o tipo signed e depois se converte o 
			--resultado para o tipo std_logic_vector, pois essa operação não é bem definida para esse tipo.
			when "0001" =>
				result <= std_logic_vector(signed(A) - signed(B));
				
			--Quando a entrada "op" recebe o valor "0010", então a ULA deve realizar a operação de SLL
			--entre as outras entradas 'A", "B" e a saída "result" recebe o resultado desse deslocamento à esquerda.
			--A operação SLL realiza o deslocamento à esquerda sem a conservação do sinal, por isso a entrada "A",
			--que é a palavra a ser deslocada, é convertida para unsigned. a entrada "B", que é a quantidade de bits
			--em que a palavra "A" deve ser deslocada, é convertida para unsigned e para inteiro, pois esse deslocamento
			--é de "B" vezes, onde "B" é inteiro e positivo.
			when "0010" =>
				result <=  std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(B))));
				
			--Quando a entrada "op" recebe o valor "0011", então a ULA deve realizar a operação de SLT
			--entre as outras entradas "A", "B" e a saída "result" recebe o valor 1 caso a entrada "A" seja menor
			--que a entrada "B", caso contrário, a saída "result" recebe o valor 0. A operação SLT compara
			--dois valores sinalizados.
			when "0011" =>
				if(signed(A) < signed(B)) then
					result <= x"00000001";
				else
					result <= x"00000000";
				end if;
				
			--Quando a entrada "op" recebe o valor "0100", então a ULA deve realizar a operação de SLTU
			--entre as outras entradas "A", "B" e a saída "result" recebe o valor 1 caso a entrada "A" seja menor
			--que a entrada "B", caso contrário, a saída "result" recebe o valor 0. A operação SLTU compara
			--dois valores não sinalizados.
			when "0100" =>
				if(unsigned(A) < unsigned(B)) then
					result <= x"00000001";
				else
					result <= x"00000000";
				end if;
				
			--Quando a entrada "op" recebe o valor "0101", então a ULA deve realizar a operação de XOR
			--entre as outras entradas "A", "B" e a saída "result" recebe o resultado da operação lógica
			--bit a bit.
			when "0101" =>
				result <= A xor B;
				
			--Quando a entrada "op" recebe o valor "0110", então a ULA deve realizar a operação de SRL
			--entre as outras entradas "A", "B" e a saída "result" recebe o resultado desse deslocamento à direita.
			--A operação SRL realiza o deslocamento à direita sem a conservação do sinal, por isso a entrada "A",
			--que é a palavra a ser deslocada, é convertida para unsigned. A entrada "B", que é a quantidade de bits
			--em que a palavra "A" deve ser deslocada, é convertida para unsigned e para inteiro, pois esse deslocamento
			--é de "B" vezes, onde "B" é inteiro e positivo.
			when "0110" =>
				result <=  std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B))));
				
			--Quando a entrada "op" recebe o valor "0111", então a ULA deve realizar a operação de SRA
			--entre as outras entradas "A", "B" e a saída "result" recebe o resultado desse deslocamento à direita.
			--A operação SRA realiza o deslocamento à direita com a conservação do sinal, por isso a entrada "A",
			--que é a palavra a ser deslocada, é convertida para signed. A entrada "B", que é a quantidade de bits
			--em que a palavra "A" deve ser deslocada, é convertida para unsigned e para inteiro, pois esse deslocamento
			--é de "B" vezes, onde "B" é inteiro e positivo.
			when "0111" =>
				result <=  std_logic_vector(shift_right(signed(A), to_integer(unsigned(B))));
				
			--Quando a entrada "op" recebe o valor "1000", então a ULA deve realizar a operação de OR
			--entre as outras entradas "A", "B" e a saída "result" recebe o resultado da operação lógica
			--bit a bit.
			when "1000" =>
				result <= A or B;
				
			--Quando a entrada "op" recebe o valor "1001", então a ULA deve realizar a operação de AND
			--entre as outras entradas "A", "B" e a saída "result" recebe o resultado da operação lógica
			--bit a bit.
			when "1001" =>
				result <= A and B;
				
			--Quando a entrada "op" recebe o valor "1010", então a ULA deve realizar a operação de SEQ
			--entre as outras entradas "A", "B" e a saída "result" recebe o valor 1 caso a entrada "A" seja igual
			--a entrada "B", caso contrário, a saída "result" recebe o valor 0. A operação SEQ compara
			--dois valores sinalizados.
			when "1010" =>		
				if(signed(A) = signed(B)) then
					result <= x"00000001";
				else
					result <= x"00000000";
				end if;
			
			--Quando a entrada "op" recebe o valor "1011", então a ULA deve realizar a operação de SNE
			--entre as outras entradas "A", "B" e a saída "result" recebe o valor 1 caso a entrada "A" seja
			--diferente da entrada "B", caso contrário, a saída "result" recebe o valor 0. A operação SNE compara
			--dois valores sinalizados.
			when "1011" =>		
				if(signed(A) /= signed(B)) then
					result <= x"00000001";
				else
					result <= x"00000000";
				end if;
				
			--Quando a entrada "op" recebe o valor "1100", então a ULA deve realizar a operação de SGE
			--entre as outras entradas "A", "B" e a saída "result" recebe o valor 1 caso a entrada "A" seja
			--maior ou igual a entrada "B", caso contrário, a saída "result" recebe o valor 0. A operação SGE compara
			--dois valores sinalizados.
			when "1100" =>		
				if(signed(A) >=signed(B)) then
					result <= x"00000001";
				else
					result <= x"00000000";
				end if;
				
			--Quando a entrada "op" recebe o valor "1100", então a ULA deve realizar a operação de SGEU
			--entre as outras entradas "A", "B" e a saída "result" recebe o valor 1 caso a entrada "A" seja
			--maior ou igual a entrada "B", caso contrário, a saída "result" recebe o valor 0. A operação SGEU compara
			--dois valores não sinalizados.
			when "1101" =>		
				if(unsigned(A) >= unsigned(B)) then
					result <= x"00000001";
				else
					result <= x"00000000";
				end if;
			--Qualquer outro valor que a entrada "op" receba, diferente das especificadas acima
			--então a saída abaixo é a padrão.
			when others =>
				result <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
		--Fim da especificação dos casos.
		end case;
	--Fim do processamento das entradas.
	end process;
--Fim da especificação da arquitetura da entidade ULA.	
end ULA;