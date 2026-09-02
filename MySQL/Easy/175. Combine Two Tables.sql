SELECT P.firstname,P.lastname,A.city,A.state 
FROM person P LEFT JOIN Address A 
on P.personId=A.personId; 