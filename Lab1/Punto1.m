xt = input('Ingrese la función x(t) = ', 's');
T = input('Ingrese el periodo = ');
k = input('Ingrese la cota N = ');
a = input('Ingrese el punto de inicio = ');
f = inline(xt, 't');

if (a > 0)
    t = [a:0.001:T+a];
else
    t = [a:0.001:T-a];
end

a_0=2/T*quad(f,a, a+T);

w=2*pi/T;

xt1 = a_0/2;

for i = 1 : k
    wAux=num2str(w*i);
    strAn=strcat(xt,'.*cos(',wAux,'*t)');
    strBn=strcat(xt,'.*sin(',wAux,'*t)');
    fAn = inline(strAn, 't');
    fBn = inline(strBn, 't');
    
    a_n=(2/T)*quad(fAn,a, a+T);
    b_n=(2/T)*quad(fBn,a, a+T);
    xt1= xt1 + a_n*cos(w*i*t)+b_n*sin(w*i*t);
end
p = plot(t,f(t),'-', t,xt1,'-r');
p(1).LineWidth = 2;
p(2).LineWidth = 2;
title('Funciones periódicas y el fenómeno de Gibbs')
xlabel('t')
ylabel('x(t)')
legend('x(t)', 'X_N(t)')
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;