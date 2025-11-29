-- remover a permissão de nulos da coluna mal_id
alter table Anime alter column mal_id set not null; 

--Alterar a chave primária
alter table Anime add primary key(mal_id);