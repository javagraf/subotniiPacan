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

select pt.partner_name,
  count(case when pd.product_name = 'Product A' THEN 1 END) ProductA,
  count(case when pd.product_name = 'Product B' THEN 1 END) ProductB,
  count(case when pd.product_name = 'Product C' THEN 1 END) ProductC,
  count(case when pd.product_name = 'Product D' THEN 1 END) ProductD,
  count(case when pd.product_name = 'Product E' THEN 1 END) ProductE
from partners pt
left join sales s
  on pt.part_id = s.partner_id
left join products pd
  on s.product_id = pd.prod_id
group by pt.partner_name
