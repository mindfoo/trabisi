/*
 * Inserir os valores de forma ordenada em cada tabela.
 * */

-- Inserir dados na tabela dispositivo
begin;
insert into dispositivo (noserie, latitude, longitude, bateria)
values
(1, 38.722, -9.139, 80),
(2, 40.7128, -74.006, 60),
(3, 51.5074, -0.1278, 30),
(4, 34.0522, -11.243, 75),
(5, 37.7749, -12.4194, 45),
(6, 48.8566, 2.3522, 70),
(7, -33.8688, 15.2093, 95),
(8, -22.9068, -43.1729, 50),
(9, 35.6895, 13.6917, 65),
(10, 41.9028, 12.4964, 40);
commit;

-- Inserir dados na tabela bicicleta
begin;
insert into bicicleta (id, peso, raio, modelo, marca, mudanca, estado, atrdisc, dispositivo)
values
(1, 10.5, 15, 'Modelo-A', 'Marca-A', 6, 'livre', 'C', 1),
(2, 12.3, 18, 'Modelo-B', 'Marca-B', 1, 'ocupado', 'E', 2),
(3, 11.8, 20, 'Modelo-C', 'Marca-C', 24, 'em manutenção', 'C', 3),
(4, 9.7, 16, 'Modelo-D', 'Marca-B', 6, 'livre', 'E', 4),
(5, 13.2, 22, 'Modelo-B', 'Marca-A', 18, 'ocupado', 'C', 5),
(6, 11.5, 19, 'Modelo-A', 'Marca-B', 1, 'em manutenção', 'E', 6),
(7, 14.8, 21, 'Modelo-C', 'Marca-C', 6, 'em manutenção', 'C', 7),
(8, 10.2, 14, 'Modelo-B', 'Marca-A', 24, 'ocupado', 'E', 8),
(9, 12.7, 17, 'Modelo-A', 'Marca-B', 1, 'livre', 'C', 9),
(10, 14.5, 23, 'Modelo-B', 'Marca-A', 18, 'ocupado', 'E', 10);
commit;

-- Inserir dados na tabela classica
begin;
insert into classica (bicicleta, nomudanca)
values
(1, 2),
(2, 4),
(3, 1),
(4, 3),
(5, 0),
(6, 5),
(7, 2),
(8, 4),
(9, 1),
(10, 3);
commit;

-- Inserir dados na tabela eletrica
begin;
insert into eletrica (bicicleta, autonomia, velocidade)
values
(1, 50, 25),
(2, 40, 30),
(3, 60, 20),
(4, 45, 28),
(5, 55, 22),
(6, 38, 32),
(7, 48, 26),
(8, 42, 29),
(9, 58, 18),
(10, 35, 35);
commit;

-- Inserir dados na tabela pessoa
begin;
insert into pessoa (nome, morada, email, telefone, noident, nacionalidade, atrdisc)
values
('João Silva', 'Rua A, Lisboa', 'joao.silva@example.com', '123456789', '123456789ABC', 'Portuguesa', 'C'),
('João Santos', 'Avenida B, Porto', 'joao.santos@example.com', '987654321', '987654321DEF', 'Portuguesa', 'G'),
('Carlos Pereira', 'Rua C, Braga', 'carlos.pereira@example.com', '111222333', '111222333GHI', 'Portuguesa', 'C'),
('Ana Rodrigues', 'Avenida D, Faro', 'ana.rodrigues@example.com', '444555666', '444555666JKL', 'Portuguesa', 'G'),
('Pedro Oliveira', 'Rua E, Coimbra', 'pedro.oliveira@example.com', '777888999', '777888999MNO', 'Portuguesa', 'C'),
('João Filipe', 'Avenida F, Aveiro', 'joao.filipe@example.com', '123123123', '123123123PQR', 'Portuguesa', 'G'),
('José Manuel', 'Rua G, Setúbal', 'jose.manuel@example.com', '456456456', '456456456STU', 'Portuguesa', 'C'),
('Sofia Pereira', 'Avenida H, Viseu', 'sofia.pereira@example.com', '789789789', '789789789VWX', 'Portuguesa', 'C'),
('Miguel Santos', 'Rua I, Évora', 'miguel.santos@example.com', '987987987', '987987987YZA', 'Portuguesa', 'C'),
('Inês Almeida', 'Avenida J, Leiria', 'ines.almeida@example.com', '321321321', '321321321ABC', 'Portuguesa', 'C'),
('Inês Fernandes', 'Miami', 'ines.fernandes@example.com', '321321301', '391321321ABC', 'Americana', 'C');
commit;

-- Inserir dados na tabela loja
begin;
insert into loja (codigo, email, endereco, localidade, gestor)
values
(1, 'loja1@example.com', 'Rua X, Lisboa', 'Lisboa', 2),
(2, 'loja2@example.com', 'Avenida Y, Porto', 'Porto', 4),
(3, 'loja3@example.com', 'Rua Z, Braga', 'Braga', 6);
commit;

-- Inserir dados na tabela telefoneloja
begin;
insert into telefoneloja (loja, numero)
values
(1, '123456789'),
(2, ''),
(3, '111222333');
commit;

-- Inserir dados na tabela reserva
begin;
insert into reserva (noreserva, loja, dtinicio, dtfim, valor, bicicleta)
values
(1, 2, '2023-02-01 10:00:00', '2023-02-01 12:00:00', 200.00, 2),
(2, 1, '2023-03-01 12:00:00', '2023-03-01 14:00:00', 18.00, 3),
(1, 3, '2023-04-01 14:00:00', '2023-04-01 16:00:00', 25.00, 4),
(2, 3, '2023-05-01 16:00:00', '2023-05-01 18:00:00', 322.00, 5),
(3, 3, '2023-06-01 18:00:00', '2023-06-01 20:00:00', 30.00, 6),
(3, 1, '2023-07-01 20:00:00', '2023-07-01 22:00:00', 28.00, 7),
(2, 2, '2023-08-01 22:00:00', '2023-08-01 23:59:59', 115.00, 8),
(3, 2, '2023-09-01 10:00:00', '2023-09-01 12:00:00', 18.00, 9),
(4, 2, '2023-10-01 12:00:00', '2023-10-01 14:00:00', 12.00, 10),
(4, 1, '2022-11-01 12:00:00', '2022-11-04 16:00:00', 120.00, 10),
(5, 2, '2023-10-01 12:00:00', '2023-10-01 14:00:00', 20.00, 10),
(5, 1, '2022-01-01 08:00:00', '2023-01-01 10:00:00', 11.00, 1),
(6, 2, '2022-02-01 10:00:00', '2022-02-01 12:00:00', 20.00, 2),
(6, 1, '2022-03-01 12:00:00', '2022-03-01 14:00:00', 99.00, 3),
(4, 3, '2022-04-01 14:00:00', '2022-04-01 16:00:00', 25.00, 4),
(5, 3, '2022-05-01 16:00:00', '2022-05-01 18:00:00', 22.00, 5)
commit;

-- Inserir dados na tabela clientereserva
begin;
insert into clientereserva (cliente, reserva, loja)
values
(1, 1, 2),
(2, 2, 1),
(3, 1, 3),
(4, 2, 3),
(5, 3, 3),
(6, 3, 1),
(7, 2, 2),
(8, 3, 2),
(9, 4, 2),
(10,4, 1),
(11,5, 2),
(1, 5, 1),
(2, 6, 2),
(2, 6, 1),
(4, 4, 3),
(3, 5, 3);
commit;
