
% Muestreo
t0=2*pi;                                                                     % duración de la señal
Ts=1/10; fs=1/Ts;                                                 % intervalo de muestreo y frecuencia de muestreo
t=[0:Ts:t0];                                                           % vector de tiempo
fm=2;
%fs = 50, fs>fM
%x=2*sin(t)+3*sin(3*t);                                % sinusoidal muestreada y su transformada de Fourier
x=sin(t)
figure(1)
stem(t,x)
xlabel('Tiempo'); ylabel('x(nT_s)'); title('Muestreo');grid;
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

%Cuantización
xmax=1
n=3
xq=cuantUniforme(x,xmax,n);            % sinusoidal cuantizada y su transformada de Fourier


figure(2);
subplot(2,1,1); stem(t,x,'k');xlabel('nT_s'); ylabel('x(nT_s)');grid;
title("Sinusoidal muestreada");
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
subplot(2,1,2); stem(t,xq,'k');  xlabel('nT_s'); ylabel('x_q(nT_s)');grid;
title("Sinusoidal cuantizada");
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';


% Codificacion: Pasar el valor cuantizado a un codigo numerico.
% En este caso es un codigo binario.
L = 2^n;
ranges = linspace(-xmax,xmax,L+1) % Niveles de cuantización
figure(3);
plot(t,x,"color","black"); %Función xt
title("Sinusoidal cuantificada CODIFICACIÓN");
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
  text(2*pi+1,(ranges(i+1)+ranges(i+2))/2,txt); %Puntos medios (Niveles de cuantificación)
end
figure(4);


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
subplot(3,1,1);
t2=[0:0.01:length(finalbinary)];  
plot(t2,NRZ(finalbinary,1)); axis([0 length(x) -.5 (amplitud+.5)]);xlabel('t'); ylabel('NRZ');title("Unipolar NRZ");
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;

%Bipolar NRZ.
subplot(3,1,2);
plot(t2,BNRZ(finalbinary,1)); axis([0 length(x) (-amplitud-.5) (amplitud+.5)]);xlabel('t'); ylabel('BNRZ');title("Bipolar NRZ");
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;

%Unipolar RZ
subplot(3,1,3);
plot(t2,RZ(finalbinary,1)); axis([0 length(x) -.5 (amplitud+.5)]);xlabel('t'); ylabel('URZ');title("Unipolar RZ");
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;

%Bipolar RZ
figure(5)
subplot(3,1,1);
plot(t2,BRZ(finalbinary,1)); axis([0 length(x) (-amplitud-.5)  (amplitud+.5)]);xlabel('t'); ylabel('BRZ');title("Bipolar RZ");
%t2=[0:0.01:6]; 
%plot(t2,BRZ([1 1 1 0 0 0],1));
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;

%AMI
subplot(3,1,2);
plot(t2,AMI(finalbinary,1)); axis([0 length(x) (-amplitud-.5)  (amplitud+.5)]);xlabel('t'); ylabel('AMI');title("AMI");
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;

%MANCHESTER
subplot(3,1,3);
plot(t2,MANCHESTER(finalbinary,1)); axis([0 length(x) (-amplitud-.5)  (amplitud+.5)]);xlabel('t'); ylabel('MANCHESTER');title("MANCHESTER");
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;

%RECUPERANDO LA SEÑAL
finalbinary;

deMod = t;
w = 2*pi*2*fs;

% Recorrer cada una de las muestras 
for i = 1:length(t)
  deMod(i) = 0;
  %Ciclo for para aplicar la sumatoria de la formula 5.2
  for k = 1:length(t)
    deMod(i) = deMod(i) + (x(i) * sinc(w*(t(i)-t(k))));
    deMod(i) = deMod(i) + (-x(i) * sinc(w*(t(i)+t(k))));
  end
end

figure(6);
%Grafica de la demodulación
plot(t, deMod); xlabel("t"); ylabel("m(t)"); title("Resultado demodulado");
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid;
