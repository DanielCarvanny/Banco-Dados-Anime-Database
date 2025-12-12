--Normalização
begin;

alter table anime_with_synopsis 
	alter column MAL_ID set not null;

alter table anime_with_synopsis 
	add constraint fk_aws_MAL_ID foreign key(MAL_ID) 
	references Anime(mal_id);

alter table anime_with_synopsis
	drop column "name";

alter table anime_with_synopsis 
	drop column genres;

alter table anime_with_synopsis 
	drop column score;
