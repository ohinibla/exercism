-- Schema:
-- CREATE TABLE "bottle-song" (
--         start_bottles INTEGER NOT NULL,
--         take_down     INTEGER NOT NULL,
--         result        TEXT
-- );
-- Task: update bottle-song table and set the result based on the
-- start_bottles and take_down.
DROP TABLE IF EXISTS "poem";

CREATE TABLE "poem" ("id" INTEGER, "verse" TEXT, PRIMARY KEY ("id"));

INSERT INTO
  "poem" ("verse")
VALUES
  (
    'Ten green bottles hanging on the wall,
Ten green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There''ll be nine green bottles hanging on the wall.'
  ),
  (
    'Nine green bottles hanging on the wall,
Nine green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There''ll be eight green bottles hanging on the wall.'
  ),
  (
    'Eight green bottles hanging on the wall,
Eight green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There''ll be seven green bottles hanging on the wall.'
  ),
  (
    'Seven green bottles hanging on the wall,
Seven green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There''ll be six green bottles hanging on the wall.'
  ),
  (
    'Six green bottles hanging on the wall,
Six green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There''ll be five green bottles hanging on the wall.'
  ),
  (
    'Five green bottles hanging on the wall,
Five green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There''ll be four green bottles hanging on the wall.'
  ),
  (
    'Four green bottles hanging on the wall,
Four green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There''ll be three green bottles hanging on the wall.'
  ),
  (
    'Three green bottles hanging on the wall,
Three green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There''ll be two green bottles hanging on the wall.'
  ),
  (
    'Two green bottles hanging on the wall,
Two green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There''ll be one green bottle hanging on the wall.'
  ),
  (
    'One green bottle hanging on the wall,
One green bottle hanging on the wall,
And if one green bottle should accidentally fall,
There''ll be no green bottles hanging on the wall.'
  );

UPDATE "bottle-song"
SET
  "result" = (
    SELECT
      GROUP_CONCAT ("verse", char(10) || char(10))
    FROM
      (
        SELECT
          *
        FROM
          "poem"
        WHERE
          "id" BETWEEN 11 - "start_bottles" AND 11  - "start_bottles" + "take_down" - 1
      )
  );
