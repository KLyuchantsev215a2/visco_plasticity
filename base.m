clear;    
% 
  fig = figure();
% % �������� ������� ������� �����
  set(fig,'Position',[350,200,700,700]);
   frame = getframe(fig);
  [im,map] = rgb2ind(frame.cdata,4);
  imwrite(im,map,'animation3.gif','DelayTime',0,'Loopcount',inf);
  
ss1=load('Stresses_Maxwell_etaEq1by25_C11.txt');
ss2=load('Stresses_Maxwell_etaEq1by25_C12.txt');
ss3=load('Stresses_Maxwell_etaEq1by25_C22.txt');

ss4=load('top_right_x_etaEq1by25.txt');
ss5=load('top_right_y_etaEq1by25.txt');

rho_0 =3;
v_0 = 1;
Time = 1.5;
sqn=11;
l=1;
N=sqn*sqn;
S=l*l;
m=rho_0*S/N;

nu=0.4;
mu = 1.25;
eta = 1/25;  % relaxation time = eta/mu = 1 s
k=2*mu*(1+nu)/(3*(1-2*nu));
E=9*k*mu/(3*k+mu);   % ������ ����

cs_0=sqrt((E+4/3*mu)/rho_0);

h=1.4*(m/rho_0)^(1/2);%k ��������
dt=0.1*h/(cs_0+v_0);
dh=0.000001;
eps1=0;%-100;
eps2=0;%-50;%1/5;

V=m/rho_0*ones(N,1);%m/rho_0;
V_0=m/rho_0*ones(N,1);%m/rho_0;
x=initialization_x(N,sqn,l);    
v=initialization_v(N,sqn,v_0,x,l);
viscosity=zeros(2,N);
X_old=x;

F=zeros(2,2,N);
L=zeros(2,2,N);
SIG=zeros(2,2,N);
Ci=zeros(2,2,N);  % field of Ci

U=zeros(N,1);
Energy_time=zeros(fix(Time/dt),1);


U_time=zeros(fix(Time/dt),1);%potential energy
T_time=zeros(fix(Time/dt),1);%kinetic energy
time=zeros(fix(Time/dt),1);

for i = 1:N
    F(1:2,1:2,i)=eye(2);
    Ci(1:2,1:2,i)=eye(2);
end

[SIG,Ci_new]=OneStepMaxwell(F,mu,k,eta,dt,Ci,N);
Ci = Ci_new;
W_cor=zeros(N,N);
nabla_W_cor=zeros(2,N,N);
Hessian_W_cor=zeros(2,N,N);

coord_midle=zeros(2,fix(Time/dt));

coord_top_right_x=zeros(1,fix(Time/dt));
coord_top_right_y=zeros(1,fix(Time/dt));

[W_cor,nabla_W_cor_0,Hessian_W_cor]=ComputeW_final(x,V,N,h,dh);


%ss1=load('Displacment_X_top_right.txt');
%ss2=load('Displacment_Y_top_right.txt');
%plot(ss1(:,2),ss1(:,3),'r',ss2(:,2),ss2(:,3),'g');
 x_coord(1:N) = x(1,1:N);
     y_coord(1:N) = x(2,1:N);
%     subplot(2,2,1);
     
    scatter(x_coord,y_coord);
     
     
     
for n = 1:fix(Time/dt)
    L=zeros(2,2,N);
