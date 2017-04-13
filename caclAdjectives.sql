SELECT ID, C_NAME, (CHAR_LENGTH(sentences.C_NAME)-
            CHAR_LENGTH(Replace(sentences.C_NAME,'ого','!!'))) 
            +
            (CHAR_LENGTH(sentences.C_NAME)-
            CHAR_LENGTH(Replace(sentences.C_NAME,'ный','!!')))
            +
            (CHAR_LENGTH(sentences.C_NAME)-
            CHAR_LENGTH(Replace(sentences.C_NAME,'лый','!!')))
            +
            (CHAR_LENGTH(sentences.C_NAME)-
            CHAR_LENGTH(Replace(sentences.C_NAME,'ую','!')))
            AS 'SUM'      
  FROM sentences
