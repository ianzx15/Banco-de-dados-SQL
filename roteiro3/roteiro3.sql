
CREATE TYPE ESTADOS AS ENUM('PB','PE','MA', 'PI', 'CE', 'RN', 'AL', 'SE', 'BH');
CREATE TYPE PROFISSAO AS ENUM('FA', 'VE', 'EN', 'CA', 'AD');

CREATE TABLE farmacias(
        id_farmacia INTEGER PRIMARY KEY,
        tipo_farmacia CHAR(1) CHECK(tipo_farmacia IN ('F', 'S')), EXCLUDE USING gist(
        tipo_farmacia with=) WHERE (tipo_farmacia = 'S'),
        bairro VARCHAR(50) UNIQUE,
        cidade VARCHAR(50),
        estado ESTADOS,
        id_funcionario INTEGER REFERENCES funcionarios (isGerente),
        EXCLUDE USING gist(
            isGerente with=) WHERE (isGerente = TRUE)
        );
    
CREATE TABLE funcionarios(
    id_farmacia INTEGER REFERENCES farmacias (id_farmacia),
    id_funcionario INTEGER,
    profissao PROFISSAO,
    isGerente BOOLEAN CHECK (isGerente = TRUE AND isGerente IN ('FA','AD'))
);

CREATE TABLE clientes(
    cpf_cliente VARCHAR(11) CHECK(char_length (cpf_cliente) = 11) PRIMARY KEY,
    nascimento DATE,
    conta_valida BOOLEAN,
    CHECK (idade >= 18 AND conta_valida = TRUE),
    DATE_PART (year, nascimento) AS idade,
    cep_endereco REFERENCES enderecos (cep_endereco)

);

CREATE TABLE enderecos(
    cep_endereco INTEGER (8) CHECK(char_length (cep_endereco) = 8) PRIMARY KEY,
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
    id_funcionario INTEGER REFERENCES funcionarios (id_funcionario),
    id_medicamento INTEGER REFERENCES medicamentos (id_medicamento),
    valor NUMERIC
);

CREATE TABLE teste(
    alg1 TEXT PRIMARY KEY,
    al2 TEXT
);

CREATE TABLE teste2(
    alg1 TEXT REFERENCES teste (alg1),
    al2 TEXT
);

//COMO CALCULAR A IDADE???
//COMO IDENTIFICAR NA CLASSE FARMACIA SE UM FUNCIONARIO É isGerente
//COMO IDENTIFICAR QUE O CLIENTE ESTÁ CADASTRADO PARA VENDER O REMEDIO COM VENDA EXCLUSIVA
