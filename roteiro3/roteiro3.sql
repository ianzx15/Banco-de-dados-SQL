
CREATE TYPE ESTADOS AS ENUM('PB','PE','MA', 'PI', 'CE', 'RN', 'AL', 'SE', 'BH');
CREATE TYPE PROFISSAO AS ENUM('FA', 'VE', 'EN', 'CA', 'AD');

CREATE TABLE funcionarios(
    id_funcionario INTEGER PRIMARY KEY,
    profissao PROFISSAO,
    CONSTRAINT unique_id_profissao UNIQUE (id_funcionario, profissao)
);


CREATE TABLE farmacias(
        id_farmacia INTEGER PRIMARY KEY,
        tipo_farmacia CHAR(1) CHECK(tipo_farmacia IN ('F', 'S')), EXCLUDE USING gist(
        tipo_farmacia with=) WHERE (tipo_farmacia = 'S'),
        bairro VARCHAR(50) UNIQUE,
        cidade VARCHAR(50),
        estado ESTADOS,
        id_funcionario INTEGER UNIQUE,
        profissao_funcionario PROFISSAO,
        CONSTRAINT fk_gerente FOREIGN KEY (profissao_funcionario, id_funcionario)
        REFERENCES funcionarios (profissao , id_funcionario),
        CHECK (profissao_funcionario IN ('FA', 'AD'))
);
    

ALTER TABLE funcionarios ADD COLUMN id_farmacia INTEGER;
ALTER TABLE funcionarios ADD FOREIGN KEY (id_farmacia) REFERENCES farmacias (id_farmacia);


CREATE TABLE enderecos(
    cep_endereco VARCHAR(8) CHECK(char_length (cep_endereco) = 8) PRIMARY KEY,
    tipo_endereco TEXT CHECK(tipo_endereco IN ('residência', 'trabalho', 'outro'))
);

CREATE TABLE clientes(
    cpf_cliente VARCHAR(11) CHECK(char_length (cpf_cliente) = 11) PRIMARY KEY,
    nascimento DATE,
    cep_endereco VARCHAR(8) REFERENCES enderecos (cep_endereco),
    CHECK (date_part('year', current_date) - date_part('year', nascimento) >= 18)

);


CREATE TABLE medicamentos(
    id_medicamento INTEGER,
    com_receita CHAR(1) CHECK(com_receita IN ('S', 'N')),
    CONSTRAINT unique_medicamento_receita UNIQUE (id_medicamento, com_receita)
);

CREATE TABLE vendas(
    id_funcionario INTEGER,
    profissao_funcionario PROFISSAO CHECK (profissao_funcionario = 'VE'),
    id_medicamento INTEGER,
    com_receita CHAR(1),    
    valor NUMERIC,
    cpf_cliente VARCHAR(11) REFERENCES clientes (cpf_cliente),
    EXCLUDE USING gist(
        com_receita with=) WHERE (com_receita = 'S' AND cpf_cliente IS NULL), 
    CONSTRAINT fk_venda FOREIGN KEY (id_medicamento, com_receita)
        REFERENCES medicamentos (id_medicamento, com_receita),
    FOREIGN KEY (id_funcionario, profissao_funcionario)
        REFERENCES funcionarios (id_funcionario, profissao)
);

CREATE TABLE entregas(
    id_entrega INTEGER,
    cpf_cliente VARCHAR(11) REFERENCES clientes (cpf_cliente),
    cep_endereco VARCHAR(8) REFERENCES enderecos (cep_endereco)

);




--COMANDOS ADICIONAIS



-- devem funcionar(
--INSERT INTO funcionarios VALUES('1', 'FA');

--INSERT INTO funcionarios VALUES('3', 'AD');

--INSERT INTO farmacias VALUES('15', 'S', 'CATOLE', 'CAMPINA', 'PB', '1', 'FA');

--INSERT INTO funcionarios VALUES('2', 'VE', '15');

--UPDATE funcionarios SET id_farmacia = 15 WHERE id_funcionario = 1;

--INSERT INTO farmacias VALUES('30', 'F', 'LIBERDADE', 'CAMPINA', 'PB', '3', 'AD');

--UPDATE funcionarios SET id_farmacia = 30 WHERE id_funcionario = 3;

--INSERT INTO enderecos VALUES('58450430', 'trabalho');

--INSERT INTO clientes VALUES('12345678910', '1995-11-28', '58450430');

--INSERT INTO medicamentos VALUES('155', 'S');

--INSERT INTO medicamentos VALUES('512', 'N');

--INSERT INTO vendas VALUES('2', 'VE', '155', 'S', '35.99', '12345678910');

--INSERT INTO vendas VALUES('2', 'VE', '512', 'S', '35.99', '12345678911');

--INSERT INTO entregas VALUES('76598', '12345678910', '58450430');

--INSERT INTO funcionarios VALUES('4', 'VE');

--INSERT INTO funcionarios VALUES('5', 'AD');

--)



--deve retornar erro por violar a constraint farmacias_profissao_funcionario_check
--INSERT INTO farmacias VALUES('16', 'F', 'PRATA', 'CAMPINA', 'PB', '4', 'VE');


--deve retornar erro por violar a constraint farmacias_tipo_farmacia_excl
--INSERT INTO farmacias VALUES('17', 'S', 'PALMEIRA', 'CAMPINA', 'PB', '5', 'AD');

--deve retornar erro por violar a constraint farmacias_id_funcionario_key
--INSERT INTO farmacias VALUES('18', 'F', '3 IRMAS', 'CAMPINA', 'PB', '1', 'FA');

--deve retornar erro por violar a constraint farmacias_bairro_key
--INSERT INTO farmacias VALUES('19', 'F', 'CATOLE', 'CAMPINA', 'PB', '5', 'AD');

--deve retornar erro por violar a constraint enderecos_tipo_endereco_chec
--INSERT INTO enderecos VALUES('58450432', 'apartamento');

--deve retornar erro por violar a constraint clientes_nascimento_check
--INSERT INTO clientes VALUES('12345678910', '2010-11-28', '58450430');


--deve retornar erro por violar a constraint medicamentos_com_receita_check
--INSERT INTO medicamentos VALUES('158', 'A');




