create view vendas_por_cliente as
select
    c.id as cliente_id,
    c.nome as cliente,
    count(v.id) as total_pedidos,
    sum(v.valor_total) as valor_total_gasto
from cliente c
join venda v on v.cliente_id = c.id
group by c.id, c.nome;


create view produtos_mais_vendidos as
select
    p.id as produto_id,
    p.nome as produto,
    p.categoria,
    sum(iv.qtd) as quantidade_vendida,
    sum(iv.subtotal) as total_arrecadado
from produto p
join itens_venda iv on iv.produto_id = p.id
group by p.id, p.nome, p.categoria;


create view vendas_por_vendedor as
select
    vd.id as vendedor_id,
    vd.nome as vendedor,
    count(distinct v.id) as total_vendas,
    sum(iv.subtotal) as total_vendido
from vendedor vd
join produto p on p.vendedor_id = vd.id
join itens_venda iv on iv.produto_id = p.id
join venda v on v.id = iv.venda_id
group by vd.id, vd.nome;