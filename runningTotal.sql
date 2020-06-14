--Kolik utržil každý dodavatel (který má zadanou smlouvu a vyplnìnou hodnotu ValueCZK) [CompanyTotal]
--a spoèítá kumulaci do daného øádku pøes dodavatele tak,
--aby s pøibývajícími øádky se hodnota [TotalValueCZK] pøièetla k sumì hodnot 
--z pøedešlých øádkù v rámci stejného dodavatele.[RunningTotal]

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
     
