--Abdullah Sobhy (kpi's) : 

--1. Total profit margin .
--2. Revenue by category .
--3. Product demand volume .
--4. Discount impact . 

---------------------------------------------
----------  بسم الله الرحمن الرحيم ----------

--1. "Total profit margin" (هنحسب هنا بإذن الله اجمالي هامش الربح (سعر البيع - التكلفه الاساسيه 


SELECT * FROM SALES.SalesOrderDetail
SELECT * FROM Production.product

-- هنا حسبنا اجمالي هامش الربح لكل سطر ف الفاتوره 

select name , p.productid ,  unitprice , standardcost ,OrderQty, (unitprice - standardcost) * OrderQty as "Total Profit Margin"
from SALES.SalesOrderDetail o JOIN Production.product p
ON p.ProductID = o.ProductID

-- هنا حسبنا اجمالي هامش الربح لكل منتج عن طريق الاسم 

select name , SUM((unitprice - standardcost) * OrderQty) as "Total Profit "
from SALES.SalesOrderDetail o JOIN Production.product p
ON p.ProductID = o.ProductID
Group by name ;

-- هنا جبنا اكتر 10 منتجات بتكسب الشركة 

select Top 10 
name , SUM((unitprice - standardcost) * OrderQty) as "Total Profit "
from SALES.SalesOrderDetail o JOIN Production.product p
ON p.ProductID = o.ProductID
Group by name
order by  [Total Profit ] DESC ;


-- هنا جبنا كل المنتجات ال الشركه بتخسر فيها 

select name , SUM((unitprice - standardcost) * OrderQty) as "Total Profit "
from SALES.SalesOrderDetail o JOIN Production.product p
ON p.ProductID = o.ProductID
Group by name
Having SUM((unitprice - standardcost) * OrderQty) < 0 ;

-- "TOTAL PROFIT MARGIN - GRAND TOTAL" هنا جبنا اجمالي ارباح الشركة كلها 

SELECT 
SUM((unitprice - standardcost) * OrderQty) as "Total Profit Margin"
FROM sales.salesorderdetail O Join Production.product P
ON O.ProductID = P.ProductID


-------------------------------------------------

--2. "Revenue by category" هنقيس هنا بإذن الله اجمالي الايرادات (الفلوس الاجماليه ال دخلت الشركه مش صافي الربح )الموزعة علي الاقسام الرئيسيه 

SELECT * FROM SALES.SalesOrderDetail 
SELECT * FROM PRODUCTION.ProductCategory
SELECT * FROM PRODUCTION.ProductSubcategory
SELECT * FROM PRODUCTION.Product

-- هنا جبنا ايرادات كل قسم رئيسي ف كل فاتوره
SELECT	PC.Name , (unitprice * orderQty) as "Total Revenue" 
FROM PRODUCTION.ProductSubcategory PS JOIN PRODUCTION.ProductCategory PC
ON ps.ProductCategoryID = pc.ProductCategoryID JOIN PRODUCTION.Product P
ON ps.ProductSubcategoryID = p.ProductSubcategoryID JOIN SALES.SalesOrderDetail O
ON o.ProductID = p.ProductID

-- جبنا هنا ايرادات الاربع اقسام الرئيسيه ورتبناهم من حيث الاعلي ايراد للاقل 
SELECT	PC.Name , SUM((unitprice * orderQty)) as "Total Revenue" 
FROM PRODUCTION.ProductSubcategory PS JOIN PRODUCTION.ProductCategory PC
ON ps.ProductCategoryID = pc.ProductCategoryID JOIN PRODUCTION.Product P
ON ps.ProductSubcategoryID = p.ProductSubcategoryID JOIN SALES.SalesOrderDetail O
ON o.ProductID = p.ProductID
Group by pc.name 
ORDER BY [Total Revenue] DESC;

-- " TOTAL REVENUE " هنا جبنا اجمالي ايردات الشركة لكل الاقسام الرئيسية

SELECT SUM((unitprice * orderQty)) as "Total Revenue" 
FROM PRODUCTION.ProductSubcategory PS JOIN PRODUCTION.ProductCategory PC
ON ps.ProductCategoryID = pc.ProductCategoryID JOIN PRODUCTION.Product P
ON ps.ProductSubcategoryID = p.ProductSubcategoryID JOIN SALES.SalesOrderDetail O
ON o.ProductID = p.ProductID




-------------------------------------------------

--3. "Product demand volume" هنا بإذن الله هنجيب حجم الطلب علي المنتجات (الكميات المباعة من كل منتج) بغض النظر عن سعره
-- لي بقا بغض النظر عن سعره ؟ لان ممكن يكون في منتج سعره رخيص وهامشة ربحه قليل* بس بيتباع ب كميات مهوله ودا مؤشر خطير جدا لازم نحطه ف اعين الاهتمام عشان لازم نوفر منه كميات كبيره عشان ميحصلش عجز ف اي مخزن مثلا ف نزعل العملاء مننا 

SELECT * FROM SALES.SalesOrderDetail
SELECT * FROM Production.product

-- هنا جبنا اسم كل منتج واتبعا منه قد ايه ف كل فاتوره

SELECT P.Name , orderQty 
from SALES.SalesOrderDetail o JOIN Production.product p
ON p.ProductID = o.ProductID

-- هنا جبنا اسم كل منتج واتباع منه قد ايه ورتبناهم من الاكثر مبيعا للاقل بغض النظر عن السعر 

SELECT P.Name , SUM(orderQty) as "Total OrderQty"
from SALES.SalesOrderDetail o JOIN Production.product p
ON p.ProductID = o.ProductID 
Group by p.name 
ORDER BY [Total OrderQty] DESC ;


-- هنا جبنا اعلي 10 منتجات مبيعا 

SELECT TOP 10
P.Name , SUM(orderQty) as "Total OrderQty"
from SALES.SalesOrderDetail o JOIN Production.product p
ON p.ProductID = o.ProductID 
Group by p.name 
ORDER BY [Total OrderQty] DESC ;




-------------------------------------------------

--4. "Discount impact" هنا بإذن الله هنحسب قيمة التخفيضات ونقارن حجم المبيعات قبل الخصم وبعد الخصم وهنشوف هل الخصومات ال بنعملها دي بتعوض ف الكيميات يعني هل المنتجات ال اتعمل عليها خصومات اتلاعت بكميات ضخمه ف عوضت فرق السعر ولا احنا بنبيع عدد ف اللمون حرفيا وبنحرق ع الفاضى 


SELECT * FROM SALES.SalesOrderDetail
SELECT * FROM Production.product


-- هنا بنشوف الخصم لكل منتج ف كل فاتوره اتباع لعميل

SELECT P.Name , UnitPrice , UnitPriceDiscount , OrderQty 
FROM SALES.SalesOrderDetail O JOIN  Production.product P
ON p.ProductID = o.ProductID
ORDER BY [UnitPriceDiscount] DESC ;


-- هنا حسبنا قيمه الخصم الفعلي لكل المنتجات  


SELECT P.Name ,SUM(OrderQty) AS "Total OrderQty" , SUM (UnitPrice * OrderQty) AS "Total Revenue Before Discount" , SUM(UnitPriceDiscount * (UnitPrice * OrderQty)) AS "Discount Amount" 
FROM SALES.SalesOrderDetail O JOIN  Production.product P
ON p.ProductID = o.ProductID
Group by p.name 
ORDER BY [Total Revenue Before Discount] DESC ;


-- اهم كويري حرفيا هنا بنقارن بين حجم المبيعات قبل الخصم وبعد الخصم وبنقارن بين الايرادات قبل الخصم وبعد الخصم ونشوف هل كسبنا ولا خسرنا هل بيعنا اكتر ولا بيعنا اقل هل الخصم فعال فعلا ؟

SELECT 
    P.Name,
    
    -- هل الخصم زود السحب؟
    SUM(CASE WHEN UnitPriceDiscount = 0 THEN OrderQty ELSE 0 END) AS "Qty Without Discount",
    SUM(CASE WHEN UnitPriceDiscount > 0 THEN OrderQty ELSE 0 END) AS "Qty With Discount",
    
    -- هل الفلوس الصافية زادت وقت الخصم؟
    SUM(CASE WHEN UnitPriceDiscount = 0 THEN UnitPrice * OrderQty ELSE 0 END) AS "Revenue (No Discount)",
    SUM(CASE WHEN UnitPriceDiscount > 0 THEN (UnitPrice * OrderQty) - (UnitPriceDiscount * (UnitPrice * OrderQty)) ELSE 0 END) AS "Net Revenue (With Discount)"

FROM SALES.SalesOrderDetail O 
JOIN Production.product P
    ON p.ProductID = o.ProductID
GROUP BY 
    P.Name
ORDER BY 
    "Qty With Discount" DESC;


-- CAP $ VIST



------------------------------------------------
--------------------  الحمد لله ----------------
----------------- " Abdullah Sobhy " -------------