
% Muestreo
t0=1;                                                                     % duración de la señal
Ts=1/100; fs=1/Ts;                                                 % intervalo de muestreo y frecuencia de muestreo
t=[0:Ts:t0];                                                           % vector de tiempo

%fM = 4, fs = 100, fs>fM
x=sin(2*pi*2*t); X=fft(x)*Ts;                                  % sinusoidal muestreada y su transformada de Fourier

%Cuantización
xmax=1
n=3
xq=cuantUniforme(x,xmax,n); Xq=fft(xq)*Ts;           % sinusoidal cuantizada y su transformada de Fourier
f=[0:100];     % vector de frecuencias

figure(1);
subplot(2,2,1); plot(t,x,'k'); axis([0 1 -1.1 1.1]); xlabel('nT_s'); ylabel('x(nT_s)');grid;
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
subplot(2,2,2); stem(f-(fs/2),fftshift(abs(X)),'k'); axis([-25 25 -0.6 0.6]); xlabel('f'); ylabel('|X(f)|');grid;
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
subplot(2,2,3); stem(t,xq,'k'); axis([0 1 -1.1 1.1]); xlabel('nT_s'); ylabel('x_q(nT_s)');grid;
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
subplot(2,2,4); stem(f-(fs/2),fftshift(abs(Xq)),'k'); axis([-25 25 -0.6 0.6]); xlabel('f'); ylabel('|X_q(f)|');grid;
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';


% Codificacion: Pasar el valor cuantizado a un codigo numerico.
% En este caso es un codigo binario.
L = 2^n;
ranges = linspace(-xmax,xmax,L+1) % Niveles de cuantización
figure(2);
plot(t,x,"color","black"); %Función xt
title("Sinusoidal y Sinusoidal cuantificada");
xlabel("x");
ylabel("F(x)");
hold on;
stem(t,xq);
hold off;
yticks(ranges);
grid;
finalbinary = [];
for i=0:L-1
  integer = int2str(i); %Represetación entera
  binary = dec2bin(i,n); %Representación binaria
  txt = strcat(integer,", (",binary,")"); %Ytick de la codificación
  text(1.01,(ranges(i+1)+ranges(i+2))/2,txt) %Puntos medios (Niveles de cuantificación)
end
figure(3);


q=floor(L*((x+xmax)/(2*xmax)));
i=find(q>L-1); q(i)=L-1;                           % q={...,-2,-1,0,1,2,...,L-1}
i=find(q<0); q(i)=0;   

for i=1:length(t)
  binary = dec2bin(q(i),n); %Representación binaria
  finalbinary = [finalbinary str2double(binary(1)) str2double(binary(2)) str2double(binary(3))];
end

finalbinary;
amplitud = 1;

%Unipolar NRZ.
subplot(2,3,1);
t2=[0:0.01:length(finalbinary)];  
plot(t2,NRZ(finalbinary,1)); axis([0 length(x) -.5 (amplitud+.5)]);xlabel('t'); ylabel('NRZ');title("Unipolar NRZ");
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;

%Bipolar NRZ.
subplot(2,3,2);
plot(t2,BNRZ(finalbinary,1)); axis([0 length(x) (-amplitud-.5) (amplitud+.5)]);xlabel('t'); ylabel('BNRZ');title("Bipolar NRZ");
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;

%Unipolar RZ
subplot(2,3,3);
plot(t2,RZ(finalbinary,1)); axis([0 length(x) -.5 (amplitud+.5)]);xlabel('t'); ylabel('URZ');title("Unipolar RZ");
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;

%Bipolar RZ
subplot(2,3,4);
plot(t2,BRZ(finalbinary,1)); axis([0 length(x) (-amplitud-.5)  (amplitud+.5)]);xlabel('t'); ylabel('BRZ');title("Bipolar RZ");
%t2=[0:0.01:6]; 
%plot(t2,BRZ([1 1 1 0 0 0],1));
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;

%AMI
subplot(2,3,5);
plot(t2,AMI(finalbinary,1)); axis([0 length(x) (-amplitud-.5)  (amplitud+.5)]);xlabel('t'); ylabel('AMI');title("AMI");
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;

%MANCHESTER
subplot(2,3,6);
plot(t2,MANCHESTER(finalbinary,1)); axis([0 length(x) (-amplitud-.5)  (amplitud+.5)]);xlabel('t'); ylabel('MANCHESTER');title("MANCHESTER");
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;

%RECUPERANDO LA SEÑAL
finalbinary
