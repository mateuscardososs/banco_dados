create or replace procedure reajuste_salario(
    percentual decimal,
    cargo_nome varchar
)
language plpgsql
as
$$
begin

    update cargo
    set salario = salario + (salario * percentual / 100)
    where nome = cargo_nome;

    raise notice
    'salario do cargo % reajustado em % por cento.',
    cargo_nome,
    percentual;

end;
$$;

select * from cargo;

call reajuste_salario(10, 'gerente');

select * from cargo;