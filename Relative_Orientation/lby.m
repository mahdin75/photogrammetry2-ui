function o = lby(a)
   if a(1)>0
       a = a - a(1);
   else
       a = a + abs(a(1));
   end
   o = a;
end