/* 
4. Write a sql code that allows: 
    a) change the attribute mudanca in BICICLETA by adding a new value, 
    in this case 40; 
    b) assign this new value to the bicycle(s) already registered in 
    the DB with the model “Modelo-B” of the brand “Marca-A”. The sql code must guarantee atomicity in changes.   
*/


-- (a)
begin;
ALTER TABLE bicicleta drop constraint range_mudanca;
ALTER TABLE bicicleta ADD constraint range_mudanca check (mudanca in (1,6,18,24,40));
COMMIT;

-- (b)

update bicicleta 
set mudanca = 40
where marca = 'Marca-A' and modelo = 'Modelo-B'; 