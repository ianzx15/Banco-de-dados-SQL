
CREATE TYPE ESTADOS AS ENUM('PB','PE','MA', 'PI', 'CE', 'RN', 'AL', 'SE', 'BH');

CREATE TABLE farmacias(
        id_farmacia INTEGER PRIMARY KEY,
        tipo_farmacia CHAR(1) CHECK(tipo_farmacia IN ('F', 'S')), EXCLUDE USING gist(
        tipo_farmacia with=) WHERE (tipo_farmacia = 'S'),
        bairro VARCHAR(50) UNIQUE,
        cidade VARCHAR(50),
        estado ESTADOS,
        id_funcionario, gerente REFERENCES funcionarios (id_funcionario, gerente)

    );


CREATE TYPE PROFISSAO AS ENUM('FA', 'VE', 'EN', 'CA', 'AD');

CREATE TABLE funcionarios(
    id_farmacia INTEGER REFERENCES farmacias (id_farmacia),
    id_funcionario INTEGER PRIMARY KEY,
    profissao PROFISSAO,
    UNIQUE(id_farmacia, id_funcionario),
    gerente BOOLEAN

);


1555, 333, gerente,
1555, 222, gerente