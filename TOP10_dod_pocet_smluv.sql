SELECT TOP 10
	Ct. SupplierCompanyIN,
	Co.Name,
	COUNT(ct.Id) AS CountContractsSupplier
  
FROM
	Contract ct
	JOIN Company co ON ct.SupplierCompanyIN = co.CompanyIN

GROUP BY
	ct.SupplierCompanyIN,
	co.Name

ORDER BY
	CountContractsSupplier DESC