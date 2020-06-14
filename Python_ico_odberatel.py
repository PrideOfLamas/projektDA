import sys
import sqlite3
import pandas as pd
import matplotlib.pyplot as plt

db = sqlite3.connect(sys.argv[1])
c = db.cursor()

ico = (sys.argv[2], )

query ="""select sup.Name as Dodavatel, sup.AddressCity as Sídlo, c.BuyerCompanyIN AS IČO, 
COUNT(c.Id) AS Počet_smluv_celkem, 
SUM(CASE WHEN CAST(strftime ("%Y",PublishedAtUtc) AS decimal) = 2019 THEN 1 ELSE 0 END) AS Počet_smluv_2019, 
SUM(CASE WHEN CAST(strftime ("%Y",PublishedAtUtc) AS decimal) = 2018 THEN 1 ELSE 0 END) AS Počet_smluv_2018, SUM(c.ValueCZK) as Celkový_objem_smluv,
SUM(CASE WHEN CAST(strftime ("%Y",PublishedAtUtc) AS decimal) = 2018 THEN c.ValueCZK ELSE 0 END) AS Objem_smluv_2018,
SUM(CASE WHEN CAST(strftime ("%Y",PublishedAtUtc) AS decimal) = 2019 THEN c.ValueCZK ELSE 0 END) AS Objem_smluv_2019
from Contract c join Company sup on sup.CompanyIN = c.BuyerCompanyIN
where sup.CompanyIN = ? """

df = pd.read_sql(query, db, index_col="IČO", params=ico)
print(df)
