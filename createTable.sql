/*
 * Criação de tabelas e definição das restrições.
 * */

create table bicicleta(
	id integer primary key,
	peso numeric(4,2), /* ##,## */
    raio integer CONSTRAINT range_raio CHECK (raio >= 13 and <= 23), 
    modelo varchar(20), 
    marca varchar(30), 
    mudanca integer CONSTRAINT range_mudanca CHECK (mudanca IN (1,6,18,24)), 
    estado varchar(30) CONSTRAINT range_estado CHECK (mudanca IN ('livre', 'ocupado', 'em manutenção')), 
    atrdisc char(2) CONSTRAINT range_disc CHECK (atrdisc IN ('C', 'E')), 
    dispositivo integer,
    FOREIGN KEY (dispositivo) references dispositivo (noserie) on delete cascade 

);

create table classica(
	bicicleta integer primary key,
	nomudanca integer CONSTRAINT range_nomudanca CHECK (nomudanca >= 0 and <= 5),
	FOREIGN KEY (bicicleta) foreign key (bicicleta) references bicicleta (id) on delete cascade
);


create table clientereserva( 
	cliente integer primary key,
	reserva integer, 
    loja integer,
    FOREIGN KEY (cliente) REFERENCES pessoa (id),
    FOREIGN KEY (reserva, loja) REFERENCES reserva (noreserva, loja)
);

create table dispositivo( 
	noserie integer primary key,
	latitude numeric(4,2), 
    longitude numeric(4,2), 
    bateria integer CONSTRAINT range_bat CHECK (bateria >= 0 and <= 100)
);

create table eletrica( 
	bicicleta integer primary key,
	autonomia integer, 
    velocidade integer
    FOREIGN KEY (bicicleta) REFERENCES bicicleta (id),
);

create table loja( 
	codigo integer primary key,
	email varchar(40) UNIQUE and NOT NULL and LIKE '_@_', 
    endereco varchar(100), 
    localidade varchar(30), 
    gestor integer,
    FOREIGN KEY (gestor) REFERENCES pessoa (id),
);

create table pessoa( 
	id serial primary key,
	nome varchar(40), 
    morada varchar(150), 
    email varchar(40) UNIQUE and NOT NULL and LIKE '_@_', 
    telefone varchar(30) UNIQUE and NOT NULL, 
    noident char(12) UNIQUE and NOT NULL, 
    nacionalidade varchar(20), 
    atrdisc char(2) CONSTRAINT range_pessoa CHECK (atrdisc IN ('C', 'G')) 
);

create table reserva( 
	noreserva serial,
	loja integer, 
    dtinicio timestamp, 
    dtfim timestamp CHECK (dtfim >= dtinic OR dtfim IS NULL), 
    valor numeric(4,2), 
    bicicleta integer,
    PRIMARY KEY (noreserva, loja),
    FOREIGN KEY (loja) REFERENCES loja (codigo),
    FOREIGN KEY (bicicleta) REFERENCES bicicleta (id)
);

create table telefoneloja( 
	loja integer primary key,
	numero varchar(10),
    FOREIGN KEY (loja) REFERENCES loja (codigo)
);

//teste push 