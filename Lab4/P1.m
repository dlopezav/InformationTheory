clc;

k = 3;
n = 6;
m = n-k;

c4 = [1 0 1];
c5 = [1 1 1];
c6 = [1 1 0];
  
%Matriz P
P = [c4; c5; c6];

%Matriz Identidad K
I = eye(k);

%Matriz Generadora - Union Identidad y P: 
G = [I,(P')];

%Matriz Identidad m=n-k:
I = eye(m);

%Matriz H - Union Identidad(m) y P:
H = [P,I];

%Matriz H transpuesta:
Ht = H';




%Las Palabras del Codigo:
npalabras = 2^k;
palabras = [];
res = [];

for i = 0: npalabras-1
    b = (de2bi(i,k,'left-msb'));
    res = b*G;
    for j = 1:length(res)
        res(j) = mod(res(j),2);
    end
    palabras = [palabras;res];
end

menu = input('Ingrese una opción:\n 1 Codificar\n 2 Decodificar');

switch menu
    case 1 
        %Codificar
        d = input('Ingrese el vector a codificar: '); %Ejemplo d5
        fila = d(1)*4+d(2)*2+d(3)*1+1;                        %Binario a Decimal
        disp('La palabra codificada es: ');
        disp(palabras(fila, :));                              %Palabra Codificada
    case 2
        r = input('Ingrese la palabra a decodificar: ');
        syndrome = r * Ht;                                  %Sindrome S

        for i = 1: length(syndrome)
            syndrome(i) = mod(syndrome(i),2);
        end

        disp('El codigo inicial es: ');
        disp(r);

        error = 0;

        for i=1:n
            if isequal(syndrome,Ht(i, :))
                error = i;
            end
        end

        if error > 0
            if r(error) == 0
                r(error) = 1;
            else
                r(error) = 0;
            end
        end

        disp('El codigo final es: ');
        disp(r);
    
    otherwise

        disp('No es una opcion valida ');
        
end