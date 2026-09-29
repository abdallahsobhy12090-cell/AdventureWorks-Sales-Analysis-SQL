SELECT * FROM SALESLT.Customer
SELECT * FROM SALESLT.SalesOrderDetail
SELECT * FROM SALESLT.SalesOrderHeader

SELECT FirstName + '' + lastname as [full name] , Title , phone , SalesOrderID , orderdate ,subtotal
from SALESLT.Customer c , SALESLT.SalesOrderHeader o --alise name
where c.CustomerID = o.CustomerID
order by c.CustomerID desc ;

-- اللهم صلي وسلم علي سيدنا محمد وعلي اله وصحبه وسلم 


select  customerid,salesordernumber,o.salesorderid, subtotal,p.productid,unitprice,name,color,standardcost
from saleslt.SalesOrderDetail o , saleslt.SalesOrderHeader h , saleslt.Product p
where o.salesorderid = h.salesorderid and o.productid = o.ProductID


select  customerid,salesordernumber,o.salesorderid, subtotal,p.productid,unitprice,name,color,standardcost
from saleslt.SalesOrderDetail o join saleslt.SalesOrderHeader h on o.salesorderid = h.salesorderid
join saleslt.Product p on o.productid = o.ProductID

select color,h.salesorderid , p.productid , h.orderdate , p.name, listprice
from SalesLT.SalesOrderHeader h join  SalesLT.SalesOrderDetail o on o.SalesOrderID = h.SalesOrderID 
join saleslt.Product p
 on o.ProductID = p.ProductID

 ------- join --------- on (condation) 
 --join  ------ on (condation 2) 


 select  firstname +' '+ lastname as [fullname] ,c.customerid, p.productid
 from saleslt.customer c join saleslt.salesorderheader h on 
 c.customerid = h.CustomerID join saleslt.salesorderdetail o on
 o.salesorderid=h.salesorderid join saleslt.product p on
 o.productid=p.productid
 

 select  firstname +' '+ lastname as [fullname] ,c.customerid, p.productid
 from saleslt.customer c , saleslt.salesorderheader h , saleslt.salesorderdetail o, saleslt.product p
 where c.customerid = h.CustomerID and 
 o.salesorderid=h.salesorderid and
 o.productid=p.productid

 select avg(listprice) as "avg listprice" from saleslt.product








