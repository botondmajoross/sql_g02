--A LEIRAS oszlop értékei:
select  
        count(CASE WHEN LEIRAS IS NOT NULL THEN 1 END) AS 'leiras_nem_null_db',
        count(CASE WHEN LEIRAS IS NULL THEN 1 END) AS 'leiras_null_db',
        count(CASE WHEN LEIRAS IS NULL THEN 1 END) * 100 / count(*) as 'leiras_null_ertekek_aranya(%)'

FROM Termek

--Emberenként a leírás null/nem null adatok felvitelének vizsgálata
SELECT 
    FELVITTE as Nev,
    count(CASE WHEN LEIRAS is null THEN 1 END) AS 'Null',
    count(CASE WHEN LEIRAS is not null THEN 1 END) AS 'Nem null',
    count(CASE WHEN LEIRAS is  null THEN 1 END) * 100 / COUNT(*) AS 'Null %-os arány'
FROM Termek
GROUP BY FELVITTE
ORDER BY FELVITTE

--LISTAÁR MIN/MAX/ÁTLAG
SELECT  MIN(listaar) as 'minimum_listaar',
        MAX(listaar) as 'maximum_listaár',
        round(AVG(LISTAAR),2) as 'atlag_listaar'
FROM Termek

--10 legdrágább kategória
SELECT TOP 10
    KAT_ID AS Kategória, 
    Max(LISTAAR) 'Max_listaár'
from Termek
WHERE KAT_ID IS NOT null
GROUP BY KAT_ID
ORDER BY Max(LISTAAR) desc

--TOP 10 kategória előfordulások szerint
SELECT top 10
    KAT_ID AS Kategoria, 
    COUNT(*) Elofordulas
from Termek
WHERE KAT_ID IS NOT null
GROUP BY KAT_ID
ORDER BY COUNT(*) desc

--Évszakonként ki mennyi adatot vitt fel
SELECT 
    FELVITTE as Nev,
    count(CASE WHEN MONTH(FELVITEL) IN (3,4,5) THEN 1 END) AS 'Tavasz',
    count(CASE WHEN MONTH(FELVITEL) IN (6,7,8) THEN 1 END) AS 'Nyar',
    count(CASE WHEN MONTH(FELVITEL) IN (9,10,11) THEN 1 END) AS 'Osz',
    count(CASE WHEN MONTH(FELVITEL) IN (12,1,2) THEN 1 END) AS 'Tel'
FROM Termek
GROUP BY FELVITTE
ORDER BY FELVITTE

