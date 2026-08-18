WITH order_payments AS (
    SELECT * FROM {{ ref('stg_stripe_order_payments') }}
)

SELECT 
    order_id,
    sum(
        case
            when payment_type = 'cash' and
            status = 'success'
            then amount
            else 0
        end
    ) as cash_amount,
    sum(
        case
            when payment_type = 'credit' and
                status = 'success'
            then amount
            else 0
        end
    ) as credit_amount,
    sum(case 
            when status = 'success'
            then amount
        end
        ) as total_amount
FROM order_payments
GROUP BY 1