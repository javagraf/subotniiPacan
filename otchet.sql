SET @sql = NULL;
SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(
      'count(case when C_PRODUCT_NAME = ''',
      C_PRODUCT_NAME,
      ''' then 1 end) AS ',
      replace(C_PRODUCT_NAME, ' ', '')
    )
  ) INTO @sql
from products;

SET @sql = CONCAT('SELECT pt.C_PARTNERS_NAME, ', @sql, ' from partners pt
left join sales s
  on pt.ID_PARTNERS = s.F_ID_PARTNER
left join products pd
  on s.F_ID_PRODUCT = pd.ID_PROD
group by pt.C_PARTNERS_NAME');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

select pt.C_PARTNERS_NAME,
  count(case when pd.C_PRODUCT_NAME = 'Cheese' THEN 1 END) as Cheese,
  count(case when pd.C_PRODUCT_NAME = 'Milk' THEN 1 END) as Milk,
  count(case when pd.C_PRODUCT_NAME = 'Apple' THEN 1 END) as Apple,
  count(case when pd.C_PRODUCT_NAME = 'Bread' THEN 1 END) as Bread,
  count(case when pd.C_PRODUCT_NAME = 'Chocolate' THEN 1 END) as Chocolate
from partners pt
left join sales s
  on pt.ID_PARTNERS = s.F_ID_PARTNER
left join products pd
  on s.F_ID_PRODUCT = pd.ID_PROD
group by pt.C_PARTNERS_NAME
