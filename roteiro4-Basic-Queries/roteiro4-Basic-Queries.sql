-- 1:
SELECT * FROM department;
-- 2: 
SELECT * FROM dependent;
-- 3: 
SELECT * FROM dept_locations;
-- 4: 
SELECT * FROM employee;
-- 5: 
SELECT * FROM project;
-- 6: 
SELECT * FROM works_on;
-- 7:
SELECT employee.fname, employee.lname FROM employee WHERE employee.sex = 'M';
--8:
SELECT employee.fname FROM employee WHERE employee.superssn IS NULL;
--9:
SELECT e.fname, s.fname FROM employee e, employee s WHERE e.superssn IS NOT NULL AND s.ssn = e.superssn;
--10:
SELECT e.fname FROM employee e, employee s WHERE s.fname = 'Franklin' AND e.superssn = s.ssn; 
--11:
SELECT d.dname, e.dlocation FROM department d, dept_locations e WHERE d.dnumber = e.dnumber; 
--12:
SELECT d.dname FROM department d, dept_locations e WHERE d.dnumber = e.dnumber AND e.dlocation SIMILAR TO '(S)%';
--13:
SELECT e.fname, e.lname, d.dependent_name FROM employee e, dependent d WHERE e.ssn = d.essn;
--14:
SELECT (e.fname||' '||e.lname) AS full_name, e.salary FROM employee e WHERE e.salary > 50000;
--15:
SELECT p.pname, d.dname FROM project p, department d WHERE d.dnumber = p.dnum;
--16:
SELECT p.pname, e.fname FROM project p, employee e, department d WHERE d.dnumber = p.dnum AND d.mgrssn = e.ssn; 
--17:
SELECT p.pname, e.fname FROM project p, employee e, works_on w WHERE w.essn = e.ssn AND w.pno = p.pnumber; 
--18:
SELECT e.fname, d.dependent_name, d.relationship FROM dependent d, employee e, project p, works_on w WHERE w.essn = e.ssn AND p.pnumber = w.pno AND p.pnumber = 91 AND d.essn = e.ssn;

