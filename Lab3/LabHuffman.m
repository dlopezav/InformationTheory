% Función que para relizar la codificación del binaria mediante el
% algoritmo de Hoffman

%Recibe dos arreglos, el primero de simbolos y el segundo con las
%respetivas probabilidades
function LabHuffman(simbolos, probs)

%Veces que se unen las probabiliades menores 
pasos = length(simbolos)-1;

%Declarar en la que se guardan las probabilidades resultantes durante cada
%iteración
matrizPro = zeros(length(simbolos), pasos);

%Bucle sumar probabilidades menores
for i=1:pasos
    [probs,indices] = sort(probs, 'descend'); 
    simbolos = simbolos(indices);   %Ordenar simbolos
    probs = sort(probs, 'descend'); %Ordenar probabilidades
    largo = length(probs);
    new_pro = probs(largo) + probs(largo-1); %Suma de probabilidades
    new_sim = strcat(simbolos(largo), simbolos(largo-1)); %Concatenación de simbolos
    matrizPro(:, i) = [probs  zeros(1, i-1)]; %Agregar estado actual a 
    matrizSim(:, i) = [simbolos  zeros(1, i-1)]; % la matriz de simbolos y probablidades
    probs = probs(1:largo-2); %Elimimar y agregar la nueva probabilidad
    probs = [probs, new_pro];
    simbolos = simbolos(1:largo-2); %Elimimar y agregar el nuevo simbolo
    simbolos = [simbolos, new_sim];
end

%Definir matriz de odigos
matrizCod = strings(pasos, pasos);

%Inicializarla con los primeros simbolos
matrizCod(1,pasos) = "0";
matrizCod(2,pasos) = "1";


%Bucle para llenar la matriz de codigos
for j = pasos:-1:2     %Se recorre inversamente hasta la segunda columna
    for i = 1:pasos+1  %Se recorre cada simbolo (fila)
        simToCom = matrizSim(i,j); % Se extrae el simbolo de la mastriz
        if(simToCom ~= "0") 
           for k =1:pasos+1  %Se recorren las filas
                if(contains(simToCom,matrizSim(k,j-1))) %Si contiene la cadena 
                    matrizCod(k,j-1) = matrizCod(i,j);  %Se agrega el simbolo del padre
                end    
           end
           for k =1:pasos-1 %Se recorre la fila a la cual se acaba de agregar simbolos
               %Si al comparar dos las los elementos de una columna,
               %estos tiene los mismos simbolos, significa que obtuvieron
               %el simbolo del mismo padre, por lo cual ese simbolo debe
               %ser dividido en dos, es decir concatenear al final 0 y 1.
                if(strcmp(matrizCod(k,j-1),matrizCod(k+1,j-1)) & matrizCod(k+1,j-1) ~="")
                    matrizCod(k,j-1) = strcat(matrizCod(k,j-1),"0");
                    matrizCod(k+1,j-1) = strcat(matrizCod(k+1,j-1),"1");
                end    
           end 
        end
    end
end

%Corregir igualdad de codigo en la primera columna
for i = 1:pasos
        if(strcmp(matrizCod(i,1),matrizCod(i+1,1)))
            matrizCod(i,1) = strcat(matrizCod(i,1),"0");
            matrizCod(i+1,1) = strcat(matrizCod(i+1,1),"1");    
        end     
end

%Mostrar los resultados

disp('Matriz de probabilidades final')
matrizPro
disp('Matriz de Codigos final')
matrizCod = fillmissing(matrizCod,'constant',"")
disp('Matriz de Simbolos final')
matrizSim

Codificacion = [matrizSim(:,1) matrizCod(:,1)];
display(Codificacion)

end