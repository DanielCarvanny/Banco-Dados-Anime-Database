-- Tabela Anime Normalizada
create table Anime(
	mal_id int4 primary key NOT NULL,
	"name" text NULL,
	english_name text NULL,
	japanese_name text NULL,
	"type" varchar(50) NULL,
	episodes int4 NULL DEFAULT 0,
	aired text NULL,
	premiered text NULL,
	"source" varchar(50) NULL,
	duration varchar(50) NULL,
	rating varchar(50) NULL,
	popularity int4 NULL DEFAULT 0,
	members int4 NULL DEFAULT 0,
	favorites int4 NULL DEFAULT 0,
	watching int4 NULL DEFAULT 0,
	completed int4 NULL DEFAULT 0,
	"on-hold" int4 NULL DEFAULT 0,
	dropped int4 NULL DEFAULT 0,
	plan_to_watch int4 NULL
);