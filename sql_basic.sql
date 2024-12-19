-- 問1
-- 国名を全て抽出してください。
SELECT
    name
FROM
    countries
;

-- 問2
-- ヨーロッパに属する国をすべて抽出してください。
SELECT
    name,
    region
FROM
    countries
WHERE
    region LIKE '%Europe'
;

-- 問3
-- ヨーロッパ以外に属する国をすべて抽出してください。
SELECT
    name,
    region
FROM
    countries
WHERE
    region not LIKE '%Europe'
;

-- 問4
-- 人口が10万人以上の国をすべて抽出してください。
SELECT
    name,
    population
FROM
    countries
WHERE
    population >= 100000
;

-- 問5
-- 平均寿命が56歳から76歳の国をすべて抽出してください。
SELECT
    name,
    life_expectancy
FROM
    countries
WHERE
    life_expectancy BETWEEN 56 AND 76
;

-- 問6
-- 国コードがNLB,ALB,DZAのもの市区町村をすべて抽出してください。
SELECT
    name,
    country_code
FROM
    cities
WHERE
    country_code IN ('NLB','ALB','DZA')
;

-- 問7
-- 独立独立記念日がない国をすべて抽出してください。
SELECT
    name,
    indep_year
FROM
    countries
WHERE
    indep_year IS NULL
;

-- 問8
-- 独立独立記念日がある国をすべて抽出してください。
SELECT
    name,
    indep_year
FROM
    countries
WHERE
    NOT indep_year IS NULL
;

-- 問9
-- 名前の末尾が「ia」で終わる国を抽出してください。
SELECT
    name
FROM
    countries
WHERE
    name like '%ia'
;

-- 問10
-- 名前の中に「st」が含まれる国を抽出してください。
SELECT
    name
FROM
    countries
WHERE
    name like '%st%'
;

-- 問11
-- 名前が「an」で始まる国を抽出してください。
SELECT
    name
FROM
    countries
WHERE
    name like 'an%'
;

-- 問12
-- 全国の中から独立記念日が1990年より前または人口が10万人より多い国を全て抽出してください。
SELECT
    name,
    indep_year,
    population
FROM
    countries
WHERE
    indep_year < 1990
    OR population > 100000
;

-- 問13
-- コードがDZAもしくはALBかつ独立記念日が1990年より前の国を全て抽出してください。
SELECT
    name,
    code,
    indep_year
FROM
    countries
WHERE
    code = 'DZA'
OR  code = 'ALB'
AND indep_year < 1990
;

-- 問14
-- 全ての地方をグループ化せずに表示してください。
SELECT
    region
FROM
    countries
;

-- 問15
-- 国名と人口を以下のように表示させてください。シングルクォートに注意してください。
-- 「Arubaの人口は103000人です」
SELECT
    CONCAT(name, 'の人口は', population, '人です') AS message
FROM
    countries
;

-- 問16
-- 平均寿命が短い順に国名を表示させてください。ただしNULLは表示させないでください。
SELECT
    name,
    life_expectancy
FROM
    countries
WHERE
    NOT life_expectancy IS NULL
ORDER BY
    life_expectancy ASC
;

-- 問17
-- 平均寿命が長い順に国名を表示させてください。ただしNULLは表示させないでください。
SELECT
    name,
    life_expectancy
FROM
    countries
WHERE
    NOT life_expectancy IS NULL
ORDER BY
    life_expectancy DESC
;

-- 問18
-- 平均寿命が長い順、独立記念日が新しい順に国を表示させてください。
SELECT
    name,
    life_expectancy,
    indep_year
FROM
    countries
ORDER BY
    life_expectancy DESC,
    indep_year DESC
;

-- 問19
-- 全ての国の国コードの一文字目と国名を表示させてください。
SELECT
    LEFT(code, 1) ,
    name
FROM
    countries
;

-- 問20
-- 国名が長いものから順に国名と国名の長さを出力してください。
SELECT
    name,
    LENGTH(name) AS name_length
