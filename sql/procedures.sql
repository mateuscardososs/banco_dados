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




create or replace procedure sorteio_cliente()
language plpgsql
as
$$
declare
    cliente_sorteado integer;
    nome_cliente varchar(100);
    cliente_especial_existe integer;
begin

    select id, nome
    into cliente_sorteado, nome_cliente
    from cliente
    order by random()
    limit 1;

    select count(*)
    into cliente_especial_existe
    from cliente_especial
    where cliente_id = cliente_sorteado;

    if cliente_especial_existe > 0 then

        raise notice
        'cliente % ganhou voucher de r$200',
        nome_cliente;

    else

        raise notice
        'cliente % ganhou voucher de r$100',
        nome_cliente;

    end if;

end;
$$;

call sorteio_cliente();