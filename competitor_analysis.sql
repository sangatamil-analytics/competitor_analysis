create database CompetitorAnalysis;
use CompetitorAnalysis;

create table company_metrics(
ticker varchar(10) primary key,
company_name varchar(255),
sector varchar(100),
market_cap_billions decimal(15,2),
pe_ratio decimal(10,2),
revenue_growth decimal(10,4),
profit_margin decimal(10,4),
operating_margin decimal(10,4),
roe decimal(10,4),
current_ratio decimal(10,4),
debt_to_equity decimal(10,4),
total_revenue_billions decimal(15,2),
rev_per_employee_k decimal(15,2),
employee_count int)

select * from company_metrics


-- High Growth Filtering

select company_name,
revenue_growth,profit_margin
from company_metrics
where revenue_growth >0.10 and profit_margin >0.05

-- Efficiency leaderboard

select company_name,rev_per_employee_k,
rank() over(order by rev_per_employee_k desc) as efficeincy_rank
from company_metrics

-- Management Effectiveness

select company_name,roe,
case 
    when roe > 0.30 then 'Elite Efficiency'
    when roe between 0.15 and 0.30 then 'High Efiiceincy'
    else 'Standard Efficiency'
end as capital_performance
from company_metrics
order by roe desc    

-- Operating Vs Net

select company_name,
operating_margin,
profit_margin,
(operating_margin-profit_margin) as tax_and_dept_impact
from company_metrics
order by tax_and_dept_impact desc

-- Revenue Ranking

select company_name,
total_revenue_billions,
(market_cap_billions/total_revenue_billions) as price_to_sales_ratio 
from company_metrics
order by price_to_sales_ratio