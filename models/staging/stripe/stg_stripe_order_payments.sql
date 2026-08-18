
SELECT
    id AS payment_id,
    orderid AS order_id,
    paymentmethod AS payment_method,
    case
        when paymentmethod in ('stripe'
                                , 'paypal'
                                , 'credit_card'
                                , 'gift_card')
        then 'credit'
        else 'cash'
    end as payment_type,
    status,
    amount,
    case
        when status = 'success'
        then true
        else false
    end AS is_completed_payment,
    created as created_date
FROM {{ source('stripe', 'payment')}}