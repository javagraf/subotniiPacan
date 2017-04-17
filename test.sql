BEGIN 
	
    SET @i = 1;
    SET @sum = 0;
    
    
    WHILE @i < maxi DO 

    SET @sum = @sum + (CHAR_LENGTH(sentences.C_NAME)-
            CHAR_LENGTH(Replace(sentences.C_NAME,
            (SELECT rules.C_RULES FROM rules WHERE rules.ID = @i 
            )                    
                                ,'!!')));
                                
UPDATE sentences
SET sentences.C_COUNT  = @sum;
SET @i = @i+1;
  
    END WHILE; 
END
