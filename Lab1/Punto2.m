function [X, t, f0, fs, Ts, f, a] = Punto2()
a = input('Ingrese el valor de a = ');
T=2*a;                            % duración de la señal
f0=1;                             % valor de la frecuencia lineal
fs=100*f0; Ts=1/fs;                % intervalo de muestreo y frecuencia de muestreo
t= [-2*a:Ts:2*a];                 % vector de tiempo
x= (abs(t)<= a); X=fft(x)*Ts;
Xr = X./Ts;

% pulso rectangular
f= [-length(X)/2+1:length(X)/2];  % vector de frecuencias
subplot(2,1,1); plot(t,x,'-r'); axis([-3*a 3*a -1 1.5]); xlabel('nT_s'); ylabel('x(nT_s)');
title(strcat('Onda rectangular con a = ', num2str(a)));
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;


sa=inline('(sin(x)+(x==0))./(x+(x==0))','x'); 	% Genera la función sa(x)=sin(x)/x.
subplot(2,1,2); plot(f-(0.5),fftshift(abs(X)),'-b'); axis([-40 40 -5 20]);
hold on;
plot(f,2*a*sa(a*f),'--r'); 
xlabel('f'); 
ylabel('|X(f)|');
title('Transformada de Fourier');
grid;
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

end

