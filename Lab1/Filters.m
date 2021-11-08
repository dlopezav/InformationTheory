[X, t,f0,fs,Ts, f] = Punto2;
wc = input('Ingrese el valor de wc = ');
wm = input('Ingrese el valor de wm, debe ser mayor a wc = ');

H_LPF = @(t) (abs(t) <= wc);
H_HPF = @(t) (abs(t) >= wc);
H_BPF = @(t) (wc <= abs(t) & abs(t) <= wm);
H_BSF = @(t) ~(wc <= abs(t) & abs(t) < wm);

%*******************************


%Subplot Frecuencia total
subplot(6,2,[1 , 2]);
stem(f-(0.5),fftshift(abs(X)),'-b')

subplot(6,2,[3, 4]);
stem(t,abs(ifft(ifftshift(X./Ts))))

%*******************************
%Subplot LPF 
lowFilter = fftshift(abs(X)).*H_LPF(f-(0.5));
subplot(6,2,5);
stem(f-(0.5),lowFilter)

%Subplot LPF Pulse
subplot(6,2,6);
stem(t,abs(ifft(ifftshift(lowFilter./Ts))))

%******************************
%Subplot HPF 
highFilter = fftshift(abs(X)).*H_HPF(f-(0.5));
subplot(6,2,7);
stem(f-(0.5),highFilter)

%Subplot HPF Pulse
subplot(6,2,8);
stem(t,abs(ifft(ifftshift(highFilter./Ts))))


%******************************
%Subplot BPF 
PassBandFilter = fftshift(abs(X)).*H_BPF(f-(0.5));
subplot(6,2,9);
stem(f-(0.5),PassBandFilter)

%Subplot BPF Pulse
subplot(6,2,10);
stem(t,abs(ifft(ifftshift(PassBandFilter./Ts))))

%******************************
%Subplot BSF 
bandStopFilter = fftshift(abs(X)).*H_BSF(f-(0.5));
subplot(6,2,11);
stem(f-(0.5),bandStopFilter)

%Subplot BSF Pulse
subplot(6,2,12);
stem(t,abs(ifft(ifftshift(bandStopFilter./Ts))))





















