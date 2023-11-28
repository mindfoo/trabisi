/* 
4. Write a sql code that allows: 
    a) change the attribute mudanca in BICICLETA by adding a new value, 
    in this case 40; 
    b) assign this new value to the bicycle(s) already registered in 
    the DB with the model “Modelo-B” of the brand “Marca-A”. The sql code must guarantee atomicity in changes.   
*/


-- (a)
begin;
alter table bicicleta drop constraint range_mudanca;
alter table bicicleta add constraint range_mudanca check (mudanca in (1,6,18,24,40));
commit;

-- (b)

begin;
update bicicleta 
set mudanca = 40
where marca = 'Marca-A' and modelo = 'Modelo-B'; 
commit;