CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    idade INT,
    sexo CHAR(1),
    data_nascimento DATE
);

CREATE TABLE cliente_especial (
    cliente_id INTEGER PRIMARY KEY,
    cashback DECIMAL(10,2),

    FOREIGN KEY (cliente_id)
        REFERENCES cliente(id)
        ON DELETE CASCADE
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

    CONSTRAINT fk_vendedor_cargo
        FOREIGN KEY (cargo_id)
        REFERENCES cargo(id)
);

CREATE TABLE produto (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    descricao VARCHAR(255),
    qtd_estoque INT,
    valor DECIMAL(10,2),
    obs VARCHAR(255),
    vendedor_id INTEGER,

    CONSTRAINT fk_produto_vendedor
        FOREIGN KEY (vendedor_id)
        REFERENCES vendedor(id)
);


create table transportadora (
id serial primary key, 
nome varchar(100),
cidade varchar(100)
);

create table venda (
id serial primary key,
cliente_id integer,
transportadora_id integer,
data_venda timestamp default current_timestamp,

constraint fk_venda_cliente
foreign key (cliente_id) references cliente(id),

constraint fk_transporte_venda
foreign key (transportadora_id) references transportadora(id)

)

create table produto_venda (
id serial primary key,
id_venda integer,
id_produto integer,
qtd int,

constraint fk_venda
foreign key (id_venda) references venda(id),

constraint fk_produto
foreign key (id_produto) references produto(id)
)

create table transpote_venda (
id serial primary key,
id_venda integer,
destino varchar (100),
frete decimal(10,2), 

constraint fk_venda
foreign key (id_venda) references venda(id)
)