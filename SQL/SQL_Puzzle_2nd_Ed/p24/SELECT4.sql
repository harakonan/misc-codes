SELECT * 
  FROM MyTable 
 WHERE 0 IN ((f2 + f3 + f4 + f5 + f6 + f7 + f8 + f9 + f10), 
             (f1 + f3 + f4 + f5 + f6 + f7 + f8 + f9 + f10), 
             (f1 + f2 + f4 + f5 + f6 + f7 + f8 + f9 + f10), 
             (f1 + f2 + f3 + f5 + f6 + f7 + f8 + f9 + f10), 
             (f1 + f2 + f3 + f4 + f6 + f7 + f8 + f9 + f10), 
             (f1 + f2 + f3 + f4 + f5 + f7 + f8 + f9 + f10), 
             (f1 + f2 + f3 + f4 + f5 + f6 + f8 + f9 + f10), 
             (f1 + f2 + f3 + f4 + f5 + f6 + f7 + f9 + f10), 
             (f1 + f2 + f3 + f4 + f5 + f6 + f7 + f8 + f10), 
             (f1 + f2 + f3 + f4 + f5 + f6 + f7 + f8 + f9))
   AND (f1 + f2 + f3 + f4 + f5 + f6 + f7 + f8 + f9 + f10) <> 0;