
CREATE TYPE ESTADOS AS ENUM('PB','PE','MA', 'PI', 'CE', 'RN', 'AL', 'SE', 'BH');
CREATE TYPE PROFISSAO AS ENUM('FA', 'VE', 'EN', 'CA', 'AD');

CREATE TABLE farmacias(
        id_farmacia INTEGER PRIMARY KEY,
        tipo_farmacia CHAR(1) CHECK(tipo_farmacia IN ('F', 'S')), EXCLUDE USING gist(
        tipo_farmacia with=) WHERE (tipo_farmacia = 'S'),
        bairro VARCHAR(50) UNIQUE,
        cidade VARCHAR(50),
        estado ESTADOS,
        tem_gerente BOOLEAN CHECK (tem_gerente = TRUE, ),
        id_funcionario INTEGER REFERENCES funcionarios (isGerente),
        EXCLUDE USING gist(
            isGerente with=) WHERE (isGerente = TRUE)
        );
    
CREATE TABLE funcionarios(
    id_farmacia INTEGER REFERENCES farmacias (id_farmacia),
    id_funcionario INTEGER,
    profissao PROFISSAO,
    isGerente TEXT CHECK(isGerente = 'TRUE' AND profissao in ('FA', 'AD')),
    PRIMARY KEY (id_funcionario, isGerente)
);

CREATE TABLE clientes(
    cpf_cliente VARCHAR(11) CHECK(char_length (cpf_cliente) = 11) PRIMARY KEY,
    nascimento DATE,
    idade TEXT IS current_date - nascimento,
    conta_valida BOOLEAN,
    CHECK (idade >= 18 AND conta_valida = TRUE)

);

CREATE TABLE enderecos(
    cep_endereco INTEGER (8) CHECK(char_length (cep_endereco) = 8),
    cpf_cliente VARCHAR(11) REFERENCES clientes (cpf_cliente),
    tipo_endereco TEXT CHECK(tipo_endereco IN ('residência', 'trabalho', 'outro'))
);



CREATE TABLE medicamentos(
    id_medicamento INTEGER,
    com_receita BOOLEAN


);

CREATE TABLE entregas(
    id_entrega INTEGER(50),
    cpf_cliente VARCHAR(11) REFERENCES clientes (cpf_cliente),
    cep_endereco VARCHAR(8) REFERENCES enderecos (cep_endereco)

);

CREATE TABLE vendas(
    id_medicamento INTEGER REFERENCES medicamentos (id_medicamento),
    cpf_cliente VARCHAR(11) REFERENCES clientes (cpf_cliente)
);
