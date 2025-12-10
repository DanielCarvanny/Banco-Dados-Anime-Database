-- Tabela Producer
-- Backup de segurança (SEMPRE faça isso!)
CREATE TABLE backup_unknown_relations AS
SELECT * FROM Anime_Producers 
WHERE producers_id = (SELECT id FROM Producer WHERE name = 'Unknown');

-- Verificar impacto
SELECT COUNT(*) as relacoes_para_remover 
FROM Anime_Producers 
WHERE producers_id = (SELECT id FROM Producer WHERE name = 'Unknown');

-- Remover relacionamentos
BEGIN TRANSACTION;  -- Inicia transação (seguro)

DELETE FROM Anime_Producers 
WHERE producers_id = (SELECT id FROM Producer WHERE name = 'Unknown');

-- Remover o registro "Unknown"
DELETE FROM Producer WHERE name = 'Unknown';

-- Verificar se tudo ok
SELECT COUNT(*) as unknown_remaining 
FROM Producer WHERE name = 'Unknown';

-- Se count = 0, confirme:
COMMIT;

-- Se houver problema, reverta:
-- ROLLBACK;