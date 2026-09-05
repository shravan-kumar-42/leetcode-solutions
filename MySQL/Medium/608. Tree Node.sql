SELECT id,CASE WHEN P_id IS NULL THEN 'Root' WHEN id IN (SELECT p_id FROM Tree) THEN 'Inner' ELSE 'Leaf' 
END AS type
FROM Tree;