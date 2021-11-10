function[] = Punto1R(f)

a = input('Ingrese el valor de inicio = ');
T = input('Ingrese el periodo T = ');

t = [a:0.001:T+a];
k = [2 5 10 20 40 60];
a_0=2/T*integral(f,a, a+T);
w=2*pi/T;

a_n = @(x) (2/T).*integral(@(ti) f(ti).*cos(x*w*ti),a,T+a);
b_n = @(x) (2/T).*integral(@(ti) f(ti).*sin(x*w*ti),a,T+a);

for ki = 1 : length(k)
    xt1 =  a_0/2;
    for i = 1 : k(ki)
        xt1= xt1 + a_n(i)*cos(w*i*t)+b_n(i)*sin(w*i*t);
    end
    subplot(length(k)/2, 2, ki);
    p = plot(t,f(t),'-', t,xt1,'-r');
    tittleInfo = sprintf('Funciones periódicas y el fenómeno de Gibbs para N = %i', k(ki));
    title(tittleInfo)
    p(1).LineWidth = 2;
    p(2).LineWidth = 2;
    xlabel('t')
    ylabel('x(t)')
    legend('x(t)', 'X_N(t)')
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    grid;
end

end