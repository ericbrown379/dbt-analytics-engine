WITH customers as (
    SELECT * FROM {{ ref('stg_jaffle_shop_customers')}}
)

SELECT 
    customers.customer_id,
    customers.first_name,
    customers.last_name
FROM customers
