-- PASSO 1: Backup ANTES de modificar (CRÍTICO!)
CREATE TABLE backup_anime_before_null AS 
SELECT * FROM anime 
WHERE name = 'Unknown' 
   OR english_name = 'Unknown'
   OR japanese_name = 'Unknown'
   OR "type" = 'Unknown'
   OR aired = 'Unknown'
   OR "source" = 'Unknown'
   OR rating = 'Unknown'
   OR premiered = 'Unknown';

-- PASSO 2: Verificar quantos registros serão afetados
SELECT 
    COUNT(CASE WHEN name = 'Unknown' THEN 1 END) as name_unknown,
    COUNT(CASE WHEN english_name = 'Unknown' THEN 1 END) as english_unknown,
    COUNT(CASE WHEN japanese_name = 'Unknown' THEN 1 END) as japanese_unknown,
    COUNT(CASE WHEN "type" = 'Unknown' THEN 1 END) as type_unknown,
    COUNT(CASE WHEN aired = 'Unknown' THEN 1 END) as aired_unknown,
    COUNT(CASE WHEN "source" = 'Unknown' THEN 1 END) as source_unknown,
    COUNT(CASE WHEN rating = 'Unknown' THEN 1 END) as rating_unknown,
    COUNT(CASE WHEN premiered = 'Unknown' THEN 1 END) as premiered_unknown,
    COUNT(*) as total_rows_with_any_unknown
FROM anime;

-- PASSO 3: Executar em TRANSACTION (seguro)
BEGIN TRANSACTION;

-- Atualizações individuais (mais seguro para rollback)
UPDATE anime SET name = NULL WHERE name = 'Unknown';
UPDATE anime SET english_name = NULL WHERE english_name = 'Unknown';
UPDATE anime SET japanese_name = NULL WHERE japanese_name = 'Unknown';
UPDATE anime SET "type" = NULL WHERE "type" = 'Unknown';
UPDATE anime SET aired = NULL WHERE aired = 'Unknown';
UPDATE anime SET "source" = NULL WHERE "source" = 'Unknown';
UPDATE anime SET rating = NULL WHERE rating = 'Unknown';
UPDATE anime SET premiered = NULL WHERE premiered = 'Unknown';

-- PASSO 4: Verificar resultado
SELECT 'Verificação pós-update:' as etapa;
SELECT 
    COUNT(CASE WHEN name = 'Unknown' THEN 1 END) as name_unknown_remaining,
    COUNT(CASE WHEN english_name = 'Unknown' THEN 1 END) as english_unknown_remaining,
    COUNT(CASE WHEN japanese_name = 'Unknown' THEN 1 END) as japanese_unknown_remaining,
    COUNT(CASE WHEN "type" = 'Unknown' THEN 1 END) as type_unknown_remaining,
    COUNT(CASE WHEN aired = 'Unknown' THEN 1 END) as aired_unknown_remaining,
    COUNT(CASE WHEN "source" = 'Unknown' THEN 1 END) as source_unknown_remaining,
    COUNT(CASE WHEN rating = 'Unknown' THEN 1 END) as rating_unknown_remaining,
    COUNT(CASE WHEN premiered = 'Unknown' THEN 1 END) as premiered_unknown_remaining 
FROM anime;

-- PASSO 5: Se tudo ok, COMMIT; se não, ROLLBACK;
-- COMMIT;  -- Descomente apenas quando certeza
-- ROLLBACK; -- Descomente se algo deu errado