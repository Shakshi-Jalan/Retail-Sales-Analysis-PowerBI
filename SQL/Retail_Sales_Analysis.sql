create database retail_salesboard_project;

select * from superstore_cleaned_2
order by `Row ID` desc;

select region, round(sum(sales),2) as total_sales, round(sum(profit),2) as total_profit,
 round(avg(discount) ,2) as avgDisc from superstore_cleaned_2
group by region;

select category, sum(sales) as total_sales from superstore_cleaned_2
group by category;

select `Sub-Category`,region, round(sum(sales),2) as total_sales, round(sum(profit),2) as total_profit,
 round(avg(discount) ,2) as avgDisc from superstore_cleaned_2
group by `Sub-Category`, region
order by region, `Sub-Category`;


-- why are we loosing money in the business? sub categories generting loss
select `Sub-Category`, region, sum(profit) as total_profit  from superstore_cleaned_2
group by `Sub-Category`, region
having sum(profit)<0;

-- discount percentage more than 20%
select `Sub-Category`, region, round(avg(discount) ,2)as avgDisc , round(sum(profit),2) as total_profit from superstore_cleaned_2
group by `Sub-Category`, region
having avg(discount)>0.2
order by  region, avgDisc desc;

-- top customers generating highest profits
select `Customer ID`, `Customer Name` , round(sum(profit),2) as total_profits from superstore_cleaned_2
group by `Customer ID`, `Customer Name`
order by total_profits desc
limit 10;

-- sales by year
SELECT 
  YEAR(STR_TO_DATE(`Order Date`, '%d-%m-%Y')) AS year,
  SUM(Sales) AS sales,
  SUM(Profit) AS profit
FROM superstore_cleaned_2
GROUP BY YEAR(STR_TO_DATE(`Order Date`, '%d-%m-%Y'));

-- profit margin
select sum(profit)/sum(sales)*100 as profit_margin from superstore_cleaned_2;
 
 --  monthly sales
 select month (str_to_date (`Order Date`, '%d-%m-%Y')) as month, sum(sales) as sales ,
 sum(profit) as profit from superstore_cleaned_2
 group by month (str_to_date (`Order Date`, '%d-%m-%Y'))
 order by month;
 
 -- At what discount do we start losing money?
 SELECT 
  Discount,
  SUM(Sales) AS sales,
  SUM(Profit) AS profit,
  (SUM(Profit)/SUM(Sales))*100 AS profit_margin
FROM superstore_cleaned_2
GROUP BY Discount
ORDER BY Discount;
 -- so conclusion is that discount>=30%, business is losing money
 
 -- which product is generating profit and which is producing loss?
  SELECT 
  `Product Name`,
  SUM(Sales) AS sales,
  SUM(Profit) AS profit,
  (SUM(Profit)/SUM(Sales))*100 AS profit_margin
FROM superstore_cleaned_2
GROUP BY `Product Name`;

-- category wise  profit margin?
  SELECT category,
  (SUM(Profit)/SUM(Sales))*100 AS profit_margin
FROM superstore_cleaned_2
GROUP BY category;

-- no. of orders per customer
select `customer id`, `customer name`, count(distinct(`order id`)) as total_orders 
from superstore_cleaned_2
group by `customer id`, `customer name`
order by total_orders desc;

-- no.of repeat customers
select count(*) as repeat_customers from 
(select `customer id`, `customer name`
from superstore_cleaned_2
group by `customer id`, `customer name` 
having count(distinct(`order id`))>1) as t;

-- toal customers
select count(distinct(`customer id`)) as total_customers from superstore_cleaned_2;

--   repeat customer rate
select  (repeat_customers*100 / total_customers)as repeat_customer_rate  from 
(select count(distinct(`customer id`)) as total_customers from superstore_cleaned_2) as a
cross join
(select count(*) as repeat_customers from 
(select `customer id`
from superstore_cleaned_2
group by `customer id`, `customer name` 
having count(distinct `order id`)> 1) as t) as c;

-- customer segmentation
select  `customer id`, count(distinct `order id`) as total_orders,
case when count(distinct `order id`)>3 then 'loyal customer' 
when  count(distinct `order id`)=1 then 'one time buyer'
else 'occasional buyer' 
end as cust_segment
from superstore_cleaned_2
group by `customer id`;

-- number of customers in each segment
select cust_segment, count(*) as customerCount from 
(select  `customer id`, count(distinct `order id`) as total_orders,
case when count(distinct `order id`)>3 then 'loyal customer' 
when  count(distinct `order id`)=1 then 'one time buyer'
else 'occasional buyer' 
end as cust_segment
from superstore_cleaned_2
group by `customer id`)as t
group by cust_segment;

-- average order value
select round( total_sales/total_orders,2 ) as aov from (
select sum(sales) as total_sales,  count(distinct `order id`) as total_orders from superstore_cleaned_2) as t;

-- or (easier method for finding average order value)
select round( sum(sales) /count(distinct `order id`),2) as aov from superstore_cleaned_2;

-- total orders
select count(distinct `order id`) as total_orders from superstore_cleaned_2;

