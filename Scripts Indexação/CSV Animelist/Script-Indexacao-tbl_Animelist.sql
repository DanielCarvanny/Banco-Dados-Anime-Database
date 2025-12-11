--Índice da PK animelist_normalizada
CREATE INDEX idx_animelist_normalizada_user_anime
ON animelist_normalizada(user_id, anime_id);