function o = rphi(a)
   if a(3)>0
       a(5) = a(5) + a(3);
       a(3) = 0;
   else
       a(5) = a(5) - abs(a(3));
       a(5) = 0;
   end
   o = a;
end