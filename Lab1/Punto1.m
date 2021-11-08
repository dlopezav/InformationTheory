xt = input('Ingrese la función x(t) = ', 's');
T = input('Ingrese el periodo = ');
k = input('Ingrese la cota N = ');
a = input('Ingrese el punto de inicio = ');
f = inline(xt, 't');

t = [a:0.001:T+a];

a_0=2/T*quad(f,a, a+T);

w=2*pi/T;

xt1 = a_0/2;

a_n = @(x) (2/T).*integral(@(ti) xt.*cos(x*w*ti),a,T+a);
b_n = @(x) (2/T).*integral(@(ti) xt.*sin(x*w*ti),a,T+a);

for i = 1 : k
    xt1= xt1 + a_n(i)*cos(w*i*t)+b_n(i)*sin(w*i*t);
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