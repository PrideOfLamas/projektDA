--Kolik utr�il ka�d� dodavatel (kter� m� zadanou smlouvu a vypln�nou hodnotu ValueCZK) [CompanyTotal]
--a spo��t� kumulaci do dan�ho ��dku p�es dodavatele tak,
--aby s p�ib�vaj�c�mi ��dky se hodnota [TotalValueCZK] p�i�etla k sum� hodnot 
--z p�ede�l�ch ��dk� v r�mci stejn�ho dodavatele.[RunningTotal]

SELECT
ct.Id AS ContractID,
co.CompanyIN, 
co.Name,
ct.SupplierCompanyIN, 
ct.ValueCZK,
ct.PublishedAtUtc,

  SUM(ct.ValueCZK) OVER (PARTITION BY co.CompanyIN) AS CompanyTotal,
  SUM(co.CompanyIN) OVER () TotalValue,
  SUM(ct.ValueCZK) OVER (PARTITION BY co.CompanyIN ORDER BY co.CompanyIN
                         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM Contract ct
     JOIN Company co ON co.CompanyIN=ct.SupplierCompanyIN
     
