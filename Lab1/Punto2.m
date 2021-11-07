a = input('Ingrese el valor de a = ');
T=2*a;                            % duración de la señal
f0=1;                             % valor de la frecuencia lineal
fs=50*f0; Ts=2*a/fs;                % intervalo de muestreo y frecuencia de muestreo
t= [-2*a:Ts:2*a];                 % vector de tiempo
x= (abs(t)< a); X=fft(x)*Ts;      % pulso rectangular
f= [-length(t)/2+1:length(t)/2];  % vector de frecuencias
subplot(2,1,1); stem(t,x,'-r'); axis([-3*a 3*a -1 1.5]); xlabel('nT_s'); ylabel('x(nT_s)');
title(strcat('Onda rectangular con a = ', num2str(a)));
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;
subplot(2,1,2); stem(f-(0.5),fftshift(abs(X)),'-b'); axis([-length(t)/2 length(t)/2 -.5 2*a]); xlabel('f'); ylabel('|X(f)|');
xlabel('f');
ylabel('|X(f)|');
title('Transformada de Fourier');
grid;
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';