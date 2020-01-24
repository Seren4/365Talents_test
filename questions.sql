\! echo "Combien l'entreprise a-t'elle d'employés?\n";

SELECT COUNT(*) FROM Employee;
-- 8

\! echo "\nQuels sont les 5 principaux pays où se situent les clients de l''entreprise ?\n";
select country, count(*) from Customer group by country ORDER BY count(*) DESC LIMIT 5;
-- USA	13
-- Canada	8
-- France	5
-- Brazil	5
-- Germany	4

\! echo "\nQuel est le client le plus important de l'entreprise ?\n";

select Invoice.CustomerId, Customer.FirstName, Customer.LastName, sum(Invoice.Total) from Invoice
INNER JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
group by CustomerId ORDER BY sum(Total) DESC limit 1;

-- Quel est le total facturé par l'entreprise à chaque client ?
-- select CustomerId, sum(Total) from Invoice group by CustomerId;
-- with details:
\! echo "\nQuel est le total facturé par l'entreprise à chaque client ?\n";

select  Invoice.CustomerId, Customer.LastName, Customer.FirstName, sum(Invoice.Total) from Invoice
INNER JOIN Customer ON Invoice.CustomerId=Customer.CustomerId group by CustomerId order by sum(Invoice.Total) desc;

\! echo "\nQuels sont les artistes favoris de Victor Stevens ?\n";

SELECT Composer, count(Composer) from ( SELECT Track.Composer
FROM Track
INNER JOIN InvoiceLine ON Track.TrackId=InvoiceLine.TrackId
INNER JOIN Invoice ON InvoiceLine.InvoiceId = Invoice.InvoiceId
INNER JOIN Customer ON Invoice.CustomerID=(select CustomerId from Customer where FirstName="Victor" AND LastName="Stevens")
GROUP BY Track.TrackId) as item group by Composer order by count(Composer) DESC;

\! echo "\nQuel est l''artiste favori de Victor Stevens ?\n";

SELECT Composer, count(Composer) from ( SELECT Track.Composer
FROM Track
INNER JOIN InvoiceLine ON Track.TrackId=InvoiceLine.TrackId
INNER JOIN Invoice ON InvoiceLine.InvoiceId = Invoice.InvoiceId
INNER JOIN Customer ON Invoice.CustomerID=(select CustomerId from Customer where FirstName="Victor" AND LastName="Stevens")
GROUP BY Track.TrackId) as item group by Composer order by count(Composer) DESC LIMIT 1;


-- -- Invoice.InvoiceId list for user = Victor Stevens
-- SELECT DISTINCT Invoice.InvoiceId FROM Invoice
-- INNER JOIN Customer ON Invoice.CustomerID=(select CustomerId from Customer where FirstName="Victor" AND LastName="Stevens")
-- INNER JOIN InvoiceLine ON Invoice.InvoiceId=InvoiceLine.InvoiceId;
--
-- -- TrackId list for all InvoiceId
-- SELECT DISTINCT Track.TrackId, Invoice.CustomerID, Invoice.InvoiceId FROM Track
-- INNER JOIN InvoiceLine ON Track.TrackId=InvoiceLine.TrackId
-- INNER JOIN Invoice ON InvoiceLine.InvoiceId=Invoice.InvoiceId
-- INNER JOIN Customer ON Invoice.CustomerID=(select CustomerId from Customer where FirstName="Victor" AND LastName="Stevens");
