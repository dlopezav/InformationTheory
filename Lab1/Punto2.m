a = input('Ingrese el valor de a = ');
T=2*a;                                                                       % duración de la señal
f0=1;                                                                      % valor de la frecuencia lineal
fs=100*f0; Ts=4*a/fs;                                                % intervalo de muestreo y frecuencia de muestreo
t= [-2*a:Ts:2*a];                                                             % vector de tiempo
x= (abs(t)< a); X=fft(x)*Ts;                             % sinusoidal muestreada y su transformada de Fourier
f= [-2*a:4*a/100:2*a];  % vector de frecuencias
subplot(2,1,1); stem(t,x,'r--o'); axis([-15 15 -1 1.5]); xlabel('nT_s'); ylabel('x(nT_s)');
subplot(2,1,2); stem(f,fftshift(abs(X)),'b--o'); axis([-2*a 2*a -.5 2*a]); xlabel('f'); ylabel('|X(f)|');
