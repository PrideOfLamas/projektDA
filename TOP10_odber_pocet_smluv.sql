SELECT TOP 10
	co.Name,
  ct.BuyerCompanyIN,
	COUNT(ct.Id) AS ConcludedContracts
	

FROM
	Company co
	JOIN Contract ct ON co.CompanyIN = ct.BuyerCompanyIN
GROUP BY
	ct.BuyerCompanyIN,
	co.Name

ORDER BY
	ConcludedContracts DESC