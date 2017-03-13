function [b,z,cz,confb95,confb99,p] = QQplot(x,r,dt,t,str)
%[b,x,cz,confb95,confb99] = QQplot(x,r,dt)
%Brown et.al. Neural Comput. 2001

if (nargin == 1)
    z = sort(x);
    
elseif (nargin == 3)
    R = cumsum(r*dt);
    
    tau = diff( R(ceil(sort(x - min(x)+dt)/dt)) );
    z = 1 - exp(-tau);          % z is expected to be uniform
    z = sort(z);
elseif (nargin == 4)
    R = cumsum(r*dt);
    tau = diff( interp1(t,R,sort(x)) );
    
    z = 1 - exp(-tau);          % z is expected to be uniform
    z = sort(z);
    
    str = 'k.';
elseif (nargin == 5)
    R = cumsum(r*dt);
    tau = diff( interp1(t,R,sort(x)) );
    
    z = 1 - exp(-tau);          % z is expected to be uniform
    z = sort(z);
end
   
z = z(z ~= 0); 
n = length(z);
b = ([1:n]-0.5)/n;
%b = icdf('unif',b,0,1);

cz = linspace(0,1,100);
confb95 = 1.96*sqrt(cz.*(1-cz)/n);
confb99 = 2.575*sqrt(cz.*(1-cz)/n);


%cla; 
line([0,1],[0,1],'Color','k');
hold on;
plot(cz,cz-confb95,'k--',cz,cz+confb95,'k--');
%plot(cz,cz-confb99,'k:',cz,cz+confb99,'k:');

p = plot(b,z,str,'MarkerSize',4,'Linewidth',2);

%title('Q-Q plot'); xlabel('Model Quantiles'); ylabel('Empirical Quantiles');
axis square; grid off;
axis([0 1 0 1]);

hold off; 
%figure;plot(R)