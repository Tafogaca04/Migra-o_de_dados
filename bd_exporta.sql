create database  bd_exporta;
use bd_exporta;

create table departamento(
id int primary key auto_increment not null,
nome varchar(50),
localizacao varchar (50),
orcamento  decimal(10,2)
);
insert into departamento (nome,localizacao,orcamento)
values ("Recursos Humanos","São Paulo",50000.00),
 ("Financeiro","Rio de Janeiro",750000.00),
("Marketing","Belo Horizonte",60000.00),
("TI","Curitiba",90000.00),
("Vendas","Porto Alegre",45000.00);

show variables like 'secure_file_priv';

select*from departamento
into outfile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\depto.csv' 
fields terminated by ',' enclosed by '"'
lines terminated by'\n';

delete from departamento
where id =1;

delete from departamento
where id =2;

delete from departamento
where id =3;
 
 delete from departamento
where id =4; 

delete from departamento
where id =5;

#importrar arquivo csv
LOAD DATA infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\depto.csv' 
into table departamento
fields terminated by',' enclosed by '"'
lines terminated by '\n';

#início da transação
START transaction;
#aumentar o orçamento do departamento TI em 1000
update departamento set  orcamento = orcamento +1000.00 where nome="TI";

#aumentar o orçamento do departamento financeiro em 1000
 update departamento set orcamento = orcamento +1000.00 where nome="Financeiro";
 #Confirmar  a transação
 commit;

#inicio  da transação
start transaction;
#reduzir o orçamento do departamento de marketing
update departamento set  orcamento = orcamento - 500.00 where nome='Marketing';
#reduzir o orcamento do departamento de vendas 
update departamento set  orcamento = orcamento - 300.00 where nome='Vendas';

-- cancelar a transação
rollback;

start  transaction;
#aumentar o orçamento  de rh
update departamento set orcamento = orcamento + 7000.00 where nome ='Recursos Humanos';
#definir um ponto  intermediario
savepoint ajuste_parcial;
#aumentar o orçamento do departamento de vendas
update departamento set orcamento = orcamento + 2000.00 where nome ='Vendas';
#reverter para o ponto intermediario
rollback to ajuste_parcial;


