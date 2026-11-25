-- ============================================================
-- fct_daily_weather
-- Fact table: one row per city per observation day
-- Grain: CITY + DATE
-- Source: {{ ref('raw_weather') }}
-- ============================================================

SELECT
    DATE,
    CITY,
    MAX_TEMP,
    MIN_TEMP,
    PRECIP,
    MAX_WIND
FROM {{ ref('raw_weather') }}
