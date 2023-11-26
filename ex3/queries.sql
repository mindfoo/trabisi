/* Conceba, na linguagem PostgreSQL, as interrogações que produzam os resultados a seguir indicados, utilizando apenas uma instrução PostgreSQL. 
Guarde todas num script autónomo de nome “queries.sql”. 
Para cada instrução deve ser também apresentada, em comentário, a descrição do raciocínio seguido. */


-- (a) Implemente em PostgreSQL as interrogações pedidas na alínea 2 (Pode escolher uma das soluções que apresentou acima, desde que nesta fase consiga fazer uso de todos os operadores).

-- (b) Obtenha os nomes de todos os clientes que fizeram pelo menos uma reserva numa loja localizada em Lisboa.

-- (c) Encontre os núumeros de série dos dispositivos com uma percentagem de bateria superior a 50%, e liste-os por ordem crescente da sua percentagem de bateria.

-- (d) Apresente a marca e o modelo da bicicleta com maior autonomia dentro das bicicletas disponíveis.

/*
      (a) Implemente em PostgreSQL as interrogações pedidas na alínea 2 (Pode escolher uma das soluções que apresentou acima, desde que nesta fase consiga fazer uso de todos os operadores).
*/
     

/*    (b) Obtenha os nomes de todos os clientes que fizeram pelo menos uma reserva numa loja localizada em Lisboa.

        seleciona atributos da tabela pessoa, clientereserva, reserva e conta o numero de reservas
        acrescenta a condição de forma a que seja filtrado pelo nome do cliente com reservas em lisboa
        faz a contagem das reservas maiores ou iguais a 1
        agrupa os resultados pelo nome
*/
    SELECT nome, COUNT(*) AS nreservas
    FROM pessoa, clientereserva, reserva
    WHERE pessoa.id = clientereserva.id
    AND clientereserva.id = reserva.noreserva
    AND reserva.noreserva = 'Lisboa'
    HAVING COUNT(*) >=  1
    GROUP BY pessoa.nome;
    
    
/*    (c) Encontre os números de série dos dispositivos com uma percentagem de bateria superior a 50%, e liste-os por ordem crescente da sua percentagem de bateria.
*/

    SELECT noserie
    FROM dispositivo
    WHERE bateria > 50
    ORDER BY bateria;

    
/*    (d) Apresente a marca e o modelo da bicicleta com maior autonomia dentro das bicicletas disponíveis.

*/

    /*
    *   (e) Obter o número total de reservas para cada loja, bem como o seu código e o número total de reservas.
    */

    SELECT codigo, COUNT(*) AS treservas
    FROM loja
    JOIN reserva ON loja.codigo = reserva.loja
    GROUP BY loja.codigo;


    /*
    *   (f) Liste todas as lojas (codigo e email) que tenham efectuado mais de 5 reservas, até á presente data, e enumere-as por ordem *    decrescente do número de reservas (Nota: Faça uso dos operadores/funções de data e tempo).
    
        seleciona atributos da tabela loja e conta numero de reservas
        considera a tabela reserva para reservas feitas numa dada loja
        filtra as reservas até ao dia de hoje
        agrupa os resultados pelo codigo e email da loja
        inclui apenas lojas com mais de 5 reservas
    */

    SELECT codigo, email, COUNT(*) AS nreservas
    FROM loja
    JOIN reserva ON loja.codigo = reserva.loja
    WHERE reserva.data <= CURRENT_DATE
    GROUP BY loja.codigo, loja.email
    HAVING COUNT(*) > 5
    ORDER BY nreservas DESC; 

    /*
    *   (g) Apresente os nomes dos clientes que efectuaram reservas de bicicletas cujo estado tem como valor “em manutencao” no ano *   *   passado (Nota: Faça uso dos operadores/funções de data e tempo).
    *   
    *   selecciona nome de pessoa
    *   das pessoas que fizeram reservas
    *   das bicicletas que foram reservadas
    *   onde se apenas consideram clientes e bicicletas em manutenção relativas ao ano passado
    */

    SELECT nome
    FROM pessoa, clientereserva, reserva, bicicleta
    WHERE pessoa.id = clientereserva.cliente
    AND clientereserva.reserva = reserva.id
    AND reserva.bicicleta = bicicleta.id
    AND bicicleta.estado = 'em manutenção'
    AND EXTRACT(YEAR FROM reserva.data) = EXTRACT(YEAR FROM CURRENT_DATE) - 1;


    /* 
    *   (h) Listar as informações (nome, morada, telefone) das pessoas que geriram uma loja e efectuaram reservas.
    *
    *   seleccionar nome, morada, telefone da tabela pessoa
    *   seleccionar apenas os clientes que fizeram reservas
    *   seleccionar apenas os gestores
    */

    SELECT nome, morada, telefone 
    FROM pessoa, clientereserva, loja
    WHERE pessoa.id = clientereserva.cliente AND loja.gestor = pessoa.id



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



