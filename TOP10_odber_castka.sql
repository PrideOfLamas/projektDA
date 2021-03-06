SELECT 
	Ct. BuyerCompanyIN,
	Co.Name,
	SUM(ct.ValueCZK) AS TotalValue
FROM
	Contract ct
	JOIN Company co ON ct.BuyerCompanyIN = co.CompanyIN
GROUP BY
	ct.BuyerCompanyIN,
	co.Name

ORDER BY
	TotalValue DESC