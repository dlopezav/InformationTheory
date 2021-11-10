function [X, t, f0, fs, Ts, f, a] = Punto2()
a = input('Ingrese el valor de a = ');
T=4*a;                            % duración de la señal
f0=1;                             % valor de la frecuencia lineal
fs=100*f0; Ts=1/fs;                % intervalo de muestreo y frecuencia de muestreo
t= [-10*a:Ts:10*a];                 % vector de tiempo
length(t)
x= (t<a)&(t>-a); X=fft(x)*Ts;
Xr = X./Ts;

% pulso rectangular
f = t/Ts/(a*pi) ;  % vector de frecuencias
subplot(2,2,[1 2]); plot(t,x,'-r'); axis([-3*a 3*a -1 1.5]); xlabel('nT_s'); ylabel('x(nT_s)');
title(strcat('Onda rectangular con a = ', num2str(a)));
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;

% FFT del pulso rectangular
omega = [-8*a:0.01:8*a]
sa=inline('(sin(x)+(x==0))./(x+(x==0))','x'); 	% Genera la función sa(x)=sin(x)/x.

subplot(2,2,[3 4]); plot(f,fftshift(abs(X)),'-b'); axis([-20 20 -5 20]);
xlabel('f'); 
ylabel('|X(f)|');
title('FFT Fourier Transform Comparison');
grid;
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

%subplot(2,2,4); 
hold on;
plot(omega,2*a*sa(a*omega),'--g'); axis([-20 20 -5 20]);
legend('fft', 'x(w)')

end

