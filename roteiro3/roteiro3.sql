CREATE TABLE tarefas (
    id INTEGER,
    descriacao VARCHAR(50), 
    func_resp_cpf VARCHAR(11),
    prioridade INTEGER, 
    status CHAR(1)
);

INSERT INTO tarefas VALUES(null, null, null, null, null);


ALTER TABLE tarefas ALTER COLUMN id TYPE BIGINT;

ALTER TABLE tarefas  ADD CONSTRAINT prioridade_chk CHECK (prioridade < 32768);

DELETE FROM tarefas WHERE id IS NULL;

ALTER TABLE tarefas ALTER COLUMN prioridade SET NOT NULL;

DELETE FROM tarefas  WHERE prioridade = 3;

ALTER TABLE tarefas ADD PRIMARY KEY (id);

ALTER TABLE tarefas ADD CONSTRAINT func_resp_cpf_chk CHECK (char_length(func_resp_cpf) = 11)

UPDATE tarefas SET status = 'P' WHERE status = 'A';

ALTER TABLE tarefas  ADD CONSTRAINT status_chk CHECK(status in ('P', 'E', 'C'));

ALTER TABLE tarefas ADD CONSTRAINT prioridade_chk2 CHECK(prioridade in (0,1,2,3,4,5));

CREATE TABLE funcionario(
    cpf VARCHAR(11) CHECK (char_length = 11) PRIMARY KEY,
    data_nasc DATE NOT NULL,
    nome VARCHAR(30) NOT NULL,
    funcao VARCHAR,
    nivel CHECK (nivel in ('S', 'P', 'S')),
    superior_cpf  REFERENCES funcionario cpf,
)