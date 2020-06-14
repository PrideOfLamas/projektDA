SELECT 
	Ct. SupplierCompanyIN,
	Co.Name,
	SUM(ct.ValueCZK) AS TotalValue

FROM
	Contract ct
	JOIN Company co ON ct.SupplierCompanyIN = co.CompanyIN

GROUP BY
	ct.SupplierCompanyIN,
	co.Name

ORDER BY
	TotalValue DESC