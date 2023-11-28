/* 
*
* Conceba, na linguagem PostgreSQL, as interrogações que produzam os resultados a seguir indicados, utilizando apenas uma instrução PostgreSQL. 
* Guarde todas num script autónomo de nome “queries.sql”. 
* Para cada instrução deve ser também apresentada, em comentário, a descrição do raciocínio seguido. 
*
*/


/*
*
* (a) Implemente em PostgreSQL as interrogações pedidas na alínea 2 
* (Pode escolher uma das soluções que apresentou acima, desde que nesta fase consiga fazer uso de todos os operadores).
*
*/

-- 2(a) Pretende-se obter informação (nome, morada e telefone) dos clientes e dos gestores
select nome, morada, telefone
from pessoa
where atrdisc = 'G' or atrdisc = 'C';



-- 2(b) Liste, agora, informação (nome, morada e telefone) sobre os clientes que também são gestores.
select distinct nome, morada, telefone
from pessoa, clientereserva
where pessoa.atrdisc = 'G'
and pessoa.id = clientereserva.cliente;



-- 2(c) Pretende-se saber que pessoas (nome, morada e telefone) não estão associadas a nenhuma reserva.
select distinct pessoa.nome, pessoa.morada, pessoa.telefone
from pessoa
left join clientereserva on pessoa.id = clientereserva.cliente
left join reserva on clientereserva.cliente = reserva.noreserva
where reserva.noreserva is null;



-- 2(d)  Apresente a lista de bicicletas (marca, modelo e estado) que não estão associadas a nenhuma reserva e não são eléctricas.
select marca, modelo, estado
from bicicleta
where bicicleta.atrdisc = 'C'
and bicicleta.estado <> 'ocupado';



-- 2 (e) O conjunto de dispositivos (noserie, latitude e longitude) de bicicletas cujo estado encontra-se em “em manutencao”.
select distinct noserie, latitude, longitude
from dispositivo  
join bicicleta on bicicleta.id = dispositivo.noserie
where bicicleta.estado = 'em manutenção';
     


-- 2 (f) O nome dos clientes que realizaram reservas com bicicletas electricas. Apresente informacao sobre os clientes e o numero de reservas.
select pessoa.nome, count(clientereserva.reserva) as numero_reservas
from pessoa
join clientereserva on pessoa.id = clientereserva.cliente
join reserva on clientereserva.reserva = reserva.noreserva and clientereserva.loja = reserva.loja
join bicicleta on reserva.bicicleta = bicicleta.id
where bicicleta.atrdisc = 'E'
group by pessoa.nome;



-- 2(g) Pretende-se obter a lista de clientes que efectuaram reservas com um valor total superior a e 100 (e.g.).
select distinct pessoa.nome
from pessoa
join clientereserva on pessoa.id = clientereserva.cliente
join reserva on clientereserva.reserva = reserva.noreserva and clientereserva.loja = reserva.loja 
where reserva.valor > 100;



-- 2(h) Liste informacoes (email, endereco e localidade) sobre lojas e respectivos numeros de telefone associados, incluindo lojas que podem nao ter um numero de telefone associado.
select loja.email, loja.endereco, loja.localidade, telefoneloja.numero
from loja
left join telefoneloja on loja.codigo = telefoneloja.loja;



-- 2(i) Para o cliente de nome “José Manuel”, pretende-se a lista de reservas (noreserva e loja) que efectuou, nomeadamente a sua data e as horas de inıcio e de fim, e o preço ofinal desta.
select distinct reserva.noreserva, reserva.loja, reserva.dtinicio, reserva.dtfim, reserva.valor
from pessoa 
join clientereserva on pessoa.id = clientereserva.cliente
join reserva on clientereserva.reserva = reserva.noreserva and clientereserva.loja = reserva.loja
join loja on reserva.loja = loja.codigo
where pessoa.nome = 'José Manuel';



