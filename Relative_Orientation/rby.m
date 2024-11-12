function o = rby(a)
   if a(2)>0
       a = a - a(2);
   else
       a = a + abs(a(2));
   end
   o = a;
end