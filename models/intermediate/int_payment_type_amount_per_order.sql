{# declaration of payment_type variable. Add here if a new one appears #}
{%- set payment_types = get_payment_types() -%}

WITH 

payments AS (
    SELECT * FROM {{ ref('stg_stripe_order_payments') }}
),

pivot_and_aggregate_payments_to_order_grain AS (

SELECT 
    order_id,
    {% for payment_type in payment_types -%}

    sum(
        case
            when payment_type = '{{ payment_type }}' AND
                status = 'success'
            then amount
            else 0
        end
    ) AS {{ payment_type }}_amount,

    {% endfor %}
    sum(case when status = 'success' then amount end) as total_amount

FROM payments
GROUP BY 1

)

SELECT * FROM pivot_and_aggregate_payments_to_order_grain