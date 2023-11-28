/*
 * Criação de tabelas e definição das restrições.
 * */
begin;
create table dispositivo( 
	noserie integer primary key,
	latitude numeric(6,4), 
    longitude numeric(6,4), 
    bateria integer constraint range_bat check (bateria >= 0 and bateria <= 100));
commit;

begin;
create table bicicleta(
	id serial primary key,
	peso numeric(4,2), /* ##,## */
    raio integer constraint range_raio check (raio >= 13 and raio <= 23), 
    modelo varchar(20), 
    marca varchar(30), 
    mudanca integer constraint range_mudanca check (mudanca in (1,6,18,24)), 
    estado varchar(30) constraint range_estado check (estado in ('livre', 'ocupado', 'em manutenção')), 
    atrdisc char(2) constraint range_disc check (atrdisc in ('C', 'E')), 
    dispositivo integer,
    foreign key (dispositivo) references dispositivo (noserie) on delete cascade);
commit;

begin;
create table classica(
	bicicleta integer primary key,
	nomudanca integer constraint range_nomudanca check (nomudanca >= 0 and nomudanca <= 5),
	foreign key (bicicleta) references bicicleta (id) on delete cascade);
commit;

begin;
create table eletrica( 
	bicicleta integer primary key,
	autonomia integer, 
    velocidade integer,
    foreign key (bicicleta) references bicicleta (id) on delete cascade);
commit;

begin;
create table pessoa( 
	id serial primary key,
	nome varchar(40), 
    morada varchar(150), 
    email varchar(40) unique NOT null check (position ('@' in email)> 0), 
    telefone varchar(30) UNIQUE NOT NULL, 
    noident char(12) UNIQUE NOT NULL, 
    nacionalidade varchar(20), 
    atrdisc char(2) constraint range_pessoa check (atrdisc in ('C', 'G')));
commit;

begin;
create table loja( 
	codigo integer primary key,
	email varchar(40) unique NOT null check (position ('@' in email)> 0), 
    endereco varchar(100), 
    localidade varchar(30), 
    gestor integer,
    foreign key (gestor) references pessoa (id) on delete cascade);
commit;

begin;
create table telefoneloja( 
	loja integer primary key,
	numero varchar(10),
    foreign key (loja) references loja (codigo) on delete cascade);
commit;

begin;
create table reserva( 
	noreserva serial,
	loja integer, 
    dtinicio timestamp, 
    dtfim timestamp check (dtfim >= dtinicio OR dtfim is null), 
    valor numeric(5,2), -- alterado para poder testar valores > 99.99 €
    bicicleta integer,
    primary key (noreserva, loja),
    foreign key (loja) references loja (codigo) on delete cascade,
    foreign key (bicicleta) references bicicleta (id) on delete cascade);
commit;

begin;
create table clientereserva( 
	cliente integer,
	reserva integer, 
    loja integer,
    primary key (cliente, reserva, loja),
    foreign key (cliente) references pessoa (id) on delete cascade,
    foreign key (reserva, loja) references reserva (noreserva, loja) on delete cascade);
commit;
