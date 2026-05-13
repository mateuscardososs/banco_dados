CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    idade INT,
    sexo CHAR(1),
    data_nascimento DATE
);

CREATE TABLE cliente_especial (
    cliente_id INTEGER PRIMARY KEY,
    cashback DECIMAL(10,2),

    FOREIGN KEY (cliente_id)
        REFERENCES cliente(id)
);

CREATE TABLE cargo (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    salario DECIMAL(10,2)
);

CREATE TABLE vendedor (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    razao_social VARCHAR(100),
    tipo VARCHAR(100),
    nota_media DECIMAL(10,2),
    cargo_id INTEGER,

    FOREIGN KEY (cargo_id)
        REFERENCES cargo(id)
);

CREATE TABLE produto (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    descricao VARCHAR(255),
    qtd_estoque INT,
    valor DECIMAL(10,2),
    categoria VARCHAR(100),
    img VARCHAR(100),
    obs VARCHAR(100),
    vendedor_id INTEGER,

    FOREIGN KEY (vendedor_id)
        REFERENCES vendedor(id)
);

CREATE TABLE transportadora (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    cidade VARCHAR(100)
);

CREATE TABLE venda (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER,
    transportadora_id INTEGER,
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10,2),
    status_pedido VARCHAR(100),
    metodo_pagamento VARCHAR(100),

    FOREIGN KEY (cliente_id)
        REFERENCES cliente(id),

    FOREIGN KEY (transportadora_id)
        REFERENCES transportadora(id)
);

CREATE TABLE itens_venda (
    id SERIAL PRIMARY KEY,
    venda_id INTEGER,
    produto_id INTEGER,
    qtd INT,
    valor_unitario DECIMAL(10,2),
    subtotal DECIMAL(10,2),

    FOREIGN KEY (venda_id)
        REFERENCES venda(id),

    FOREIGN KEY (produto_id)
        REFERENCES produto(id)
);

CREATE TABLE transporte_venda (
    id SERIAL PRIMARY KEY,
    venda_id INTEGER,
    endereco VARCHAR(100),
    valor_frete DECIMAL(10,2),

    FOREIGN KEY (venda_id)
        REFERENCES venda(id)
);



CREATE TABLE funcionario_especial (
    vendedor_id INTEGER PRIMARY KEY,
    bonus DECIMAL(10,2),

    FOREIGN KEY (vendedor_id)
        REFERENCES vendedor(id)
);