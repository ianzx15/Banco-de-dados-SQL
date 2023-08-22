
CREATE TYPE ESTADOS AS ENUM('PB','PE','MA', 'PI', 'CE', 'RN', 'AL', 'SE', 'BH');
CREATE TYPE PROFISSAO AS ENUM('FA', 'VE', 'EN', 'CA', 'AD');

CREATE TABLE farmacias(
        id_farmacia INTEGER PRIMARY KEY,
        tipo_farmacia CHAR(1) CHECK(tipo_farmacia IN ('F', 'S')), EXCLUDE USING gist(
        tipo_farmacia with=) WHERE (tipo_farmacia = 'S'),
        bairro VARCHAR(50) UNIQUE,
        cidade VARCHAR(50),
        estado ESTADOS,
        id_funcionario INTEGER,
        profissao_funcionario PROFISSAO,
        CONSTRAINT fk_gerente FOREIGN KEY (profissao_funcionario, id_funcionario)
        REFERENCES funcionarios (profissao, id_funcionario)
        );
    
CREATE TABLE funcionarios(
    id_farmacia INTEGER REFERENCES farmacias (id_farmacia),
    id_funcionario INTEGER PRIMARY KEY,
    profissao PROFISSAO
);

CREATE TABLE clientes(
    cpf_cliente VARCHAR(11) CHECK(char_length (cpf_cliente) = 11) PRIMARY KEY,
    nascimento DATE,
    CHECK (date_part('year', current_date) - date_part('year', nascimento) >= 18),
    cep_endereco REFERENCES enderecos (cep_endereco)

);

CREATE TABLE enderecos(
    cep_endereco INTEGER (8) CHECK(char_length (cep_endereco) = 8) PRIMARY KEY,
    tipo_endereco TEXT CHECK(tipo_endereco IN ('residência', 'trabalho', 'outro'))
);



CREATE TABLE medicamentos(
    id_medicamento INTEGER,
    com_receita CHAR(1) CHECK(com_receita IN ('S', 'N'))

);


CREATE TABLE entregas(
    id_entrega INTEGER(50),
    cpf_cliente VARCHAR(11) REFERENCES clientes (cpf_cliente),
    cep_endereco VARCHAR(8) REFERENCES enderecos (cep_endereco)

);

CREATE TABLE vendas(
    id_funcionario INTEGER REFERENCES funcionarios (id_funcionario),
    id_medicamento INTEGER,
    cpf_cliente VARCHAR(11) REFERENCES clientes (cpf_cliente),
    com_receita CHAR(1) CHECK(com_receita IN ('S', 'N')),    
    valor NUMERIC,
    CHECK (com_receita = 'S' AND cpf_cliente IS NOT NULL),
    CONSTRAINT fk_venda FOREIGN KEY (id_medicamento, com_receita) REFERENCES medicamentos (id_medicamento, com_receita)
);
