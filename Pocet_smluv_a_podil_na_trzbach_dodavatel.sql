--Vypiš všechny odběratele k jednomu dodavateli
--vypiš objem smluv každého obděratele pro jednoho dodavatele
--vypiš procentní podíl objemu smluv pro každého odběratele pro jednoho dodavatele
WITH Soucty AS
(
SELECT
	SupplierCompanyIN,
	SUM(ValueCZK) AS Celkový_objem_smluv_dodavatele
FROM
	Contract
GROUP BY
	SupplierCompanyIN
)
select 
sup.Name as Dodavatel, 
sup.AddressCity as Sídlo, 
c.SupplierCompanyIN AS IČO, 

buy.Name as Odběratel,
c.BuyerCompanyIN as IČO_odběratele,
COUNT(c.Id) AS Počet_smluv_odběratele,
SUM(c.ValueCZK) AS Objem_smluv,
Celkový_objem_smluv_dodavatele,
100.0 * (SUM(c.ValueCZK) *1.0 / Celkový_objem_smluv_dodavatele) AS Procentní_podíl

from Contract c
join Company sup on sup.CompanyIN = c.SupplierCompanyIN
LEFT join Company buy on buy.CompanyIN = c.BuyerCompanyIN
join Soucty ON Soucty.SupplierCompanyIN = c.SupplierCompanyIN
where sup.CompanyIN = "45309612"

GROUP BY
	IČO_odběratele
ORDER BY
	Procentní_podíl DESC,
	Počet_smluv_odběratele DESC