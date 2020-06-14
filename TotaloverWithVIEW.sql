CREATE VIEW TotalTurnover
AS
WITH T AS
(
	SELECT
		co.Name,
		co.CompanyIN,
		co.TurnoverLowerBound,
		co.TurnoverUpperBound,
		ct.PublishedAtUtc,
		ROW_NUMBER() OVER(PARTITION BY co.Name ORDER BY co.TurnoverUpperBound) AS RowNumber
	FROM
		Company co
		LEFT JOIN Contract ct ON co.CompanyIN = ct.SupplierCompanyIN

)
SELECT
	co.Name,
	co.CompanyIN,
	co.TurnoverLowerBound,
	co.TurnoverUpperBound,
	(co.TurnoverUpperBound - co.TurnoverLowerBound) AS DifferenceTurnover
	100.0 - (co.TurnoverLowerBound * 1.0 / co.TurnoverUpperBound) AS PercentageChangeTO
FROM
	T
WHERE
	RowNumber = 1
GROUP BY
	co.CompanyIN ASC
GO