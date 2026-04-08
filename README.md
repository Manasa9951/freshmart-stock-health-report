# FreshMart Stock Health Report

A data-driven SQL project built for FreshMart, a regional supermarket chain 
facing inventory management challenges — overstocking items that don't sell 
and running out of items that do.

# Database
MySQL 8.0+

# Schema
Creates three tables:
- Categories — product categories
- Products — stock items with expiry dates and pricing
- SalesTransactions — record of all sales

# Reports
1. Expiring Soon — products expiring within 7 days with more than 50 units in stock
2. Dead Stock — products with zero sales in the last 60 days
3. Revenue by Category — which category generated the most revenue last month

# How to run
1. Open MySQL Workbench
2. File → Open SQL Script → select the .sql file
3. Press Ctrl + Shift + Enter to run the full script
4. View the three report results in the output panel at the bottom
