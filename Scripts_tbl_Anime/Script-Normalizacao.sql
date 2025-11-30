-- remover a permissão de nulos da coluna mal_id
alter table Anime alter column mal_id set not null; 

--Alterar a chave primária
alter table Anime add primary key(mal_id);

-- NORMALIZAÇÃO DA TABELA
-- 1ªFN
create table Licensors(
	name text,
	id int primary key not null
);
ALTER TABLE Licensors
    ALTER COLUMN id DROP DEFAULT,
    ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;


create table Genre(
	name text,
	id int primary key not null
);
ALTER TABLE Genre
    ALTER COLUMN id DROP DEFAULT,
    ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;


create table Studio(
	name text,
	id int primary key not null
);
ALTER TABLE Studio
    ALTER COLUMN id DROP DEFAULT,
    ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;


create table Producer(
	name text,
	id int primary key not null
);
ALTER TABLE Producer
    ALTER COLUMN id DROP DEFAULT,
    ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;


-- Tabelas Associativas
-- Anime Producers
create table Anime_Producers(
	anime_id int not null,
	producers_id int not null
);
alter table Anime_Producers
add constraint fk_mal_id foreign key (anime_id) references Anime(mal_id);
alter table Anime_Producers
add constraint fk_producer_id foreign key (producers_id) references Producer(id);

--Anime Licensors
create table Anime_Licensors(
	anime_id int not null,
	licensors_id int not null
);
alter table Anime_Licensors
add constraint fk_mal_id foreign key (anime_id) references Anime(mal_id);
alter table Anime_Licensors
add constraint fk_licensors_id foreign key (licensors_id) references Licensors(id);

-- Anime Studio
create table Anime_Studio(
	anime_id int not null,
	studio_id int not null
);
alter table Anime_Studio
add constraint fk_mal_id foreign key (anime_id) references Anime(mal_id);
alter table Anime_Studio
add constraint fk_studio_id foreign key (studio_id) references Studio(id);

-- Anime Genre
create table Anime_Genre(
	anime_id int not null,
	genre_id int not null
);
alter table Anime_Genre
add constraint fk_mal_id foreign key (anime_id) references Anime(mal_id);
alter table Anime_Genre
add constraint fk_genre_id foreign key (genre_id) references Genre(id);


-- 3ªFN
create table Score(
	"score-1" int,
	"score-2" int,
	"score-3" int,
	"score-4" int,
	"score-5" int,
	"score-6" int,
	"score-7" int,
	"score-8" int,
	"score-9" int,
	"score-10" int,
	score_id int primary key not null,
	ranked int,
	score numeric(3,2)
);
ALTER TABLE Score
    ALTER COLUMN score_id DROP DEFAULT,
    ALTER COLUMN score_id ADD GENERATED ALWAYS AS IDENTITY;

-- Tabela Normalizada
create table Anime(
	mal_id int4 primary key NOT NULL,
	"name" text NULL,
	english_name text NULL,
	japanese_name text NULL,
	"type" varchar(50) NULL,
	episodes int4 NULL,
	aired varchar(50) NULL,
	premiered text NULL,
	"source" varchar(50) NULL,
	duration varchar(50) NULL,
	rating varchar(50) NULL,
	popularity int4 NULL,
	members int4 NULL,
	favorites int4 NULL,
	watching int4 NULL,
	completed int4 NULL,
	"on-hold" int4 NULL,
	dropped int4 NULL,
	plan_to_watch int4 NULL
);

-- Adição da coluna anime_id na tabela Score
alter table Score 
add column anime_id int not null;

alter table Score
add constraint fk_mal_id foreign key (anime_id) references Anime(mal_id);