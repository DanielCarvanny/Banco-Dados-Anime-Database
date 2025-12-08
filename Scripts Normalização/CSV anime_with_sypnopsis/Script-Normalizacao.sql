--Normalização
begin;

alter table anime_with_sypnopsis 
	alter column MAL_ID set not null;

alter table anime_with_sypnopsis 
	add constraint fk_aws_MAL_ID foreign key(MAL_ID) 
	references Anime(mal_id);

alter table anime_with_sypnopsis
	drop column "name";

alter table anime_with_sypnopsis 
	drop column genres;

alter table anime_with_sypnopsis 
	drop column score;