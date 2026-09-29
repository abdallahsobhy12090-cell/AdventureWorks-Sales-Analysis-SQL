SELECT * FROM SALES.Customer
SELECT * FROM SALES.SalesOrderDetail
SELECT * FROM SALES.SalesOrderHeader

SELECT   SalesOrderID , orderdate ,subtotal
from SALES.Customer c , SALES.SalesOrderHeader o --alise name
where c.CustomerID = o.CustomerID
order by c.CustomerID desc ;

-- اللهم صلي وسلم علي سيدنا محمد وعلي اله وصحبه وسلم 


select  customerid,salesordernumber,o.salesorderid, subtotal,p.productid,unitprice,name,color,standardcost
from sales.SalesOrderDetail o , sales.SalesOrderHeader h , Production.Product p
where o.salesorderid = h.salesorderid and o.productid = o.ProductID


select  customerid,salesordernumber,o.salesorderid, subtotal,p.productid,unitprice,name,color,standardcost
from sales.SalesOrderDetail o join sales.SalesOrderHeader h on o.salesorderid = h.salesorderid
join Production.Product p on o.productid = o.ProductID

select color,h.salesorderid , p.productid , h.orderdate , p.name, listprice
from Sales.SalesOrderHeader h join  Sales.SalesOrderDetail o on o.SalesOrderID = h.SalesOrderID 
join Production.Product p
 on o.ProductID = p.ProductID

 ------- join --------- on (condation) 
 --join  ------ on (condation 2) 


 select  c.customerid, p.productid
 from sales.customer c join sales.salesorderheader h on 
 c.customerid = h.CustomerID join sales.salesorderdetail o on
 o.salesorderid=h.salesorderid join Production.product p on
 o.productid=p.productid
 

 select c.customerid, p.productid
 from sales.customer c , sales.salesorderheader h , sales.salesorderdetail o, Production.product p
 where c.customerid = h.CustomerID and 
 o.salesorderid=h.salesorderid and
 o.productid=p.productid

 select avg(listprice) as "avg listprice" from Production.product


 select count(h.SalesOrderid) from sales.SalesOrderHeader h
 where totaldue>10000

  select sum(h.SalesOrderid) from sales.SalesOrderHeader h
 where totaldue>10000

SELECT 
    CASE 
        WHEN TotalDue >= 100000 THEN ' عالي'
        WHEN TotalDue >= 30000 THEN ' متوسط'
        WHEN TotalDue >= 5000 THEN ' منخفض'
        ELSE ' صغير ' 
    END AS [تصنيف الفاتورة],
    
    COUNT(SalesOrderID) AS [عدد الأوردرات]

FROM Sales.SalesOrderHeader

GROUP BY 
    CASE 
        WHEN TotalDue >= 100000 THEN ' عالي'
        WHEN TotalDue >= 30000 THEN ' متوسط'
        WHEN TotalDue >= 5000 THEN ' منخفض'
        ELSE ' صغير ' 
    END;



select 
  case 
    when totaldue > 5000 then 'high'
    when totaldue > 1000 then 'mid'
 else 'low'
 end as categorzing
 from sales.SalesOrderHeader  

 group by case 
      when totaldue > 5000 then 'high'
    when totaldue > 1000 then 'mid'
 else 'low'
 END

 select ProductModelID , count(*) العدد , max(listprice) الاعلي  , min (listprice) الاسفل  , avg(listprice) المتوسط
 from production.product p
 group by ProductModelId ;

 

 select c.name ,  count(*) العدد  , max(listprice) الاعلي  , min (listprice) kareem  , avg(listprice) المتوسط 
 from production.ProductSubcategory c join production.product p
on c.ProductSubcategoryid  = p.ProductSubcategoryid
 group by c.name
 having count(*) > 10


































































 -- windows functionس

select SalesOrderID , CustomerID , OrderDate,TotalDue,
Sum(TotalDue) Over(Partition by CustomerID) as CustomrTotalRevenue
from Sales.SalesOrderHeader


select SalesOrderID , CustomerID , TotalDue,
Row_number() Over(Order by totaldue Desc) as Rownumber
from Sales.SalesOrderHeader
 
SELECT 
    c.Name  ,
    p.Name  ,
    p.ListPrice AS ,
    ROW_NUMBER() OVER(PARTITION BY c.Name ORDER BY p.ListPrice DESC) 
FROM SalesLT.Product p
JOIN SalesLT.ProductCategory c ON p.ProductCategoryID = c.ProductCategoryID;