function [out]=lpa_v1(w,C1,C2,R1,R2,R3)
num = + ( -R3 );
den = + ( R1 )+ ( C2*R2*R3 +C2*R1*R3 +C2*R1*R2 )*j*w- ( C2*C1*R1*R2*R3 )*w^2;
out = num/den;
end
