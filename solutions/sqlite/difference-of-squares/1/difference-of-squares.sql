-- Schema: CREATE TABLE "difference-of-squares" ("number" INT, "property" TEXT, "result" INT);
-- Task: update the difference-of-squares table and set the result based on the number and property fields.
-- Generate series of numbers
CREATE VIEW series_1000 AS
WITH RECURSIVE
  cnt (x) AS (
    SELECT
      1
    UNION ALL
    SELECT
      x + 1
    FROM
      cnt
    WHERE
      x <= 1000
  )
SELECT
  x
FROM
  cnt;

-- Generate sumOfSquares
CREATE VIEW "sumOfSquares" AS
SELECT
  x,
  SUM(POWER(x, 2)) OVER (
    ORDER BY
      x
  ) sum
FROM
  "series_1000"
WHERE
  x <= 1000;

-- Generate squareOfSums
CREATE VIEW "squareOfSums" AS
SELECT
  x,
  POWER(sum, 2) pow
FROM
  (
    SELECT
      x,
      SUM(x) OVER (
        ORDER BY
          x
      ) sum
    FROM
      (
        SELECT
          x
        FROM
          "series_1000"
        WHERE
          x <= 1000
      )
  );

-- Generate differenceOfSquares
CREATE VIEW "differenceOfSquares" AS
SELECT
  t1.number x,
  "t2"."result" - "t1"."result" diff
FROM
  "difference-of-squares" t1
  JOIN "difference-of-squares" t2 ON t1."number" = t2."number"
WHERE
  t1.property = 'sumOfSquares'
  AND t2.property = 'squareOfSum';

-- Update table
UPDATE "difference-of-squares"
SET
  "result" = CASE "property"
    WHEN 'sumOfSquares' THEN (
      SELECT
        sum
      FROM
        "sumOfSquares"
      WHERE
        "x" = "number"
    )
    WHEN 'squareOfSum' THEN (
      SELECT
        pow
      FROM
        "squareOfSums"
      WHERE
        "x" = "number"
    )
    WHEN 'differenceOfSquares' THEN (
      SELECT
        diff
      FROM
        "differenceOfSquares"
      WHERE
        "x" = "number"
    )
  END;
