function o = omegap(a,drz)   
   a(1) = (1/2)*((1/drz)^2)*(-a(5));
   a(2) = a(1);
   a(3) = (1/2)*(1+(1/drz)^2)*(-a(5));
   a(4) = a(3);
   a(5) = a(5) + a(3);
   a(6) = a(6) + a(3);
   o = a;
end