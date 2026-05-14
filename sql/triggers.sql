create function calculo_cliente_especial()
returns trigger as $$
declare 
total_gasto decimal(10,2);

begin
	select sum(valor_total)
	into total_gasto from venda 
	where cliente_id = new.cliente_id;


if total_gasto > 500 then 

insert into cliente_especial (cliente_id, cashback)
values (new.cliente_id, total_gasto * 0.05)

on conflict (cliente_id)
do update set cashback = total_gasto * 0.05;

end if;

return new;

end;


$$ LANGUAGE plpgsql;




CREATE TRIGGER trigger_cliente_especial
AFTER INSERT ON venda
FOR EACH ROW
EXECUTE FUNCTION calculo_cliente_especial();

INSERT INTO venda
(cliente_id, transportadora_id, valor_total, status_pedido, metodo_pagamento)
VALUES
(1, 1, 600.00, 'Entregue', 'Pix');




create function calculo_funcionario_especial()
returns trigger as
$$
declare
    total_vendido decimal(10,2);
    bonus_total decimal(10,2);

begin

    select sum(iv.subtotal)
    into total_vendido
    from itens_venda iv
    join produto p on iv.produto_id = p.id
    where p.vendedor_id = (
        select vendedor_id
        from produto
        where id = new.produto_id
    );

    if total_vendido > 1000 then

        bonus_total := total_vendido * 0.05;

        insert into funcionario_especial (vendedor_id, bonus)
        values (
            (
                select vendedor_id
                from produto
                where id = new.produto_id
            ),
            bonus_total
        )

        on conflict (vendedor_id)
        do update set bonus = bonus_total;

        raise notice
        'vendedor virou especial. total bonus: r$ %',
        bonus_total;

    end if;

    return new;

end;
$$ language plpgsql;




create trigger trg_funcionario_especial
after insert on itens_venda
for each row
execute function calculo_funcionario_especial();