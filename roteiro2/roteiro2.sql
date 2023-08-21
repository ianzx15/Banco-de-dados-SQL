
CREATE TABLE tarefas (
    id bigint NOT NULL,
    descricao character varying(50),
    func_resp_cpf character varying(11),
    prioridade integer,
    status character(1),
    CONSTRAINT func_resp_cpf_chk CHECK ((char_length((func_resp_cpf)::text) = 11)),
    CONSTRAINT prioridade_chk CHECK ((prioridade < 32768)),
    CONSTRAINT prioridade_chk2 CHECK ((prioridade = ANY (ARRAY[0, 1, 2, 3, 4, 5]))),
    CONSTRAINT status_chk CHECK ((status = ANY (ARRAY['P'::bpchar, 'E'::bpchar, 'C'::bpchar])))
);


CREATE TABLE funcionario(
    cpf VARCHAR(11) CHECK (char_length (cpf) = 11) PRIMARY KEY,
    data_nasc DATE NOT NULL,
    nome VARCHAR(30) NOT NULL,
    funcao VARCHAR(12) CHECK (funcao in ('LIMPEZA', 'SUP_LIMPEZA')),
    CHECK ((funcao = 'SUP_LIMPEZA' AND superior_cpf IS NULL) OR (funcao = 'LIMPEZA' AND superior_cpf IS NOT NULL)),
    nivel CHAR(1) CHECK (nivel in ('J', 'P', 'S')),
    superior_cpf VARCHAR(11) REFERENCES funcionario (cpf)
);



INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES(
null, '1980-04-09', 'joao da SIlva', 'LIMPEZA', 'J', '12345678911');

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES(
'12345678932', '1980-04-09', 'joao da SIlva', 'SUP_LIMPEZA', 'J', '12345678911');

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES(
'12345678932', '1980-04-09', 'joao da SIlva', null, 'L', '12345678911');

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES(
'12345678932', '1980-04-09', 'joao da SIlva', 'SUP_LIMPEZA', 'J', '12345678911');

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES(
'1234567893213', '1980-04-09', 'joao da SIlva', 'SUP_LIMPEZA', 'J', null);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES(
'12345678932', '1980-04-09', 'joao da SIlva', 'SUP_LIMPEZA', 'J', '12345678932');

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES(
'12345678932', '1980-04-09', 'joao da SIlva', 'LIMPEZA', 'J', '12345678932');

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES(
'12345678932', '1980-04-09', 'joao da SIlva', 'SUP_LIMPEZA', 'J', '12345678932');

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES(
'12345678932', null, 'joao da SIlva', 'SUP_LIMPEZA', 'J', '12345678932');

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES(
null, '1980-04-09', 'joao da SIlva', 'SUP_LIMPEZA', 'J', '12345678932');



ALTER TABLE tarefas ADD cpf VARCHAR(11) CHECK (char_length (cpf) = 11);
ALTER TABLE tarefas ADD FOREIGN KEY (cpf) REFERENCES funcionario (cpf) ON DELETE CASCADE;
ALTER TABLE tarefas ADD FOREIGN KEY (cpf) REFERENCES funcionario (cpf) ON DELETE RESTRICT;
ALTER TABLE tarefas ADD CHECK (status = 'P' OR func_resp_cpf IS NOT NULL );
ALTER TABLE tarefas ADD FOREIGN KEY (func_resp_cpf) REFERENCES funcionario (cpf) ON DELETE SET NULL;
