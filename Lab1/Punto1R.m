%Punto 1
%Recibe una función anónima   f
%Se le pueden pasar como parametros: el valor en donde inicia el pulso (a) y
%la duracion de de este (T). 

function[] = Punto1R(f)
a = input('Ingrese el valor de inicio = ');
T = input('Ingrese el periodo T = ');

t = [a:0.001:T+a];                % Vector del tiempo
k = [2 5 10 20 40 60];            % Vector de las Ns
a_0=2/T*integral(f,a, a+T);       % Coeficiente a_0
w=2*pi/T;                         % w_0 

% Deficion coeficiente a_n (se utiliza integral para mejorar precisión)
a_n = @(x) (2/T).*integral(@(ti) f(ti).*cos(x*w*ti),a,T+a); 
% Deficion coeficiente b_n
b_n = @(x) (2/T).*integral(@(ti) f(ti).*sin(x*w*ti),a,T+a);

for ki = 1 : length(k)        % Cantidad de graficas del tamaño de k
    xt1 =  a_0/2;
    for i = 1 : k(ki)         % Se itera N veces 
        xt1= xt1 + a_n(i)*cos(w*i*t)+b_n(i)*sin(w*i*t);   %Evaluacion x_n
    end
    subplot(length(k)/2, 2, ki);       % Subplot para cada una de las k_s graficas
    p = plot(t,f(t),'-', t,xt1,'-r');  % Grafica de f teorica y serie de fourier
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