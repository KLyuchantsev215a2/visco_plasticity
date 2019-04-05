function [SIG,Ci_new]=OneStepMaxwell(Fp,mu,k,eta,dt,Cip,N);
% Subroutine which computes Cauchy stress tensor as a function
% of the deformation gradient F and the previous inelastic Cauchy-Green
% tensor Ci
% input:  F = deformation gradient
%         mu = shear modulus
%          k = bulk modulus
%         eta = viscosity
%          Ci = previous inelastic Cauchy-Green
% output: stress = Cauchy stresss (true stress) 
%
%   Maxwell material (formulatin by Simo-Miehe 1992)
%
SIG=zeros(2,2,N);
for i = 1:N          
    F = Fp(1:2,1:2,i);
    F(3,3) = 1;
    C = F'*F;
    J = det(F); % Jacobian
    Ciso = J^(-2/3)*C;  % isochoric part of C
    Ci = Cip(1:2,1:2,i);
    Ci(3,3) = 1/(Ci(1,1)*Ci(2,2)- Ci(1,2)*Ci(2,1));
    
    Ci3x3 = Ci + dt*mu/eta*Ciso;
    Ci3x3 = (det(Ci3x3))^(-1/3)*Ci3x3;

    Ci_new(1:2,1:2,i) = Ci3x3(1:2,1:2); 
    Stress2PK = mu*C^(-1)*dev(Ciso*Ci^(-1));   % second Piola-Kirchhoff
    stress =(F*Stress2PK*F' + k/10*(J^5-J^(-5))*eye(3));  %  
    SIG(1:2,1:2,i) = stress(1:2,1:2);
end