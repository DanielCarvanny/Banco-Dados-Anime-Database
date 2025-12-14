--Índice da PK animelist
CREATE INDEX idx_animelist_user_anime
ON animelist(user_id, anime_id);