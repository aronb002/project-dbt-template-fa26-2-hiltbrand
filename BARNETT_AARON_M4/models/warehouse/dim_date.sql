-- ============================================================
-- dim_date
-- Dimension table: one row per calendar date
-- Grain: DATE_KEY
-- Source: generated — no source table needed
-- ============================================================
-- Covers earliest raw data (2026-09-15) through 1 year into the future.

WITH date_spine AS (
    SELECT
        DATEADD(DAY, SEQ4(), '2026-01-01'::DATE) AS DATE_KEY
    FROM TABLE(GENERATOR(ROWCOUNT => 365 * 3))
)

SELECT
    DATE_KEY,

    -- Day attributes
    DAYNAME(DATE_KEY)                           AS DAY_OF_WEEK_NAME,
    DAYOFWEEKISO(DATE_KEY)                      AS DAY_OF_WEEK_NUM,
    DAY(DATE_KEY)                               AS DAY_OF_MONTH,

    -- Week / Month / Quarter / Year
    WEEKOFYEAR(DATE_KEY)                        AS WEEK_OF_YEAR,
    MONTH(DATE_KEY)                             AS MONTH_NUM,
    MONTHNAME(DATE_KEY)                         AS MONTH_NAME,
    QUARTER(DATE_KEY)                           AS QUARTER,
    YEAR(DATE_KEY)                              AS YEAR,

    -- Business & calendar flags
    DAYOFWEEKISO(DATE_KEY) IN (6, 7)            AS IS_WEEKEND,
    DAYOFWEEKISO(DATE_KEY) NOT IN (6, 7)        AS IS_WEEKDAY,
    DAYOFWEEKISO(DATE_KEY) NOT IN (6, 7)        AS IS_TRADING_DAY,
    DATE_KEY = LAST_DAY(DATE_KEY, 'MONTH')      AS IS_MONTH_END,
    DATE_KEY = LAST_DAY(DATE_KEY, 'QUARTER')    AS IS_QUARTER_END

FROM date_spine
WHERE DATE_KEY <= CURRENT_DATE() + INTERVAL '1 YEAR'