-- 2(j) Apresente a lista do(s) cliente(s) (nome, morada, telefone e nacionalidade), com mais reservas no ano de 2023.
select pessoa.nome, pessoa.morada, pessoa.telefone, pessoa.nacionalidade, count(*) as nmr_reservas
from pessoa
join clientereserva on pessoa.id = clientereserva.cliente
join reserva on clientereserva.reserva = reserva.noreserva and clientereserva.loja = reserva.loja
where extract(year from reserva.dtinicio) = 2023
group by pessoa.id
having count(*) = (
  select max(nmr_reservas)
  from (
    select count(*) as nmr_reservas
    from clientereserva
    join reserva on clientereserva.reserva = reserva.noreserva and clientereserva.loja = reserva.loja
    where extract(year from reserva.dtinicio) = 2023
    group by clientereserva.cliente
  ) as subquery
);



-- 2 (k) Apresente o número de clientes de nacionalidade portuguesa e outros. O resultado deve mostrar os atributos nacionalidade e o número de clientes.
select pessoa.nacionalidade , count(*) as total
from pessoa
group by nacionalidade;
  
     

/*
*
* (b) Obtenha os nomes de todos os clientes que fizeram pelo menos uma reserva numa loja localizada em Lisboa.
*
* seleciona atributos da tabela pessoa, clientereserva, reserva e conta o numero de reservas
* acrescenta a condição de forma a que seja filtrado pelo nome do cliente com reservas em lisboa
* faz a contagem das reservas maiores ou iguais a 1
* agrupa os resultados pelo nome
*
*/
select distinct nome
from pessoa, clientereserva, reserva, loja
where pessoa.id = clientereserva.cliente
and clientereserva.loja = reserva.loja
and loja.localidade = 'Lisboa'
group by pessoa.nome
having count(*) >=  1;

    
    
/*
*
* (c) Encontre os números de série dos dispositivos com uma percentagem de bateria superior a 50%, e liste-os por ordem crescente da sua percentagem de bateria.
* Seleciona a coluna noserie da tabela dispositivo
* seleciona os tupulos onde a bateria é maior que 50%
* ordena as percentagens da bateria em ordem crescente
*
*/
select noserie, bateria
from dispositivo
where bateria > 50
order by bateria;



/* 
* 
* (d) Apresente a marca e o modelo da bicicleta com maior autonomia dentro das bicicletas disponíveis.
* Seleciona a coluna marca e modelo das tabelas bicicleta e eletrica
* seleciona os tupulos onde existem bicicletas com coluna autonomia
* ordena as as autonomias em ordem decrescente de forma a que a commaior autonomia fique no primeiro tupulo
* limita a visualisação dos resultados apenas ao primeiro tupulo
*
*/
select marca, modelo
from bicicleta
join eletrica on bicicleta.id = eletrica.bicicleta
where eletrica.autonomia =(
    select max(autonomia)
    from eletrica);



/*
*
* (e) Obter o número total de reservas para cada loja, bem como o seu código e o número total de reservas.
*
*/
select codigo, count(*) as treservas
from loja
join reserva on loja.codigo = reserva.loja
group by loja.codigo;



/*
*
* (f) Liste todas as lojas (codigo e email) que tenham efectuado mais de 5 reservas, até á presente data, e enumere-as por ordem decrescente do número de reservas 
* (Nota: Faça uso dos operadores/funções de data e tempo).
*
* seleciona atributos da tabela loja e conta numero de reservas
* considera a tabela reserva para reservas feitas numa dada loja
* filtra as reservas até ao dia de hoje
* agrupa os resultados pelo codigo e email da loja
* inclui apenas lojas com mais de 5 reservas
*
*/
select codigo, email, count(*) as nreservas
from loja
join reserva on loja.codigo = reserva.loja
where reserva.dtinicio <= current_date
group by loja.codigo, loja.email
having count(*) > 5
order by nreservas desc; 



