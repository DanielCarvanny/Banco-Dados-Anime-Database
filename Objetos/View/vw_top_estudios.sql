create or replace view vw_top_estudios as
select 
	st.name as estudio,
	count(distinct a.mal_id) as animes_produzidos,
	round(avg(s.average_score),2) as media_score,
	sum(a.members) as total_fas,
	string_agg(distinct g.name, ', ') as generos_principais
from Studio st
join Anime_Studio ast on st.id = ast.studio_id
join Anime a on ast.anime_id = a.mal_id
join Anime_Genre ag on a.mal_id = ag.anime_id
join Genre g on ag.genre_id = g.id
left join Score s on a.mal_id = s.anime_id
group by st.name
having count(distinct a.mal_id) >= 3
order by animes_produzidos desc, media_score desc;
