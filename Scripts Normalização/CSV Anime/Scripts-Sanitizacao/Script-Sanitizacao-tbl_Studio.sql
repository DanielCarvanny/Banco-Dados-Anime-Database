-- Tabela Studio
-- Backup de segurança (SEMPRE faça isso!)
CREATE TABLE backup_unknown_relations AS
SELECT * FROM Anime_Studio 
WHERE studio_id = (SELECT id FROM Studio WHERE name = 'Unknown');

-- Verificar impacto
SELECT COUNT(*) as relacoes_para_remover 
FROM Anime_Studio 
WHERE studio_id = (SELECT id FROM Studio WHERE name = 'Unknown');

-- Remover relacionamentos
BEGIN TRANSACTION;  -- Inicia transação (seguro)

DELETE FROM Anime_Studio 
WHERE studio_id = (SELECT id FROM Studio WHERE name = 'Unknown');

-- Remover o registro "Unknown"
DELETE FROM Studio WHERE name = 'Unknown';

-- Verificar se tudo ok
SELECT COUNT(*) as unknown_remaining 
FROM Studio WHERE name = 'Unknown';

-- Se count = 0, confirme:
COMMIT;

-- Se houver problema, reverta:
-- ROLLBACK;
