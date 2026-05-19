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


create or replace procedure realizar_venda(     
    p_venda_id integer,
    p_produto_id integer,
    p_quantidade integer,
    p_valor_unitario decimal
)
language plpgsql
as
$$
declare
    subtotal_calculado decimal(10,2);
begin

    subtotal_calculado := p_quantidade * p_valor_unitario;

    insert into itens_venda
    (venda_id, produto_id, qtd, valor_unitario, subtotal)
    values
    (p_venda_id, p_produto_id, p_quantidade, p_valor_unitario, subtotal_calculado);

    update produto
    set qtd_estoque = qtd_estoque - p_quantidade
    where id = p_produto_id;

    raise notice
    'venda realizada e estoque atualizado.';

end;
$$;




create or replace procedure estatisticas_vendas() 
language plpgsql
as
$$
declare
    produto_mais varchar(100);
    vendedor_mais varchar(100);
    qtd_mais int;
    valor_mais decimal(10,2);

    produto_menos varchar(100);
    qtd_menos int;
    valor_menos decimal(10,2);
begin

    select p.nome, v.nome, sum(iv.qtd), sum(iv.subtotal)
    into produto_mais, vendedor_mais, qtd_mais, valor_mais
    from itens_venda iv
    join produto p on p.id = iv.produto_id
    join vendedor v on v.id = p.vendedor_id
    group by p.nome, v.nome
    order by sum(iv.qtd) desc
    limit 1;

    select p.nome, sum(iv.qtd), sum(iv.subtotal)
    into produto_menos, qtd_menos, valor_menos
    from itens_venda iv
    join produto p on p.id = iv.produto_id
    group by p.nome
    order by sum(iv.qtd) asc
    limit 1;

    raise notice 'produto mais vendido: %, quantidade: %, valor ganho: r$ %',
        produto_mais, qtd_mais, valor_mais;

    raise notice 'vendedor associado ao produto mais vendido: %',
        vendedor_mais;

    raise notice 'produto menos vendido: %, quantidade: %, valor ganho: r$ %',
        produto_menos, qtd_menos, valor_menos;

end;
$$;

call estatisticas_vendas();