%     if(fix(n/200)==n/200)
%         X_old=x;
%         [W_cor,nabla_W_cor_0,Hessian_W_cor]=ComputeW_final(x,V,N,h,dh);
%     end
%     x_old=x;
%     v_old=v;
%     [acc_old,F_old,SIG_old]=ComputeAcceleration(x_old,v_old,V,N,m,eps1,eps2,h,cs_0,nabla_W_cor_0,X_old,mu,k,dh);
%     x_star = x_old + dt*v_old;
%     v_star = v_old + dt*acc_old;
%     [acc_star,F,SIG] = ComputeAcceleration(x_star,v_star,V,N,m,eps1,eps2,h,cs_0,nabla_W_cor_0,X_old,mu,k,dh);
%     x_star_star = x_star + dt*v_star;
%     v_star_star = v_star + dt*acc_star;
%     x = 0.5*(x_old + x_star_star);
%     v = 0.5*(v_old + v_star_star);
%    [W_cor,nabla_W_cor,Hessian_W_cor]=ComputeW_final(x,V,N,h,dh);
%    L=ComputeL(v,V,nabla_W_cor,N);
      x_old=x;
      v_old=v;
      [acc_old,F_old,SIG_old]=ComputeAcceleration(x_old,v_old,V,N,m,eps1,eps2,h,cs_0,nabla_W_cor_0,X_old,mu,k,dh,rho_0,eta,dt,Ci);
      x_n_1=x_old+dt*v_old;
      v_n_1=v_old+dt*acc_old;
      [acc_n_1,F,SIG]=ComputeAcceleration(x_n_1,v_n_1,V,N,m,eps1,eps2,h,cs_0,nabla_W_cor_0,X_old,mu,k,dh,rho_0,eta,dt,Ci);
      x_n_2=x_n_1+dt*v_n_1;
      v_n_2=v_n_1+dt*acc_n_1;
      x_n_1_2=3/4*x_old+1/4*x_n_2;
      v_n_1_2=3/4*v_old+1/4*v_n_2;
      [acc_n_1_2,F,SIG]=ComputeAcceleration(x_n_1_2,v_n_1_2,V,N,m,eps1,eps2,h,cs_0,nabla_W_cor_0,X_old,mu,k,dh,rho_0,eta,dt,Ci);
      x_n_3_2=x_n_1_2+dt*v_n_1_2;
      v_n_3_2=v_n_1_2+dt*acc_n_1_2;
      x=1/3*x_old+2/3*x_n_3_2;
      v=1/3*v_old+2/3*v_n_3_2;
      
      F=ComputeF(V,x,nabla_W_cor_0,N,X_old);  
     [SIG,Ci_new]=OneStepMaxwell(F,mu,k,eta,dt,Ci,N);
     Ci=Ci_new;
      
      %U=ComputeEnergy(F,mu,k,N);
     % Energy=0;
     % U_energy = 0;
     % T_energy = 0;
     % for i=1:N
          % Energy=Energy+U(i)*V_0(i)+1/2*rho_0*V_0(i)*dot(v(1:2,i),v(1:2,i));%+U(i)*V(i)
      %    U_energy = U_energy + U(i)*V_0(i);
          %T_energy = T_energy + 1/2*rho_0*V_0(i)*dot(v(1:2,i),v(1:2,i)); 
      %    T_energy = T_energy + 1/2*rho_0*V_0(i)*(v(1,i)^2+ v(2,i)^2);
    %  end
     % U_time(n)=U_energy;%potential energy
    %  T_time(n)= T_energy;
    %  Energy_time(n)=U_energy + T_energy;
       coord_top_right_x(1,n)=x(1,sqn*sqn)-X_old(1,sqn*sqn);
       coord_top_right_y(1,n)=x(2,sqn*sqn)-X_old(2,sqn*sqn);
       
       C_1_1(n)=SIG(1,1,61);
      C_2_2(n)=SIG(2,2,61);
      C_1_2(n)=SIG(1,2,61);

      time(n)=n*dt;
        x_coord(1:N) = x(1,1:N);
   y_coord(1:N) = x(2,1:N);
   
   scatter(x_coord,y_coord);

plot( time(1:n),  C_1_1(1:n), time(1:n),  C_1_2(1:n), time(1:n),C_2_2(1:n),ss1(:,2), ss1(:,3),'k',ss2(:,2), ss2(:,3),'k',ss3(:,2), ss3(:,3),'k');
subplot(2,2,1);
plot( time(1:n), coord_top_right_x(1,1:n), time(1:n),coord_top_right_y(1,1:n),ss4(:,2),ss4(:,3),'k',ss5(:,2),ss5(:,3),'k');
subplot(2,2,2);
pause(0.0000001);   
%  plotmy=myplot(x,V,F,N,SIG,l,v,Energy_time,time,n,im,frame,map,fig);
      life_time=n*dt;

       disp(life_time);
       
end
   x_coord(1:N) = x(1,1:N);
   y_coord(1:N) = x(2,1:N);
   
   scatter(x_coord,y_coord);

plot( time(1:n),  C_1_1(1:n), time(1:n),  C_1_2(1:n), time(1:n),C_2_2(1:n),ss1(:,2), ss1(:,3),'k',ss2(:,2), ss2(:,3),'k',ss3(:,2), ss3(:,3),'k');
%plot( time(1:n), coord_top_right_x(1,1:n), time(1:n),coord_top_right_x(1,1:n),ss4(:,2),ss4(:,3),'k',ss5(:,2),ss5(:,3),'k');

%plot( time, Energy_time);
% x_coord =time;
% y_coord = Energy_time;
% subplot(2,2,1);
% plot(x_coord,y_coord);

