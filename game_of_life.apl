)copy dfns traj
life←{↑1 ⍵∨.∧3 4=+/,¯1 0 1∘.⊖¯1 0 1∘.⌽⊂⍵}
adj←{⍺⍺ ⍵}
cut←{1↓⍺⍺ 0⍪⍵}
rev←{2↓¯1⊖⍺⍺ ¯1⊖⍵⍪⊖⌽2↑¯1⊖⍵}
T←{⍉⍺⍺⍉⍵}
glider ← 5 5↑ 3 3⍴0 0 1, 1 0 1, 0 1 1
try ← {{'·⍟'[⎕io+⍵]}¨⍺⍺ traj ⍵}
life adj T cut try 10 5↑glider



life cut T cut try glider





SUDOKU


3 3⍴⍳3×3 

3/3 3⍴⍳3×3
3⌿3/3 3⍴⍳3×3  


box ← {⍵⌿⍵/⍵ ⍵⍴⍳⍵×⍵}  
box 3


box 2

⍳ 4 4    

(⍳4 4) ,¨ box 2     

25 49 * ÷2


rcb ← {(⍳⍵),¨box⊃⍵*÷2} 

rcb 4 4   

(rcb 4 4) = ⊂2 2 1 

1 ∊¨ (rcb 4 4)=⊂2 2 1  

1 ∊¨ (rcb 4 4) ∘.= rcb 4 4 

⊂[⍳2] 1 ∊¨ (rcb 4 4) ∘.= rcb 4 4 

{⊂[⍳2] 1∊¨ ⍵∘.=⍵} rcb 4 4 


 cmap ← {⊂[⍳2] 1∊¨ ⍵∘.=⍵} 
 
 cmap rcb 4 4 
 
  ⊢s44 ← 4 4⍴ 0 0 0 0  0 0 2 1  3 0 0 4  0 0 0 0 
  
  ⍴ s44 


⊃1 1⌷cmap rcb ⍴s44  

 s44 × ⊃1 1⌷cmap rcb ⍴s44 
 
 (⍳4) ~ s44×⊃1 1⌷cmap rcb ⍴s44
 
  avl ← {(⍳⊃⍴⍵) ~ ⍵×⊃⍺⌷cmap rcb ⍴⍵} 
 
 
 1 1 avl s44    
 
 2 3↑99  
 
 ¯2 ¯3↑99   
 
 4 4↑¯3 ¯3↑99  
 
 s44 + 4 4↑¯3 ¯3↑99  
 
 at ← {⍵+(⍴⍵)↑(-⍺⍺)↑⍺}
 
 99 (3 3 at) s44
 
 1 2 4 (1 1 at)¨ ⊂s44 
 
 (1 1 avl s44) (1 1 at)¨ ⊂s44 
 
  nxt ← {(⍺ avl ⍵)(⍺ at)¨⊂⍵} 
 
 1 1 nxt s44 
 
 1 2∘nxt¨ 1 1 nxt s44   
 
 ⊃,/ 1 2∘nxt¨ 1 1 nxt s44
 
  ⊃,/1 2∘nxt¨ ⊃,/1 1∘nxt¨ ,⊂s44 
 
 ⊃,/2 1∘nxt¨ ⊃,/1 2∘nxt¨ ⊃,/1 1∘nxt¨ ,⊂s44
 
 nxtv ← {⊃,/⍺∘nxt¨ ⍵} 
 
   2 1 nxtv 1 2 nxtv 1 1 nxtv ,⊂s44
 
 ⊃nxtv/ (2 1)(1 2)(1 1)(,⊂s44)
 
  ⊃nxtv/ (1 3)(2 1)(1 2)(1 1)(,⊂s44) 
  
  ⊃nxtv/ (4 2)(1 3)(2 1)(1 2)(1 1)(,⊂s44)  
  
  
  ⊃nxtv/ (3 2)(4 2)(1 3)(2 1)(1 2)(1 1)(,⊂s44)
 
 ⊃nxtv/ (1 4)(3 2)(4 2)(1 3)(2 1)(1 2)(1 1)(,⊂s44)
 
   ⍳⍴ s44 
   
   s44=0 
   
     , ⍳⍴ s44  
	 
	 
	 , s44=0   
	 
	 (,s44=0)/,⍳⍴s44    
	 
  emt ← {(,⍵=0)/,⍳⍴⍵}  
  emt s44      
  
   ⊃nxtv/(emt s44),⊂,⊂s44 
   
   svec ← {⊃nxtv/(emt ⍵),⊂,⊂⍵} 
   
   svec s44 
   
    sfmt←{⊂[3 4]1 3 2 4⍉(2/(⍴⍵)*÷2)⍴⍵}
	
	sfmt s44 
	
	 sfmt ⊃svec s44 

svec 
nxtv  
nxt
avl 

avl←{(⍳⊃⍴⍵)~⍵×⊃⍺⌷⍺⍺}
 nxt←{(⍺(⍺⍺ avl)⍵)(⍺ at)¨⊂⍵}
nxtv←{⊃,/⍺∘(⍺⍺ nxt)¨⍵}
 svec←{⊃(⍺⍺ ⍴⍵)nxtv/(emt ⍵),⊂⊂⍵}
 
 sfmt ⊃ cmap∘rcb svec s44  
 
 s99 ← 9 9⍴0 
 
 s99[1;] ← 0 0 1 6 9 0 5 0 0 
 s99[2;] ← 4 0 0 2 7 0 0 0 1 
 s99[3;] ← 0 7 0 0 0 0 0 9 0
 s99[4;] ← 0 0 0 0 0 0 0 3 0
 s99[5;] ← 0 0 0 4 3 0 0 0 7
 s99[6;] ← 0 0 0 7 8 0 6 0 0
 s99[7;] ← 0 0 6 0 0 0 8 0 5
 s99[8;] ← 0 2 0 1 4 0 0 6 0
 s99[9;] ← 0 1 0 3 5 0 0 4 0
 
 
sfmt s99  

sudoku ← {sfmt⊃cmap∘rcb svec ⍵}

sudoku s44

sudoku s99 




   
   
  
 
 