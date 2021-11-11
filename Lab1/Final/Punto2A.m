function [X, t, f0, fs, Ts, f, a] = Punto2()
a = input('Ingrese el valor de a = ');
f0=1;                               %Valor de la frecuencia lineal
fs=100*f0; Ts=1/fs;                 %Intervalo de muestreo y frecuencia de muestreo
t= [-10*a:Ts:10*a];                 %Vector de tiempo
x= (t<a)&(t>-a);                    %Funcion onda rectangular
X=fft(x)*Ts;                        %Transformada rapida de Fourier FFT
Xr = X./Ts;

%Pulso Rectangular
f = t/Ts/(a*pi) ;                   % vector de frecuencias
subplot(2,2,[1 2]); plot(t,x,'-r'); axis([-3*a 3*a -1 1.5]); xlabel('nT_s'); ylabel('x(nT_s)');
title(strcat('Onda rectangular con a = ', num2str(a)));
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
legend('X(t)');
grid;

% FFT del pulso rectangular
subplot(2,2,[3 4]); 
omega = [-8*a:0.01:8*a];
sa=inline('(sin(x)+(x==0))./(x+(x==0))','x'); 	% Genera la función sa(x)=sin(x)/x.
plot(omega,2*a*sa(a*omega),'--g',f,fftshift(abs(X)),'-b'); axis([-20 20 -5 20]); % Gráfica FFT Analítica y Computacional
legend('fft', 'x(w)');
xlabel('f'); 
ylabel('|X(f)|');
title('FFT Fourier Transform Comparison');
grid;
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';



end
