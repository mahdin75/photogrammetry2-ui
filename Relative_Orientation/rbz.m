function o = rbz(a)
   if a(4)>0
       a(3) = a(3) - a(4);
       a(5) = a(5) + a(4);
       a(6) = a(6) + a(4);
       a(4) = 0;
   else
       a(3) = a(3) + abs(a(4));
       a(5) = a(5) - abs(a(4));
       a(6) = a(6) - abs(a(4));
       a(4) = 0;
   end
   o = a;
end 

