CREATE SCHEMA IF NOT EXISTS DW;

-- Tabela Dimensão Data
create table dim_data(
	data_id int primary key,
	data_completa date,
	estacao_ano varchar(50),
	ano int,
	mes_nome varchar(50)
);
