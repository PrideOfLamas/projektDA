import sys
import sqlite3
import pandas as pd


db = sqlite3.connect(sys.argv[1])
c = db.cursor()

ico = (sys.argv[2], )

query ="""WITH Soucty AS
(
SELECT SupplierCompanyIN, SUM(ValueCZK) AS Celkový_objem_smluv_dodavatele
FROM Contract
GROUP BY SupplierCompanyIN
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

FROM Contract c
JOIN Company sup on sup.CompanyIN = c.SupplierCompanyIN
LEFT JOIN Company buy on buy.CompanyIN = c.BuyerCompanyIN
JOIN Soucty ON Soucty.SupplierCompanyIN = c.SupplierCompanyIN
where sup.CompanyIN = ?
GROUP BY IČO_odběratele
ORDER BY Procentní_podíl DESC, Počet_smluv_odběratele DESC
"""
df = pd.read_sql(query, db, index_col="IČO", params=ico)
print(df)
