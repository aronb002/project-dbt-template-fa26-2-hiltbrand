-- ============================================================
-- fct_daily_stocks
-- Fact table: one row per stock symbol per trading day
-- Grain: SYMBOL + TRADE_DATE
-- Source: {{ ref('raw_stocks') }}
-- ============================================================

SELECT
    SYMBOL,
    TRADE_DATE,
    OPEN,
    HIGH,
    LOW,
    CLOSE,
    VOLUME,
    (HIGH - LOW)                                                        AS DAILY_RANGE,
    (CLOSE - OPEN)                                                      AS DAILY_CHANGE,
    ROUND(((CLOSE - OPEN) / NULLIF(OPEN, 0)) * 100, 4)                  AS PCT_CHANGE,
    CASE
        WHEN CLOSE > OPEN THEN 'UP'
        WHEN CLOSE < OPEN THEN 'DOWN'
        ELSE 'FLAT'
    END                                                                 AS DIRECTION
FROM {{ ref('raw_stocks') }}
