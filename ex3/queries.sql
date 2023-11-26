/*
 * Queries Trabalho 2.
 * */

delete from t where c=3;

insert into s values (1,2);

update t set c = 5 where c = 4;

/* 
(a) Implement in PostgreSQL the questions requested in 2. (You can choose one of the above solutions if you can use all the operators at this stage).
(b) Retrieve the names of all customers who made a reservation in a store located in Lisbon.
(c) Find the serial numbers of devices with a battery percentage greater than 50%, and list them in ascending order of their battery percentage.
(d) Retrieve the brand and the model (marca and modelo, respectively) of the bicycle with the highest autonomy (autonomia) among the available bikes.
(e) Retrieve the total number of reservations for each store along with their code (codigo) and the total number of reservations.
(f) Retrieve all the stores (codigo and email) that have made more than 5 bookings to date and list them in descending order of the number of bookings (Note: Make use of the date and time operators/functions).    
(g) Find the names of the customers who made reservations with bicycles having an estado (status) of ’under maintenance’ (“em manutencao”) last year (Note: Make use of the date and time operators/functions).
(h) Retrieve the information (nome, morada and telefone) of people who managed a store and have made reservations.
(i) Retrieve the names of customers who made reservations at a store managed by a person named “John” (assuming “John” is the manager of a store).
(j) Create a view LISTJOAOFILIPE that includes information about the customers who have made bookings at a shop run by “Jo ̃ao Filipe”. (Note: Jo ̃ao Filipe is also a customer).
(k) Create a view BICYCLESINNUMBERS that includes information about the bicycles and their number. The information available should be the type of bike (electric and classic), its status (“under maintenance” and “other”4) and the total number.
*/