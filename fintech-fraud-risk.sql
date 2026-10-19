USE fintech_fraud_db;

-- 1. Create table if missing
CREATE TABLE IF NOT EXISTS credit_card_transactions (
    transaction_id INT PRIMARY KEY,
    amount_usd DECIMAL(10, 2),
    merchant_category VARCHAR(50),
    card_type VARCHAR(30),
    auth_method VARCHAR(30),
    channel VARCHAR(30),
    device_type VARCHAR(30),
    is_foreign_transaction BOOLEAN,
    hours_since_last_txn DECIMAL(6, 2),
    txn_count_last_24h INT,
    distance_from_home_km DECIMAL(8, 2),
    card_age_months INT,
    customer_age INT,
    account_balance_usd DECIMAL(12, 2),
    is_new_merchant BOOLEAN,
    used_vpn BOOLEAN,
    ip_country_mismatch BOOLEAN,
    billing_shipping_mismatch BOOLEAN,
    cvv_retry_count INT,
    velocity_score DECIMAL(5, 2),
    time_of_day_hour INT,
    day_of_week INT,
    is_ai_generated_scam_attempt BOOLEAN,
    merchant_risk_score DECIMAL(5, 2),
    prior_disputes INT,
    is_fraud INT
);
USE fintech_fraud_db;

WITH RankedTransactions AS (
    SELECT 
        transaction_id,
        amount_usd,
        merchant_category,
        txn_count_last_24h,
        velocity_score,
        PERCENT_RANK() OVER (PARTITION BY merchant_category ORDER BY velocity_score DESC) as velocity_percentile,
        is_fraud
    FROM credit_card_fraud_2026
)
SELECT 
    transaction_id,
    amount_usd,
    merchant_category,
    txn_count_last_24h,
    velocity_score,
    is_fraud,
    CASE 
        WHEN velocity_percentile >= 0.95 THEN 'Critical Risk'
        WHEN velocity_percentile >= 0.85 THEN 'High Risk'
        ELSE 'Normal'
    END AS risk_tier
FROM RankedTransactions
WHERE velocity_percentile >= 0.85
ORDER BY velocity_score DESC;
USE fintech_fraud_db;

SELECT 
    device_type,
    used_vpn,
    COUNT(*) as total_transactions,
    SUM(is_fraud) as total_fraud_cases,
    ROUND((SUM(is_fraud) / COUNT(*)) * 100, 2) as fraud_rate_percentage,
    ROUND(AVG(amount_usd), 2) as avg_transaction_amount
FROM credit_card_fraud_2026
GROUP BY device_type, used_vpn
ORDER BY fraud_rate_percentage DESC;