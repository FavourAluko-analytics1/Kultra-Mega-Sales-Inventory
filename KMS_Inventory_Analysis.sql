
create database KMS_INVENTORY

select * from [KMS Case Study]

select * from Order_Status


create view vw_KMS_OrderS
as
select
 KMS.[Row_ID],
 KMS.[Order_ID],
 KMS.[Order_Date],
 KMS.[Order_Priority],
 KMS.[Order_Quantity],
 KMS.[Sales],
 KMS.[Discount],
 KMS.Ship_Mode,
 KMS.Profit,
 KMS.Unit_Price,
 KMS.Shipping_Cost,
 KMS.Customer_Name,
 KMS.Province,
 KMS.Region,
 KMS.Customer_Segment,
 KMS.Product_Category,
 KMS.[Product_Sub_Category],
 KMS.[Product_Name],
 KMS.[Product_Container],
 KMS.[Product_Base_Margin],
 KMS.Ship_Date,
 Ord.[Status]
 from [KMS Case Study] as KMS
 inner join Order_Status as Ord
 on KMS.Order_ID = Ord.Order_ID

 KMS = [KMS Case Study]
 Ord = Order_Status

 SELECT * FROM VW_KMS_OrderS

 ------ANALYSIS-----
 ---QUESTION 1.  WHICH PRODUCT CATEGORY HAD THE HIGHEST SALES
 
SELECT top 1 Product_Category, sum(Sales) as Total_Sales
from vw_KMS_OrderS
GROUP BY Product_Category
ORDER BY Total_Sales desc
------ Technology is the Product Category that had the highest Sales----


---QUESTION 2. WHAT ARE THE TOP 3 AND BOTTOM 3 REGION IN TERMS OF SALES

select top 3 Region,sum(Sales) as Total_Sales
from vw_KMS_OrderS
group by Region
ORDER BY Total_Sales desc
-----The top three Regions are Ontario,West and Prarie in terms of Sales---

select top 3 Region,sum(Sales) as Total_Sales
from vw_KMS_OrderS
group by Region
ORDER BY Total_Sales asc
-----The bottom three Regions are Quebec, Yukon and Nunavut in terms of Sales----


---QUESTION 3.  WHAT WERE THE TOTAL SALES OF APPLIANCES IN ONTARIO?
      
      SELECT Region,sum(sales) as Total_Sales
      from vw_KMS_OrderS
      where Region = 'Ontario'
      group by Region
      order by Total_Sales desc
    --------The Total Sales of Appliances in ONTARIO is '471161.63'-------


---QUESTION 4. Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers

select top 10 Row_ID, Customer_Name, sum(Sales) as Total_Sales
from vw_KMS_OrderS
group by Row_ID,Customer_Name
order by Total_Sales asc
       ---- The management of KMS can increase revenue from the bottom 10 customers:
------i. By improving delivery efficiency and customer service experience
------ii. By implementing targeted promotions and personalized marketing strategies to encourage repeat purchases
------iii. By analyzing customer buying patterns to understand product preferences and sales opportunities


---QUESTION 5. KMS incurred the most shipping cost using which shipping method?

SELECT TOP 1 Ship_Mode, sum(Shipping_Cost) as Total_Shipping_Costs
from vw_KMS_OrderS
group by Ship_Mode
order by Total_Shipping_Costs desc
----KMS incurred the most shipping method by using the "Delivery Truck" Shipping method----


---QUESTION 6. Who are the most valuable customers, and what products or services do they typically purchase?

SELECT TOP 5 Customer_Name,Product_Category, sum(Sales) as Total_Sales
from vw_KMS_OrderS
group by Customer_Name,Product_Category
order by Total_Sales desc
---Furniture,Technology and Office Supplies are the category of products that the top 5 valuable customers purchase-----


---QUESTION 7. Which small business customer had the highest sales?

select top 1 Customer_Name, Customer_Segment, sum(sales) as Total_Sales
from vw_KMS_OrderS
where Customer_Segment = 'Small Business'
group by Customer_Name,Customer_Segment
order by Total_Sales desc
----------John Lucas is the small business customer with the highest sales---


---QUESTION 8. Which Corporate Customer placed the most number of orders in 2009 – 2012?

select TOP 1 Customer_Name, Customer_Segment,Order_Date, sum(Order_Quantity) AS Total_Quantity
from vw_KMS_OrderS
where Customer_Segment = 'Corporate' AND Order_Date BETWEEN '2009' AND '2012'
group by Customer_Name,Customer_Segment, Order_Date
order by Total_Quantity desc
--------Lycoris Saunders is the Corporate Customer that placed the most number of sales between year 2009-2012----


---QUESTION 9.  Which consumer customer was the most profitable one? 

select TOP 1 Customer_Name, Customer_Segment, sum(Profit) AS Total_Profit
from vw_KMS_OrderS
where Customer_Segment = 'Consumer' 
group by Customer_Name,Customer_Segment
order by Total_Profit desc
-------Rick Reed is the Consumer Customer that is the most profitable-----


---QUESTION 10.  Which customer returned items, and what segment do they belong to? 

select distinct Customer_Name, Customer_Segment,[Status]
from vw_KMS_OrderS
where [Status] = 'Returned' 
---------419 customers from across the different Customer Segment returned items--------


11 /* QUESTION 11.  If the delivery truck is the most economical but the slowest shipping method and 
         Express Air is the fastest but the most expensive one, do you think the company 
         appropriately spent shipping costs based on the Order Priority? Explain your answer?*/

select Order_Priority,Ship_Mode, sum(Shipping_Cost) as Total_Shipping_Costs
from vw_KMS_OrderS
group by Order_Priority,Ship_Mode
order by Total_Shipping_Costs desc

/* The company did not allocate the shipping costs appropriately based on order priority. The analysis shows that 
 Delivery Truck, which is the slowest and the most economical shipping method was heavily used across multiple 
 order priorities including high and critical orders. While Express Air which is the fastest and the most expensive 
 was under utilized. This suggests that shipping methods were not properly allocated and aligned with order urgency. 
 High and Critical priority orders should ideally use faster shipping methods to improve customer satisfaction and 
 lower priority orders should use more economical and slower shipping methods to reduce cost.*/

SELECT * FROM vw_KMS_OrderS