-- Index: idx_animelist_user_anime

DROP INDEX IF EXISTS public.idx_animelist_user_anime;

CREATE INDEX IF NOT EXISTS idx_animelist_user_anime
    ON public.animelist_normalizada USING btree
    (user_id ASC NULLS LAST, anime_id ASC NULLS LAST)
    TABLESPACE pg_default;