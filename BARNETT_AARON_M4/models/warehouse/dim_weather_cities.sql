-- ============================================================
-- dim_weather_cities
-- Dimension table: one row per financial hub city
-- Grain: CITY
-- Source: {{ ref('raw_weather') }}
-- ============================================================

SELECT
    CITY,
    CASE CITY
        WHEN 'New York' THEN 'NYSE/NASDAQ'
        WHEN 'London' THEN 'LSE'
        WHEN 'Tokyo' THEN 'TSE'
        WHEN 'Frankfurt' THEN 'FWB'
        WHEN 'Hong Kong' THEN 'HKEX'
        ELSE 'Other'
    END                             AS PRIMARY_EXCHANGE,
    MIN(DATE)                       AS FIRST_OBSERVATION_DATE,
    MAX(DATE)                       AS LAST_OBSERVATION_DATE,
    COUNT(DISTINCT DATE)            AS TOTAL_OBSERVATION_DAYS,
    ROUND(AVG(MAX_TEMP), 2)         AS AVG_MAX_TEMP,
    ROUND(AVG(MIN_TEMP), 2)         AS AVG_MIN_TEMP,
    ROUND(AVG(PRECIP), 2)           AS AVG_DAILY_PRECIP,
    ROUND(AVG(MAX_WIND), 2)         AS AVG_MAX_WIND,
    MAX(MAX_TEMP)                   AS HOTTEST_DAY_TEMP,
    MIN(MIN_TEMP)                   AS COLDEST_DAY_TEMP,
    MAX(PRECIP)                     AS WETTEST_DAY_PRECIP
FROM {{ ref('raw_weather') }}
GROUP BY CITY
