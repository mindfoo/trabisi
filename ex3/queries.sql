/* Conceba, na linguagem PostgreSQL, as interrogações que produzam os resultados a seguir indicados, utilizando apenas uma instrução PostgreSQL. 
Guarde todas num script autónomo de nome “queries.sql”. 
Para cada instrução deve ser também apresentada, em comentário, a descrição do raciocínio seguido. */


-- (a) Implemente em PostgreSQL as interrogações pedidas na alínea 2 (Pode escolher uma das soluções que apresentou acima, desde que nesta fase consiga fazer uso de todos os operadores).

-- (b) Obtenha os nomes de todos os clientes que fizeram pelo menos uma reserva numa loja localizada em Lisboa.

-- (c) Encontre os núumeros de série dos dispositivos com uma percentagem de bateria superior a 50%, e liste-os por ordem crescente da sua percentagem de bateria.

-- (d) Apresente a marca e o modelo da bicicleta com maior autonomia dentro das bicicletas disponíveis.

-- (e) Obter o número total de reservas para cada loja, bem como o seu código e o número total de reservas.

-- (f)Liste todas as lojas (codigo e email) que tenham efectuado mais de 5 reservas, até á presente data, e enumere-as por ordem decrescente do número de reservas (Nota: Faça uso dos operadores/funções de data e tempo).

-- (g) Apresente os nomes dos clientes que efectuaram reservas de bicicletas cujo estado tem como valor “em manutencao” no ano passado (Nota: Faça uso dos operadores/funções de data e tempo).

-- (h) Listar as informações (nome, morada, telefone) das pessoas que geriram uma loja e efectuaram reservas.

-- (i) Obter o(s) nome(s) do(s) cliente(s) que realizaram reservas numa loja gerida por uma pessoa chamada “João”.

-- (j) Crie uma vista LISTAJOAOFILIPE que inclui informação sobre os clientes que efectuaram reservas num loja gerida pelo “João Filipe”. (Nota: O João Filipe é, ele também cliente).

-- (k) Crie uma vista BICICLETASEMNUMEROS que inclui informação sobre as bicicletas e o seu número. A informação disponível deverá ser, o tipo de bicicleta (elétrica e clássica), o seu estado (“em manutenção” e “outras”2) e o número total.