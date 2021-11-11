% Obtenemos los datos de la Funcion FFT del Punto 2
[X, t,f0,fs,Ts, f, a] = Punto2A;

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
xlabel('f',"FontSize",8),
ylabel('X(f)',"FontSize",8);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;
%Subplot Pulso Frecuencia total
subplot(2,2,[3, 4]);
plot(t,abs(ifft(X./Ts)),'-r')
axis([-2*a 2*a -1 2]);
title("Pulso Frecuencia Total","FontSize",8);
xlabel('t',"FontSize",8),
ylabel('X(t)',"FontSize",8);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;

figure(3)
%*******************************
%Subplot LPF - FILTRO PASA BAJAS
lowFilter = fftshift(X).*H_LPF_2(f); %Filtrado
subplot(4,2,1);
plot(f,abs(lowFilter)); %Gráfica Filtro pasa bajas
axis([-15 15 -5 20]);
title("Low-Pass Filter (Filtro pasa bajas)","FontSize",8); 
xlabel('f',"FontSize",8),
ylabel('|X(f)|',"FontSize",8);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;
%Subplot LPF Pulse
subplot(4,2,2);
plot(t,abs(ifft(ifftshift(lowFilter./Ts))),'-r') %Gráfica Pulso en el tiempo (Filtro pasa bajas)
axis([-2*a 2*a -1 2]);
title(" Low-Pass Filter Pulse (Pulso Filtro pasa bajas)","FontSize",8); 
xlabel('t',"FontSize",8),
ylabel('lowFilter(t)',"FontSize",8);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;
%******************************
%Subplot HPF - FILTRO PASA ALTAS
highFilter = fftshift(X).*H_HPF(f); %Filtrado
subplot(4,2,3);
plot(f,abs(highFilter)) %Gráfica Filtro pasa altas
axis([-15 15 -5 20]);
title("High-Pass Filter (Filtro pasa altas)","FontSize",8);
xlabel('f',"FontSize",8),
ylabel('|X(f)|',"FontSize",8);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;
%Subplot HPF Pulse
subplot(4,2,4);
plot(t,abs(ifft(ifftshift(highFilter./Ts))),'-r') %Gráfica Pulso en el tiempo (Filtro pasa altas)
axis([-2*a 2*a -1 2]);
title("High-Pass Filter Pulse (Pulso Filtro pasa altas)","FontSize",8);
xlabel('t',"FontSize",8),
ylabel('highFilter(t)',"FontSize",8);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;
%******************************
%Subplot BPF - FILTRO PASA BANDAS
PassBandFilter = fftshift(X).*H_BPF(f); %Filtrado
subplot(4,2,5);
plot(f,abs(PassBandFilter)) %Gráfica del filtro pasabandas.
axis([-wm*2 wm*2 -5 20]);
title("Band-pass filter (Filtro pasa bandas)","FontSize",8);
xlabel('f',"FontSize",8),
ylabel('|X(f)|',"FontSize",8);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;
%Subplot BPF Pulse
subplot(4,2,6);
plot(t,abs(ifft(ifftshift(PassBandFilter./Ts))),'-r'); %Gráfica Pulso en el tiempo (Filtro pasa bandas)
axis([-2*a 2*a -1 2]);
title("Band-pass filter Pulse (Pulso Filtro pasa bandas)","FontSize",8);
xlabel('t',"FontSize",8),
ylabel('PassBandFilter(t)',"FontSize",8);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;
%******************************
%Subplot BSF - FILTRO SUPRIME BANDAS
bandStopFilter = fftshift(X).*H_BSF(f); %Filtrado
subplot(4,2,7);
plot(f,abs(bandStopFilter)); %Gráfica del filtro suprime bandas.
axis([-15 15 -5 20]);
title("Band-stop filter (Filtro suprime bandas)","FontSize",8);
xlabel('f',"FontSize",8),
ylabel('|X(f)|',"FontSize",8);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;
%Subplot BSF Pulse
subplot(4,2,8);
plot(t,abs(ifft(ifftshift(bandStopFilter./Ts))),'-r') %Gráfica Pulso en el tiempo (Filtro pasa bandas)
axis([-2*a 2*a -1 2]);
title("Band-stop filter Pulse (Pulso Filtro suprime bandas)","FontSize",8);
xlabel('t',"FontSize",8),
ylabel('bandStopFilter(t)',"FontSize",8);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;



















