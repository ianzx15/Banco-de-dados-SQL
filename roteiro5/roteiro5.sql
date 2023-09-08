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
-- SELECT r.Pnumber as num_projeto, MIN(result) AS qtd FROM project r, (SELECT COUNT(e.ssn) AS result FROM employee e, works_on w, project p
-- WHERE e.ssn = w.Essn AND p.Pnumber = w.Pno GROUP BY p.Pname)
-- as T GROUP BY r.Pnumber;

---8:
SELECT p.Pnumber AS num_proj, AVG(e.salary) AS media_sal FROM employee e, project p, works_on w
WHERE e.ssn = w.Essn AND p.Pnumber = w.Pno GROUP BY p.Pnumber;

---9:
SELECT p.Pnumber AS proj_num, p.pname AS proj_nome, AVG(e.salary) FROM employee e, works_on w, project p
WHERE e.ssn = w.Essn AND w.Pno = p.Pnumber GROUP BY p.Pnumber, p.pname;

---10:


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
SELECT d.dname FROM department d, project p WHERE 