-- ============================================================
-- dim_news
-- Dimension table: one row per news article
-- Grain: ID (unique article identifier)
-- Source: {{ ref('raw_news') }}
-- ============================================================

SELECT
    ID,
    TRIM(UPPER(RELATED))            AS SYMBOL,
    DATETIME::DATE                  AS DATE_KEY,
    DATETIME::TIMESTAMP             AS PUBLISHED_AT,
    HEADLINE,
    CATEGORY,
    SOURCE,
    SUMMARY,
    URL
FROM {{ ref('raw_news') }}
