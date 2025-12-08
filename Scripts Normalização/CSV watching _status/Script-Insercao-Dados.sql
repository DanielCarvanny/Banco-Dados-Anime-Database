--Inserção de dados
insert into "Projeto-Anime".watching_status
select status, description 
from csv_w_stts;
