INSERT INTO cliente (nome, idade, sexo, data_nascimento) VALUES 
('Mateus', 23, 'M', '2002-01-10'),
('Breno', 22, 'M', '2003-05-20'),
('Ivo', 22, 'M', '2003-08-15');

INSERT INTO cargo (nome, salario) VALUES
('cozinheiro', 2000.00),
('auxiliar', 1000.00),
('atendente', 1500.00),
('entregador', 1500.00),
('gerente', 3000.00);

INSERT INTO vendedor (nome, razao_social, tipo, nota_media, cargo_id) VALUES
('joao', 'joao burguer', 'principal', 4.8, 2),
('pedro', 'pedro burguer', 'franquia', 5, 2),
('lucas', 'lucas burger', 'franquia', 5, 3),
('jorge', 'jorge burger', 'principal', 5, 5),
('heitor', 'heitor burguer', 'franquia', 5, 1);

INSERT INTO transportadora (nome, cidade) VALUES
('Entrega Própria', 'Recife'),
('Motoboy', 'Recife'),
('Ifood', 'Olinda');





INSERT INTO produto
(nome, descricao, qtd_estoque, valor, categoria, img, obs, vendedor_id)
VALUES

('Double Bacon',
'Hambúrguer artesanal com dobro de bacon e cheddar',
50,
32.00,
'Hambúrguer',
'double_bacon.png',
'Mais vendido da casa',
1),

('Smash Duplo',
'Hambúrguer smash duplo com queijo',
40,
35.00,
'Hambúrguer',
'smash_duplo.png',
'Pão brioche',
2),

('Cheddar Duplo',
'Hambúrguer com cheddar cremoso',
35,
33.00,
'Hambúrguer',
'cheddar_duplo.png',
'Cheddar especial',
3),

('Parrilha Bacon',
'Hambúrguer parrilla com bacon crocante',
30,
32.00,
'Hambúrguer',
'parrilha_bacon.png',
'Carne premium',
4),

('Clone Burguer',
'Hambúrguer especial da casa',
25,
30.00,
'Hambúrguer',
'clone_burguer.png',
'Receita exclusiva',
5),

('Bacon Burguer',
'Hambúrguer simples com bacon',
45,
28.00,
'Hambúrguer',
'bacon_burguer.png',
'Lanche tradicional',
1),

('Australian Bacon',
'Hambúrguer australiano com bacon',
20,
32.00,
'Hambúrguer',
'australian_bacon.png',
'Pão australiano',
2),

('Supremo',
'Maior hambúrguer do cardápio',
15,
45.00,
'Hambúrguer',
'supremo.png',
'Burger premium',
3);




INSERT INTO cliente (nome, idade, sexo, data_nascimento)
SELECT
    'Cliente ' || gs,
    18 + (gs % 45),
    CASE WHEN gs % 2 = 0 THEN 'M' ELSE 'F' END,
    DATE '1980-01-01' + (gs * INTERVAL '30 days')
FROM generate_series(4, 100) AS gs;

select * from cliente;





INSERT INTO produto
(nome, descricao, qtd_estoque, valor, categoria, img, obs, vendedor_id)
VALUES
('X-Salada', 'Hambúrguer com alface, tomate, queijo e molho especial', 40, 24.00, 'Hambúrguer', 'x_salada.png', 'Clássico da casa', 1),
('X-Bacon', 'Hambúrguer com queijo e bacon crocante', 35, 27.00, 'Hambúrguer', 'x_bacon.png', 'Muito pedido', 2),
('X-Egg', 'Hambúrguer com ovo, queijo e molho especial', 30, 26.00, 'Hambúrguer', 'x_egg.png', 'Com ovo', 3),
('Combo Explosivo', 'Hambúrguer, batata frita e refrigerante', 25, 38.00, 'Combo', 'combo_explosivo.png', 'Combo promocional', 1),
('Combo Supremo', 'Supremo, batata grande e refrigerante 500ml', 20, 52.00, 'Combo', 'combo_supremo.png', 'Combo premium', 2),
('Batata Frita Pequena', 'Porção pequena de batata frita', 50, 10.00, 'Acompanhamento', 'batata_pequena.png', 'Porção individual', 3),
('Batata Frita Grande', 'Porção grande de batata frita', 45, 16.00, 'Acompanhamento', 'batata_grande.png', 'Ideal para dividir', 4),
('Anéis de Cebola', 'Porção de onion rings crocantes', 30, 18.00, 'Acompanhamento', 'aneis_cebola.png', 'Crocante', 5),
('Refrigerante Lata', 'Refrigerante lata 350ml', 80, 7.00, 'Bebida', 'refrigerante_lata.png', 'Diversos sabores', 1),
('Refrigerante 1L', 'Refrigerante garrafa 1 litro', 40, 12.00, 'Bebida', 'refrigerante_1l.png', 'Ideal para combos', 2),
('Milkshake Chocolate', 'Milkshake sabor chocolate 400ml', 25, 18.00, 'Sobremesa', 'milkshake_chocolate.png', 'Gelado e cremoso', 3),
('Brownie Explode', 'Brownie artesanal com calda de chocolate', 20, 15.00, 'Sobremesa', 'brownie_explode.png', 'Sobremesa da casa', 4);





INSERT INTO venda
(cliente_id, transportadora_id, valor_total, status_pedido, metodo_pagamento)
VALUES
(1, 1, 64.00, 'Em preparo', 'Pix'),
(2, 2, 38.00, 'Entregue', 'Cartão'),
(3, 3, 52.00, 'Saiu para entrega', 'Dinheiro'),
(4, 1, 89.00, 'Entregue', 'Pix'),
(5, 2, 120.00, 'Em preparo', 'Cartão');

INSERT INTO itens_venda
(venda_id, produto_id, qtd, valor_unitario, subtotal)
VALUES

(1, 1, 2, 32.00, 64.00),

(2, 12, 1, 38.00, 38.00),

(3, 13, 1, 52.00, 52.00),

(4, 8, 1, 45.00, 45.00),
(4, 10, 2, 12.00, 24.00),

(5, 1, 2, 32.00, 64.00),
(5, 16, 2, 18.00, 36.00),
(5, 18, 2, 10.00, 20.00);

INSERT INTO transporte_venda
(venda_id, endereco, valor_frete)
VALUES
(1, 'Rua A, Recife', 8.00),
(2, 'Rua B, Olinda', 6.00),
(3, 'Rua C, Boa Viagem', 10.00),
(4, 'Rua D, Pina', 7.00),
(5, 'Rua E, Casa Forte', 12.00);




INSERT INTO venda
(cliente_id, transportadora_id, valor_total, status_pedido, metodo_pagamento)
VALUES
(1, 1, 600.00, 'Entregue', 'Pix');


INSERT INTO itens_venda
(venda_id, produto_id, qtd, valor_unitario, subtotal)
VALUES
(1, 1, 10, 32.00, 320.00),
(1, 1, 10, 32.00, 320.00),
(1, 1, 10, 32.00, 320.00),
(1, 1, 10, 32.00, 320.00);