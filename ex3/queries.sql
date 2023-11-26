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


/*
 * (i) Obter o(s) nome(s) do(s) cliente(s) que realizaram reservas numa loja gerida por uma pessoa chamada “João”.
 * 
 * renomear a tabela pessoa para pessoa_cliente
 * juntar as tabelas: pessoa, clientereserva, reserva e loja
 * desta forma, obtemos uma tabela com a informação das reservas de cada cliente
 * fazer o filtro de gestores chamados joao e obter os ids das lojas que gerem 
 * fazer o join destas duas para obter os clientes que fizeram reservas nessas lojas
 * mostrar apenas o nome do cliente
*/
 
SELECT DISTINCT pessoa_cliente.nome
FROM pessoa AS pessoa_cliente
JOIN clientereserva ON pessoa_cliente.id = clientereserva.cliente
JOIN reserva ON clientereserva.reserva = reserva.noreserva AND clientereserva.loja = reserva.loja
JOIN loja ON reserva.loja = loja.codigo
JOIN pessoa AS pessoa_gestor ON loja.gestor = pessoa_gestor.id
WHERE pessoa_gestor.nome LIKE '%João%';

/*
 * (j) Crie uma vista LISTAJOAOFILIPE que inclui informação sobre os clientes que efectuaram reservas num loja gerida pelo “João Filipe”. (Nota: O João Filipe é, ele também cliente).
 * 
 *  funcionamento igual á alinea (i), sendo que o select será de todos os atributos da pessoa e o gestor é "João Filipe"
 */

CREATE VIEW LISTAJOAOFILIPE AS
SELECT DISTINCT pessoa_cliente.nome, pessoa_cliente.morada, pessoa_cliente.email, pessoa_cliente.telefone, pessoa_cliente.noident, pessoa_cliente.nacionalidade, pessoa_cliente.atrdisc
FROM pessoa AS pessoa_cliente
JOIN clientereserva ON pessoa_cliente.id = clientereserva.cliente
JOIN reserva ON clientereserva.reserva = reserva.noreserva AND clientereserva.loja = reserva.loja
JOIN loja ON reserva.loja = loja.codigo
JOIN pessoa AS pessoa_gestor ON loja.gestor = pessoa_gestor.id
WHERE pessoa_gestor.nome = 'João Filipe';

SELECT * FROM LISTAJOAOFILIPE; -- visualisar a vista criada


/*
* (k) Crie uma vista BICICLETASEMNUMEROS que inclui informação sobre as bicicletas e o seu número. A informação disponível deverá ser, o tipo de bicicleta (elétrica e clássica), o seu estado (“em manutenção” e “outras”2) e o número total.
*
*	separar em dois dominios tipo e status com o case
*	fazer a contagem das bicicletas e colocar em total
*	agrupar por tipo e status
*
*/

create view BICICLETASEMNUMEROS as
SELECT
  CASE
    WHEN atrdisc = 'E' THEN 'elétrica'
    WHEN atrdisc = 'C' THEN 'clássica'
  END AS tipo,
  CASE
    WHEN estado = 'em manutenção' THEN 'em manutenção'
    ELSE 'outras'
  END AS status,		-- colocamos o nome status porque se fosse estado o groupby iria separar pelos estados todos das bicicletas
  COUNT(*) AS total
FROM bicicleta
GROUP BY tipo, status;

SELECT * from BICICLETASEMNUMEROS;  -- visualisar a vista criada