FROM
    countries
ORDER BY
    name_length DESC
;

-- 問21
-- 全ての地方の平均寿命、平均人口を表示してください。(NULLも表示)
SELECT
    region,
    AVG(life_expectancy) AS avg_life_expectancy,
    AVG(population) AS avg_population
FROM
    countries
GROUP BY
    region
;

-- 問22
-- 全ての地方の最長寿命、最大人口を表示してください。(NULLも表示)
SELECT
    region,
    MAX(life_expectancy) AS max_life_expectancy,
    MAX(population) AS max_population
FROM
    countries
GROUP BY
    region
;

-- 問23
-- アジア大陸の中で最小の表面積を表示してください
SELECT
    name,
    surface_area
FROM
    countries
WHERE
    continent = 'Asia'
ORDER BY
    surface_area ASC
LIMIT 1
;

-- 問24
-- アジア大陸の表面積の合計を表示してください。
SELECT
    continent,
    SUM(surface_area) 
FROM
    countries
WHERE
    continent = 'Asia'
;

-- 問25
-- 全ての国と言語を表示してください。一つの国に複数言語があると思いますので同じ国名を言語数だけ出力してください。
SELECT
    countries.name,
    countrylanguages.language
FROM
    countries
    JOIN
        countrylanguages
    ON country_code = countrylanguages.country_code
;

-- 問26
-- 全ての国と言語と市区町村を表示してください。
SELECT
    countries.name,
    countrylanguages.language,
    cities.name
FROM
    countries
    JOIN
        countrylanguages
    ON code = countrylanguages.country_code
    JOIN
        cities
    ON code = cities.country_code
;

-- 問27
-- 全ての有名人を出力してください。左側外部結合を使用して国名なし（country_codeがNULL）も表示してください。
SELECT
    celebrities.name,
    countries.name AS countries_name
FROM
    celebrities
    LEFT OUTER JOIN
        countries
    ON  celebrities.country_code = countries.code
;

-- 問28
-- 全ての有名人の名前,国名、第一言語を出力してください。
SELECT
    celebrities.name,
    countries.name,
    countrylanguages.language
FROM
    celebrities
    LEFT OUTER JOIN
        countries
    ON  celebrities.country_code = countries.code
    JOIN
        countrylanguages
    ON  celebrities.country_code = countrylanguages.country_code
;

-- 問29
-- 全ての有名人の名前と国名をに出力してください。 ただしテーブル結合せずサブクエリを使用してください。
SELECT
    celebrities.name,
    (SELECT countries.name
     FROM countries
     WHERE countries.code = celebrities.country_code) AS country_name
FROM
    celebrities
;

-- 問30
-- 最年長が50歳以上かつ最年少が30歳以下の国を表示させてください。
SELECT
    countries.name
FROM
    countries
    JOIN
        celebrities
    ON  countries.code = celebrities.country_code
GROUP BY
    countries.name
HAVING MAX(celebrities.age) >= 50
AND MIN(celebrities.age) <= 30
;

-- 問31
-- 1991年生まれと、1981年生まれの有名人が何人いるか調べてください。ただし、日付関数は使用せず、UNION句を使用してください。
SELECT
    '1991' AS birth_year,
    COUNT('name') AS celebrity_count
FROM
    celebrities
WHERE
    birth LIKE '1991-%'
UNION
SELECT
    '1998' AS birth_year,
    COUNT('name') AS celebrity_count
FROM
    celebrities
WHERE
    birth LIKE '1998-%'
;

-- 問32
-- 有名人の出身国の平均年齢を高い方から順に表示してください。ただし、FROM句はcountriesテーブルとしてください。
SELECT
    countries.name,
    AVG(celebrities.age) AS average_age
FROM
    countries
    JOIN
        celebrities
    ON  countries.code = celebrities.country_code
GROUP BY
    countries.name
ORDER BY
    average_age DESC
;
    


