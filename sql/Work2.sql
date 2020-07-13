select * from FactPredict
delete from FactPredict


exec pSavePredict '2017-2018', 'Англия', 'Премьер-лига', 28, '2018-02-24', 'Бернли', 'Саутгемптон', 1, 1, 0.3126, 0.2874, 0.4001, NULL, NULL, 1, NULL 
go 
exec pSavePredict '2017-2018', 'Англия', 'Премьер-лига', 28, '2018-02-24', 'Брайтон & Хоув', 'Суонси', 0, 1, 0.3412, 0.3087, 0.3501, NULL, NULL, 1, NULL 
go 

alter table FactPredict add DateCreate datetime

select Tour, Count(*), sum(case when GoalHome is not null then 1 else 0 END) 
from FactResult where Country = 'Англия' AND Season = '2017-2018' 
group by Tour
order by Tour