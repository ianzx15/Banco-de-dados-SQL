---1:
SELECT COUNT(*) FROM employee e WHERE e.sex = 'F';
---2:
SELECT AVG(e.salary) FROM employee e WHERE e.sex = 'M' AND e.address LIKE '%TX%';
---3:
SELECT e.superssn AS ssn_supervisor, COUNT(e.ssn) AS qtd_supervisionados 
FROM employee e LEFT OUTER JOIN employee s 
ON s.ssn = e.superssn 
GROUP BY e.superssn ORDER BY qtd_supervisionados;
---4:
SELECT s.fname AS nome_supervisor, COUNT(e.ssn) AS qtd_supervisionados 
FROM employee e INNER JOIN employee s ON s.ssn = e.superssn
GROUP BY nome_supervisor
ORDER BY qtd_supervisionados;
---5:
SELECT s.fname AS nome_supervisor, COUNT(e.ssn) AS qtd_supervisionados 
FROM employee e LEFT OUTER JOIN employee s ON s.ssn = e.superssn
GROUP BY nome_supervisor;
---6:
SELECT MIN(result) AS qtd FROM (SELECT COUNT(e.ssn) AS result FROM employee e, works_on w, project p
WHERE e.ssn = w.Essn AND p.Pnumber = w.Pno GROUP BY p.Pname )
as T;

---7:
SELECT w.Pno AS num_projeto, COUNT(*) AS qtd_func FROM works_on w 
GROUP BY w.Pno HAVING COUNT(*) <= ALL (SELECT COUNT(*) 
FROM works_on w GROUP BY w.Pno);

---8:
SELECT p.Pnumber AS num_proj, AVG(e.salary) AS media_sal FROM employee e, project p, works_on w
WHERE e.ssn = w.Essn AND p.Pnumber = w.Pno GROUP BY p.Pnumber;

---9:
SELECT p.Pnumber AS proj_num, p.pname AS proj_nome, AVG(e.salary) FROM employee e, works_on w, project p
WHERE e.ssn = w.Essn AND w.Pno = p.Pnumber GROUP BY p.Pnumber, p.pname;

---10:
SELECT e.fname FROM employee e LEFT OUTER JOIN works_on w 
ON e.ssn = w.Essn AND w.Pno <> 92 
WHERE e.salary > (SELECT MAX(e.salary) FROM employee e, works_on w 
WHERE e.ssn = w.Essn AND w.Pno = 92);

---11:
SELECT e.ssn, COUNT(w.Essn) AS qtd_proj FROM employee e FULL OUTER JOIN works_on w
ON e.ssn = w.Essn
GROUP BY e.ssn ORDER BY qtd_proj;

---12:
SELECT w.Pno AS num_proj, COUNT(e.ssn) AS qtd_func 
FROM works_on w RIGHT OUTER JOIN employee e
ON e.ssn = w.Essn
GROUP BY w.Pno HAVING COUNT(e.ssn) < 5 
ORDER BY COUNT(e.ssn);

---13:
SELECT e.fname FROM employee e WHERE e.ssn IN (SELECT * FROM works_on w WHERE w.essn = e.ssn);

---14:
SELECT d.dname FROM department d 
WHERE NOT EXISTS (SELECT p.dnum FROM project p  
WHERE d.dnumber = p.dnum);

---15:
SELECT e.fname, e.lname FROM employee e, works_on r
WHERE e.ssn = r.essn AND r.pno IN (SELECT w.pno AS result FROM works_on w
WHERE w.essn = '123456789') 
GROUP BY e.fname, e.lname;


