create user administrador with password 'admin123';
create user gerente with password 'gerente123';
create user funcionario with password 'funcionario123';

grant all privileges on all tables in schema public to administrador;
grant all privileges on all sequences in schema public to administrador;

grant select, update, delete on all tables in schema public to gerente;
grant usage, select on all sequences in schema public to gerente;

grant select on venda, itens_venda to funcionario;
grant insert on venda, itens_venda to funcionario;
grant usage, select on all sequences in schema public to funcionario;