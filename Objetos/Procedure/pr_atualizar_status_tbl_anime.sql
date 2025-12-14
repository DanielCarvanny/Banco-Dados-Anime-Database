CREATE OR REPLACE PROCEDURE pr_atualizar_status_tbl_anime()
LANGUAGE plpgsql
AS $$
BEGIN

    UPDATE anime a 
    SET
        watching       = COALESCE(sub.watching, 0),
        completed      = COALESCE(sub.completed, 0),
        "on-hold"      = COALESCE(sub."on-hold", 0),
        dropped        = COALESCE(sub.dropped, 0),
        plan_to_watch  = COALESCE(sub.plan_to_watch, 0)
    FROM (
        SELECT
            al.anime_id,
            COUNT(*) FILTER (WHERE ws.description = 'Currently Watching') AS watching,
            COUNT(*) FILTER (WHERE ws.description = 'Completed')          AS completed,
            COUNT(*) FILTER (WHERE ws.description = 'On Hold')            AS "on-hold",
            COUNT(*) FILTER (WHERE ws.description = 'Dropped')            AS dropped,
            COUNT(*) FILTER (WHERE ws.description = 'Plan to Watch')      AS plan_to_watch
        FROM animelist al
        JOIN watching_status ws
            ON al.watching_status = ws.id_status
        GROUP BY al.anime_id
    ) sub
    WHERE a.mal_id = sub.anime_id;

END;
$$;