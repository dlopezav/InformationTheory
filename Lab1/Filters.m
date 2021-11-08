[X, t,f0,fs,Ts, f] = Punto2;
wc = input('Ingrese el valor de wc = ');
wm = input('Ingrese el valor de wm = ');


%H_LPF = @(t) heaviside(t+wc) - heaviside(t-wc);
H_LPF_2 = @(t) (abs(t) <= wc);
H_HPF = @(t) (abs(t) >= wc);
H_BPF = @(t) (wc <= abs(t) & abs(t) <= wm);
H_BSF = @(t) ~(wc <= abs(t) & abs(t) < wm);

%*******************************


%Subplot Frecuencia total
subplot(6,2,[1 , 2]);
plot(f-(0.5),fftshift(abs(X)),'-b')
axis([-80 80 -5 20]);
subplot(6,2,[3, 4]);
plot(t,abs(ifft(X./Ts)))
axis([-2*a 2*a -1 2]);
%*******************************
%Subplot LPF 
lowFilter = fftshift(X).*H_LPF_2(f-(0.5));
subplot(6,2,5);
plot(f-(0.5),abs(lowFilter))
axis([-40 40 -5 10]);
%Subplot LPF Pulse
subplot(6,2,6);
plot(t,abs(ifft(ifftshift(lowFilter./Ts))))
axis([-2*a 2*a -1 2]);
%******************************
%Subplot HPF 
highFilter = fftshift(X).*H_HPF(f-(0.5));
subplot(6,2,7);
plot(f-(0.5),abs(highFilter))
axis([-40 40 -5 20]);
%Subplot HPF Pulse
subplot(6,2,8);
plot(t,abs(ifft(ifftshift(highFilter./Ts))))

axis([-2*a 2*a -1 2]);
%******************************
%Subplot BPF 
PassBandFilter = fftshift(X).*H_BPF(f-(0.5));
subplot(6,2,9);
plot(f-(0.5),abs(PassBandFilter))
axis([-40 40 -5 20]);
%Subplot BPF Pulse
subplot(6,2,10);
plot(t,abs(ifft(ifftshift(PassBandFilter./Ts))))
axis([-2*a 2*a -1 2]);
%******************************
%Subplot BSF 
bandStopFilter = fftshift(X).*H_BSF(f-(0.5));
subplot(6,2,11);
plot(f-(0.5),abs(bandStopFilter))
axis([-40 40 -5 20]);
%Subplot BSF Pulse
subplot(6,2,12);
plot(t,abs(ifft(ifftshift(bandStopFilter./Ts))))
axis([-2*a 2*a -1 2]);




















