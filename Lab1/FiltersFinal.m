% Obtenemos los datos de la Funcion FFT del Punto 2
[X, t,f0,fs,Ts, f, a] = Punto2;

%Parametros
wc = input('Ingrese el valor de wc = ');
wm = input('Ingrese el valor de wm, debe ser mayor a wc = ');

% Low-Pass Filter (Filtro pasa bajas)
H_LPF_2 = @(t) (abs(t) <= wc);
% High-Pass Filter (Filtro pasa altas)
H_HPF = @(t) (abs(t) >= wc);
% Band-pass filter (Filtro pasa bandas)
H_BPF = @(t) (wc <= abs(t) & abs(t) <= wm);
% Band-stop filter (filtro suprime bandas)
H_BSF = @(t) ~(wc <= abs(t) & abs(t) < wm);

figure(2)
%*******************************


%Subplot Frecuencia total
subplot(2,2,[1 , 2]);
plot(f,fftshift(abs(X)),'-b')
axis([-20 20 -5 20]);
title("Frecuencia Total","FontSize",8);
xlabel('f',"FontSize",4),
ylabel('X(f)',"FontSize",4);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;
%Subplot Pulso Frecuencia total
subplot(2,2,[3, 4]);
plot(t,abs(ifft(X./Ts)),'-r')
axis([-2*a 2*a -1 2]);
title("Pulso Frecuencia Total","FontSize",8);
xlabel('t',"FontSize",4),
ylabel('X(t)',"FontSize",4);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;

figure(3)
%*******************************
%Subplot LPF 
lowFilter = fftshift(X).*H_LPF_2(f-(0.5));
subplot(4,2,1);
plot(f,abs(lowFilter))
axis([-15 15 -5 5]);
title("Low-Pass Filter (Filtro pasa bajas)","FontSize",8);
xlabel('t',"FontSize",4),
ylabel('f(t)',"FontSize",4);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;
%Subplot LPF Pulse
subplot(4,2,2);
plot(t,abs(ifft(ifftshift(lowFilter./Ts))),'-r')
axis([-2*a 2*a -1 2]);
title(" Low-Pass Filter Pulse (Pulso Filtro pasa bajas)","FontSize",8);
xlabel('t',"FontSize",4),
ylabel('lowFilter(t)',"FontSize",4);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;
%******************************
%Subplot HPF 
highFilter = fftshift(X).*H_HPF(f-(0.5));
subplot(4,2,3);
plot(f,abs(highFilter))
axis([-15 15 -5 20]);
title("High-Pass Filter (Filtro pasa altas)","FontSize",8);
xlabel('t',"FontSize",4),
ylabel('f(t)',"FontSize",4);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;
%Subplot HPF Pulse
subplot(4,2,4);
plot(t,abs(ifft(ifftshift(highFilter./Ts))),'-r')
axis([-2*a 2*a -1 2]);
title("High-Pass Filter Pulse (Pulso Filtro pasa altas)","FontSize",8);
xlabel('t',"FontSize",4),
ylabel('highFilter(t)',"FontSize",4);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;
%******************************
%Subplot BPF 
PassBandFilter = fftshift(X).*H_BPF(f-(0.5));
subplot(4,2,5);
plot(f,abs(PassBandFilter))
axis([-wm wm -5 20]);
title("Band-pass filter (Filtro pasa bandas)","FontSize",8);
xlabel('t',"FontSize",4),
ylabel('f(t)',"FontSize",4);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;
%Subplot BPF Pulse
subplot(4,2,6);
plot(t,abs(ifft(ifftshift(PassBandFilter./Ts))),'-r')
axis([-2*a 2*a -1 2]);
title("Band-pass filter Pulse (Pulso Filtro pasa bandas)","FontSize",8);
xlabel('t',"FontSize",4),
ylabel('PassBandFilter(t)',"FontSize",4);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;
%******************************
%Subplot BSF 
bandStopFilter = fftshift(X).*H_BSF(f-(0.5));
subplot(4,2,7);
plot(f,abs(bandStopFilter))
axis([-15 15 -5 20]);
title("Band-stop filter (Filtro suprime bandas)","FontSize",8);
xlabel('t',"FontSize",4),
ylabel('f(t)',"FontSize",4);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;
%Subplot BSF Pulse
subplot(4,2,8);
plot(t,abs(ifft(ifftshift(bandStopFilter./Ts))),'-r')
axis([-2*a 2*a -1 2]);
title("Band-stop filter Pulse (Pulso Filtro suprime bandas)","FontSize",8);
xlabel('t',"FontSize",4),
ylabel('bandStopFilter(t)',"FontSize",8);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;



















