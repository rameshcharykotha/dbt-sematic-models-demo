-- models/fct_revenue.sql
with base as (
    select
        order_id,
        order_date,
        product_id,
        customer_id,
        region,
        revenue
    from {{ source('public', 'daily_revenue') }}
)
select * from base
