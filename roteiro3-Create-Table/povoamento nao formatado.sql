INSERT INTO funcionarios VALUES(
    '1', 'FA'                                    
);


INSERT INTO funcionarios VALUES(
    '3', 'AD'
);


INSERT INTO farmacias VALUES(
    '15', 'S', 'CATOLE', 'CAMPINA', 'PB', '1', 'FA'
);

INSERT INTO funcionarios VALUES(
    '2', 'VE', '15'
);

UPDATE funcionarios SET id_farmacia = 15 WHERE id_funcionario = 1;

INSERT INTO farmacias VALUES(
    '30', 'F', 'LIBERDADE', 'CAMPINA', 'PB', '3', 'AD'
);

UPDATE funcionarios SET id_farmacia = 30 WHERE id_funcionario = 3;

INSERT INTO enderecos VALUES(
    '58450430', 'trabalho'
);

INSERT INTO clientes VALUES(
    '12345678910', '1995-11-28', '58450430'
);

INSERT INTO medicamentos VALUES(
    '155', 'S'
);

INSERT INTO medicamentos VALUES(
    '512', 'N'
);

INSERT INTO vendas VALUES(
    '2', 'VE', '155', 'S', '35.99', '12345678910'
);

INSERT INTO vendas VALUES(
    '2', 'VE', '512', 'N', '35.99'
);

INSERT INTO entregas VALUES(
    '76598', '12345678910', '58450430'
);











INSERT INTO funcionarios VALUES(
    '4', 'VE'
);

INSERT INTO funcionarios VALUES(
    '5', 'AD'
);


INSERT INTO farmacias VALUES(
    '16', 'F', 'PRATA', 'CAMPINA', 'PB', '4', 'VE'
);


INSERT INTO farmacias VALUES(
    '17', 'S', 'PALMEIRA', 'CAMPINA', 'PB', '5', 'AD'
);


INSERT INTO farmacias VALUES(
    '18', 'F', '3 IRMAS', 'CAMPINA', 'PB', '1', 'FA'
);


INSERT INTO farmacias VALUES(
    '19', 'F', 'CATOLE', 'CAMPINA', 'PB', '5', 'AD'
);


INSERT INTO enderecos VALUES(
    '58450432', 'apartamento'
);


INSERT INTO clientes VALUES(
    '12345678910', '2010-11-28', '58450430'
);



INSERT INTO medicamentos VALUES(
    '158', 'A'
);


INSERT INTO medicamentos VALUES(
    '159', 'S'
);

INSERT INTO vendas VALUES(
    '2', 'VE', '155', 'S', '35.99'
);



