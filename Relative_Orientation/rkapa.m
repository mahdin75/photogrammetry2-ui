function o = rkapa(a)
    if a(1)>0
       a(3) = a(3) - a(1);
       a(5) = a(5) - a(1);
       a(1) = 0;
   else
       a(3) = a(3) + abs(a(1));
       a(5) = a(5) + abs(a(1));
       a(1) = 0;
   end
   o = a;
end 

