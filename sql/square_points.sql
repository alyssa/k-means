SELECT
  SUM(IF(p.card_present = 1, p.amount_cents, 0))/SUM(p.amount_cents) * 10 AS x,
  AVG(p.amount_cents) / (100 * 100) AS y
FROM
  (
    SELECT
      id
    FROM
      batcave_production_proxy.users AS u
    ORDER BY
      RAND()
    LIMIT
      1000
  ) AS ru
INNER JOIN
  batcave_production_proxy.payments AS p
  ON p.user_id = ru.id
WHERE
  p.event_type = 'CardPayment'
  AND p.success = 1
  AND p.amount_cents > 100
GROUP BY
  user_id
HAVING
  y < 10
;