--A LEIRAS oszlop értékei:
select  
        count(CASE WHEN LEIRAS IS NOT NULL THEN 1 END) AS 'Üres cellák a leírás oszlopban',
        count(CASE WHEN LEIRAS IS NULL THEN 1 END) AS 'Kitöltött cellák a leírás oszlopban',
        count(CASE WHEN LEIRAS IS NULL THEN 1 END) * 100 / count(*) as 'Üres cellák aránya a kitöltöttekhez (%)'

FROM Termek

--Emberenként a leírás null/nem null adatok felvitelének vizsgálata
SELECT 
    FELVITTE as 'Adatrögzítő neve',
    count(CASE WHEN LEIRAS is null THEN 1 END) AS 'Üres cellák a leírás oszlopban',
    count(CASE WHEN LEIRAS is not null THEN 1 END) AS 'Kitöltött cellák a leírás oszlopban',
    count(CASE WHEN LEIRAS is  null THEN 1 END) * 100 / COUNT(*) AS 'Üres cellák aránya a kitöltöttekhez (%)'
FROM Termek
GROUP BY FELVITTE
ORDER BY FELVITTE

--LISTAÁR MIN/MAX/ÁTLAG
SELECT  MIN(listaar) as 'Listaárak minimuma',
        MAX(listaar) as 'Listaárak maximuma',
        round(AVG(LISTAAR),2) as 'Listaárak átlaga'
FROM Termek

--10 legdrágább kategória
SELECT TOP 10
    KAT_ID AS Kategória, 
    Max(LISTAAR) 'A kategória maximum listaára'
from Termek
WHERE KAT_ID IS NOT null
GROUP BY KAT_ID
ORDER BY Max(LISTAAR) desc

--TOP 10 kategória előfordulások szerint
SELECT top 10
    KAT_ID AS Kategória, 
    COUNT(*) 'Előfordulásának száma'
from Termek
WHERE KAT_ID IS NOT null
GROUP BY KAT_ID
ORDER BY COUNT(*) desc

--Évszakonként ki mennyi adatot vitt fel
SELECT 
    FELVITTE as 'Adatrögzítő személy',
    count(CASE WHEN MONTH(FELVITEL) IN (3,4,5) THEN 1 END) AS 'Tavaszi rögzítések száma',
    count(CASE WHEN MONTH(FELVITEL) IN (6,7,8) THEN 1 END) AS 'Nyári rögzítések száma',
    count(CASE WHEN MONTH(FELVITEL) IN (9,10,11) THEN 1 END) AS 'Őszi rögzítések száma',
    count(CASE WHEN MONTH(FELVITEL) IN (12,1,2) THEN 1 END) AS 'Téli rögzítések száma'
FROM Termek
GROUP BY FELVITTE
ORDER BY FELVITTE