/*
*
* (g) Apresente os nomes dos clientes que efectuaram reservas de bicicletas cujo estado tem como valor “em manutencao” no ano passado 
* (Nota: Faça uso dos operadores/funções de data e tempo).
*   
* selecciona nome de pessoa
* das pessoas que fizeram reservas
* das bicicletas que foram reservadas
* onde se apenas consideram clientes e bicicletas em manutenção relativas ao ano passado
*
*/
select distinct nome
from pessoa, clientereserva, reserva, bicicleta
where pessoa.id = clientereserva.cliente
and clientereserva.reserva = reserva.noreserva
and reserva.bicicleta = bicicleta.id
and bicicleta.estado = 'em manutenção'
and extract(year from reserva.dtinicio) = extract(year from current_date) - 1;



/* 
*
* (h) Listar as informações (nome, morada, telefone) das pessoas que geriram uma loja e efectuaram reservas.
* 
* seleccionar nome, morada, telefone da tabela pessoa
* seleccionar apenas os clientes que fizeram reservas
* seleccionar apenas os gestores
*
*/
select distinct nome, morada, telefone 
from pessoa, clientereserva, loja
where pessoa.id = clientereserva.cliente and loja.gestor = pessoa.id;



/*
*
* (i) Obter o(s) nome(s) do(s) cliente(s) que realizaram reservas numa loja gerida por uma pessoa chamada “João”.
* 
* renomear a tabela pessoa para pessoa_cliente
* juntar as tabelas: pessoa, clientereserva, reserva e loja
* desta forma, obtemos uma tabela com a informação das reservas de cada cliente
* fazer o filtro de gestores chamados joao e obter os ids das lojas que gerem 
* fazer o join destas duas para obter os clientes que fizeram reservas nessas lojas
* mostrar apenas o nome do cliente
*
*/
select distinct pessoa_cliente.nome
from pessoa as pessoa_cliente
join clientereserva on pessoa_cliente.id = clientereserva.cliente
join reserva on clientereserva.reserva = reserva.noreserva and clientereserva.loja = reserva.loja
join loja on reserva.loja = loja.codigo
join pessoa as pessoa_gestor on loja.gestor = pessoa_gestor.id
where pessoa_gestor.nome like '%João%';



/*
*
* (j) Crie uma vista LISTAJOAOFILIPE que inclui informação sobre os clientes que efectuaram reservas num loja gerida pelo “João Filipe”. 
* (Nota: O João Filipe é, ele também cliente).
* 
*  funcionamento igual á alinea (i), sendo que o select será de todos os atributos da pessoa e o gestor é "João Filipe"
*
*/
create view LISTAJOAOFILIPE as
select distinct pessoa_cliente.nome, pessoa_cliente.morada, pessoa_cliente.email, pessoa_cliente.telefone, pessoa_cliente.noident, pessoa_cliente.nacionalidade, pessoa_cliente.atrdisc
from pessoa as pessoa_cliente
join clientereserva on pessoa_cliente.id = clientereserva.cliente
join reserva on clientereserva.reserva = reserva.noreserva and clientereserva.loja = reserva.loja
join loja on reserva.loja = loja.codigo
join pessoa as pessoa_gestor on loja.gestor = pessoa_gestor.id
where pessoa_gestor.nome = 'João Filipe';


select * from LISTAJOAOFILIPE; -- visualisar a vista criada


/*
*
* (k) Crie uma vista BICICLETasEMNUMEROS que inclui informação sobre as bicicletas e o seu número. 
* A informação disponível deverá ser, o tipo de bicicleta (elétrica e clássica), o seu estado (“em manutenção” e “outras”2) e o número total.
*
*	separar em dois dominios tipo e status com o case
*	fazer a contagem das bicicletas e colocar em total
*	agrupar por tipo e status
*
*/
create view BICICLETASEMNUMEROS as
select
  case
    when atrdisc = 'E' then 'elétrica'
    when atrdisc = 'C' then 'clássica'
  end as tipo,
  case
    when estado = 'em manutenção' then 'em manutenção'
    else 'outras'
  end as status,		-- colocamos o nome status porque se fosse estado o groupby iria separar pelos estados todos das bicicletas
  count(*) as total
from bicicleta
group by tipo, status;


select * from BICICLETASEMNUMEROS;  -- visualisar a vista criada