-- state wise sales
select state, round( sum(sales),2) as total_sales from superstore_cleaned_2
group by state
order by total_sales;

-- sales by segment 
select segment, round(sum(sales),2) as sales , round(sum(profit),2) as profit,
round((sum(profit)*100)/sum(sales),2) as profit_margin from superstore_cleaned_2
group by segment
order by sales desc;

-- shipping days
select `order id`, datediff ( str_to_date (`Ship Date`, '%d-%m-%Y') , (str_to_date (`Order Date`, '%d-%m-%Y'))) as
 shipping_days, 
 case when  datediff ( str_to_date (`Ship Date`, '%d-%m-%Y') , (str_to_date (`Order Date`, '%d-%m-%Y')))=1 then'fast' 
 when  datediff ( str_to_date (`Ship Date`, '%d-%m-%Y') , (str_to_date (`Order Date`, '%d-%m-%Y'))) between 2 and 4 then 'normal'
 else 'late'
 end as ship_time
 from superstore_cleaned_2;
 
 -- orders segment as per ship time
 select ship_time , count(*) from (
 select `order id`, datediff ( str_to_date (`Ship Date`, '%d-%m-%Y') , (str_to_date (`Order Date`, '%d-%m-%Y'))) as
 shipping_days, 
 case when  datediff ( str_to_date (`Ship Date`, '%d-%m-%Y') , (str_to_date (`Order Date`, '%d-%m-%Y')))=1 then'fast' 
 when  datediff ( str_to_date (`Ship Date`, '%d-%m-%Y') , (str_to_date (`Order Date`, '%d-%m-%Y'))) between 2 and 4 then 'normal'
 else 'late'
 end as ship_time
 from superstore_cleaned_2) as t
 group by ship_time;
 
 -- orders on basis of ship mode
 select `ship mode`, count(distinct `order id`) as orders,  round(avg(datediff(str_to_date(`ship date` , '%d-%m-%Y')
 ,(str_to_date (`Order Date`, '%d-%m-%Y') ))),2) as shipping_days from superstore_cleaned_2
 group by `ship mode`;
 
 --  customers as per segment in each region
 select segment, region, count(distinct `customer id` ) as numberOfCustomers from superstore_cleaned_2
 group by segment, region
 order by region;
 
 -- top selling products by quantity
 select `product id`, `product name`, sum(quantity) as total_quantity from superstore_cleaned_2
 group by `product id`, `product name`
 order by sum(quantity) desc
 limit 10;
 
 -- top 10 products having lowest profit margin
 select `product id`, `product name`, round(sum(profit)/sum(sales) ,2) as profit_margin
 from superstore_cleaned_2
 group by `product id`, `product name`
 order by round(sum(profit)/sum(sales) ,2) 
 limit 10;
 
 -- top 10 loss making products
 select `product id`, `product name`, round(sum(profit),2) as profit
 from superstore_cleaned_2
 group by `product id`, `product name`
 order by round(sum(profit) ,2) 
 limit 10;
  
  -- list of loss making products
  select `product id`, `product name`, round(sum(profit),2) as loss
 from superstore_cleaned_2
 group by `product id`, `product name`
 having sum(profit) <0
 order by sum(profit);
 
 -- state ranking by profit
 select state, round(sum(profit),2) as profit,
 dense_rank() over (order by sum(profit) desc) as profit_rank
 from superstore_cleaned_2
 group by state;
 
 --  Customer Profitability Segmentation
 select `customer id`, `customer name`, round(sum(profit),2) as total_profit,
 case when (sum(profit))>1000  then 'high profit'
 when (sum(profit))>0  then ' profitable'
 else 'loss' 
 end as cust_profit_segment 
 from superstore_cleaned_2
 group by `customer id`, `customer name`;
 
 -- quantity vs profit in category
 select category, sum(quantity) , round(sum(profit),2) as profits from superstore_cleaned_2
 group by category;
 
 -- year by year growth
 select  years, total_sales, prev_year, total_sales-prev_year as diff from (
 select year(str_to_date(`order date`,'%d-%m-%Y')) as years,
 sum(sales) as total_sales , 
lag(sum(sales)) over ( order by  year(str_to_date(`order date`,'%d-%m-%Y'))) as prev_year
from superstore_cleaned_2
group by year(str_to_date(`order date`,'%d-%m-%Y'))) as t;

-- year by year growth percentage
select  years, total_sales, prev_year,((total_sales-prev_year)*100)/prev_year as growth_percentage from (
 select year(str_to_date(`order date`,'%d-%m-%Y')) as years,
 sum(sales) as total_sales , 
lag(sum(sales)) over ( order by  year(str_to_date(`order date`,'%d-%m-%Y'))) as prev_year
from superstore_cleaned_2
group by year(str_to_date(`order date`,'%d-%m-%Y'))) as t;


-- create view for power bi
CREATE VIEW v_customer_metrics AS
SELECT
    `Customer ID`,
    COUNT(DISTINCT `Order ID`) AS total_orders,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM superstore_cleaned_2
GROUP BY `Customer ID`;
 

