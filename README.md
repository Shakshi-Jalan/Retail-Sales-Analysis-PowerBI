# Retail-Sales-Analysis-PowerBI
Retail Sales Analysis Dashboard using SQL and Power BI
## Project overview:
This project analyzes a retail sales dataset using SQL and Power BI to uncover business insights related to sales, profitability, customers, products, and shipping performance.
The goal is to help businesses make data-driven decisions by identifying profitable regions, loyal customers, loss-making products, and operational trends.

##  Tools Used:
- Power BI
- MySQL
- Microsoft Excel
- DAX
- GitHub

## Process:
1️⃣ Data Exploration (SQL):
Exploratory SQL queries were written against the retail_salesboard_project database to answer specific business questions, including regional/category sales and profit performance, loss-making sub-categories and products, the relationship between discount levels and profitability, customer order frequency and repeat behavior, and shipping performance by mode. A SQL view (v_customer_metrics) was also created for clean integration with Power BI.

2️⃣ Data Modeling (Power BI / DAX):
The dataset was imported into Power BI, where DAX measures were built to recreate and extend the SQL logic (profit margin, AOV, repeat customer rate, discount gap analysis). A summarized CustomerSegments table was created to classify customers by loyalty (Loyal / Occasional / One-Time) and profitability (High Profit / Profitable / Loss-Making). Calculated columns were also added for shipping-time classification (Fast / Normal / Late).

3️⃣ Dashboard Design:
A 5-page interactive report was built, each page focused on a specific business question, with synced slicers (Region, Category, Segment, Year) for consistent cross-page filtering.

## Dashboard Pages:
1️⃣ Executive Overview:
Total Sales, Total Profit, Total Orders, Total Customers, Profit Margin, AOV
Sales & Profit trend by Region and Year
Sales by Segment
Profit by Sub-Category
Profit Margin vs. Discount relationship

2️⃣ Profit Analysis:
Top loss-making products
Loss-making sub-categories
Profit by Region and Category
Loss-making states

3️⃣ Discount & Pricing Analysis:
Average discount by product and sub-category
Discount vs. Margin vs. Sales bubble chart (by sub-category)
Discount gap between loss-making and profitable products

4️⃣ Customer Analysis:
Customer segmentation (Loyal / Occasional / One-Time)
Customer profitability segmentation (High Profit / Profitable / Loss-Making)
Top loyal customers by profit
Customer distribution by segment and region

5️⃣ Operations & Shipping Analysis:
Average shipping days and late shipment percentage
Shipping performance and profit/sales by ship mode
Late shipment trend by year

 ## Key Business Insights:
1️⃣ Discounting is the primary driver of unprofitability. Loss-making products carry an average discount of 48%, vs. just 8% for profitable products - a ~40 point gap. Margins consistently turn negative once discount exceeds roughly 30%.

2️⃣ Losses are concentrated in 3 sub-categories - Tables, Bookcases, and Supplies — all carrying above-average discounts. Binders is a notable exception: heavily discounted (~37%) yet still profitable, showing discount sensitivity varies by product.

3️⃣ Loss-making products fall into two distinct groups with no overlap: high-volume products bleeding cash steadily, and low-volume products with structurally broken pricing so, these need different fixes.

4️⃣ Losses are geographically concentrated, with Texas, Ohio, and Pennsylvania driving the largest dollar losses by state.

5️⃣ Nearly 1 in 5 customers (~20%) are unprofitable overall, despite a very high repeat purchase rate (~98%) — repeat buying doesn't guarantee profitability.

6️⃣ Shipping reliability is declining. Late shipments rose ~62% from 2014 to 2017 (406 → 657), slightly outpacing sales growth (~52%) over the same period.

7️⃣ Standard Class is the most-used and slowest shipping mode, and drives the majority of both sales and profit.

## Business Recommendations:
1️⃣ Limit or redesign discount policies for Tables, Bookcases, and Supplies, as profitability declines sharply when discounts exceed 30%.

2️⃣Identify products with consistently negative profit margins and evaluate whether to reprice, bundle, or discontinue low-performing items.

3️⃣For products that sell in high quantities but generate losses, investigate supplier costs, procurement contracts, or operational expenses instead of relying solely on discount reductions.

4️⃣Analyze purchasing patterns of loyal but unprofitable customers and review pricing, discount eligibility, or product mix to improve overall customer profitability.

5️⃣Monitor Standard Class shipments more closely and optimize logistics to reduce late deliveries, improve customer satisfaction, and control shipping-related costs.

## Dashboard Preview:
### Executive Overview
https://github.com/Shakshi-Jalan/Retail-Sales-Analysis-PowerBI/blob/main/Screenshots/Executive_overview.png?raw=true

### Profit Analysis
https://github.com/Shakshi-Jalan/Retail-Sales-Analysis-PowerBI/blob/main/Screenshots/Profit_analysis.png?raw=true

### Discount and Pricing Analysis
https://github.com/Shakshi-Jalan/Retail-Sales-Analysis-PowerBI/blob/main/Screenshots/Discount_and_pricing_analysis.png?raw=true

### Customer Analysis
https://github.com/Shakshi-Jalan/Retail-Sales-Analysis-PowerBI/blob/main/Screenshots/Customer_analysis.png?raw=true

### Operations and Shipping Analysis
https://github.com/Shakshi-Jalan/Retail-Sales-Analysis-PowerBI/blob/main/Screenshots/Operations_and_shipping_analysis.png?raw=true

## Project Structure:
Retail-Sales-Analysis-PowerBI
│
├── Dashboard
├── Dataset
├── SQL
├── Screenshots
└── README.md

## Skills Demonstrated:
-SQL 
-Power BI & DAX 
-Data Cleaning & Modeling
-Data Visualization & Dashboard Design
-Business Intelligence & Root-Cause Analysis
-Business Communication and Insight Storytelling
