function o = lkapa(a)
   if a(2)>0
       a(4) = a(4) - a(2);
       a(6) = a(6) - a(2);
       a(2) = 0;
   else
       a(4) = a(4) + abs(a(2));
       a(4) = a(6) + abs(a(2));
       a(2) = 0;
   end
   o = a;
end 

