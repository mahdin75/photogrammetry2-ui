function o = lbz(a)
   if a(3)>0
       a(4) = a(4) - a(3);
       a(5) = a(5) + a(3);
       a(6) = a(6) + a(3);
       a(3) = 0;
   else
       a(4) = a(4) + abs(a(3));
       a(5) = a(5) - abs(a(3));
       a(6) = a(6) - abs(a(3));
       a(3) = 0;
   end
   o = a;
end 

