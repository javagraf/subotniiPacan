  SELECT ID, C_NAME, (CHAR_LENGTH(sentences.C_NAME)-
            CHAR_LENGTH(Replace(sentences.C_NAME,'à','')))          
  FROM sentences