-- ============================================================
-- dim_symbols
-- Dimension table: one row per unique stock symbol
-- Grain: SYMBOL
-- Source: {{ ref('raw_stocks') }}
-- ============================================================

SELECT
    SYMBOL,
    MIN(TRADE_DATE)                 AS FIRST_SEEN_DATE,
    MAX(TRADE_DATE)                 AS LAST_SEEN_DATE,
    COUNT(DISTINCT TRADE_DATE)      AS TOTAL_TRADING_DAYS,
    MAX(HIGH)                       AS ALL_TIME_HIGH,
    MIN(LOW)                        AS ALL_TIME_LOW,
    ROUND(AVG(CLOSE), 4)            AS AVG_CLOSE_PRICE,
    ROUND(AVG(VOLUME), 0)           AS AVG_DAILY_VOLUME
FROM {{ ref('raw_stocks') }}
GROUP BY SYMBOL
