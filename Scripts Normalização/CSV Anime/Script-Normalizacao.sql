-- remover a permissão de nulos da coluna mal_id
alter table anime_nao_normalizada alter column mal_id set not null; 

--Alterar a chave primária
alter table anime_nao_normalizada add primary key(mal_id);

-- NORMALIZAÇÃO DA TABELA

-- 1ªFN
create table Licensors(
	"name" text not null unique,
	id int primary key not null
);
-- Definindo a coluna id como auto-incremento
ALTER TABLE Licensors
    ALTER COLUMN id DROP DEFAULT,
    ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;


create table Genre(
	"name" text not null unique,
	id int primary key not null
);
-- Definindo a coluna id como auto-incremento
ALTER TABLE Genre
    ALTER COLUMN id DROP DEFAULT,
    ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;


create table Studio(
	"name" text not null unique,
	id int primary key not null
);
-- Definindo a coluna id como auto-incremento
ALTER TABLE Studio
    ALTER COLUMN id DROP DEFAULT,
    ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;


create table Producer(
	"name" text not null unique,
	id int primary key not null
);
-- Definindo a coluna id como auto-incremento
ALTER TABLE Producer
    ALTER COLUMN id DROP DEFAULT,
    ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;


-- Tabelas Associativas
-- Anime Producers
create table Anime_Producers(
	anime_id int not null,
	producers_id int not null
);
-- Chaves Estrangeiras
	alter table Anime_Producers
		constraint fk_anime_producers_anime foreign key (anime_id) references Anime(mal_id);
	alter table Anime_Producers
		add constraint fk_producer_id foreign key (producers_id) references Producer(id);

-- Chave Primária Composta
	alter table Anime_Producers
		add constraint pk_anime_producers primary key (anime_id, producers_id);


--Anime Licensors
create table Anime_Licensors(
	anime_id int not null,
	licensors_id int not null
);
-- Chaves Estrangeiras
	alter table Anime_Licensors
		add constraint fk_anime_licensors_anime foreign key (anime_id) references Anime(mal_id);
	alter table Anime_Licensors
		add constraint fk_licensors_id foreign key (licensors_id) references Licensors(id);

-- Chave Primária Composta
alter table Anime_Licensors
	add constraint pk_anime_Licensors primary key (anime_id, licensors_id);


-- Anime Studio
create table Anime_Studio(
	anime_id int not null,
	studio_id int not null
);

-- Chaves Estrangeiras
	alter table Anime_Studio
		add constraint fk_anime_studio_anime foreign key (anime_id) references Anime(mal_id);
	alter table Anime_Studio
		add constraint fk_studio_id foreign key (studio_id) references Studio(id);

-- Chave Primária Composta
alter table Anime_Studio
	add constraint pk_anime_Studio primary key (anime_id, studio_id);


-- Anime Genre
create table Anime_Genre(
	anime_id int not null,
	genre_id int not null
);

-- Chaves Estrangeiras
	alter table Anime_Genre
		add constraint fk_anime_genre_anime foreign key (anime_id) references Anime(mal_id);
	alter table Anime_Genre
		add constraint fk_genre_id foreign key (genre_id) references Genre(id);

-- Chave Primária Composta
alter table Anime_Genre
	add constraint pk_anime_Genre primary key (anime_id, genre_id);

-- 3ªFN
create table Score(
	score_1 int,
	score_2 int,
	score_3 int,
	score_4 int,
	score_5 int,
	score_6 int,
	score_7 int,
	score_8 int,
	score_9 int,
	score_10 int,
	score_id int primary key not null,
	ranked int,
	average_score numeric(3,2)
);

ALTER TABLE Score
    ALTER COLUMN score_id DROP DEFAULT,
    ALTER COLUMN score_id ADD GENERATED ALWAYS AS IDENTITY;

-- Adição da coluna anime_id na tabela Score
alter table Score 
add column fk_score_anime int not null unique;

alter table Score
add constraint fk_score_anime foreign key (anime_id) references Anime(mal_id);
