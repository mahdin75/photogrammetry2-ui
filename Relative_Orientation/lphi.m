function o = lphi(a)
   if a(4)>0
       a(6) = a(6) + a(4);
       a(4) = 0;
   else
       a(6) = a(6) - abs(a(4));
       a(4) = 0;
   end
   o = a;
end