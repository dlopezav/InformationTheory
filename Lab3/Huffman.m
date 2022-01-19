function Huffman(cadena, defi, probs)
    

num_bits = ceil(log2(length(probs)))

%Esto simplementes es para mostrar como se aparean las probabilidades
for i = 1:length(probs)
	display(strcat(cadena(i), ' -->  ',num2str(probs(i))));
end

total = sum(probs);

% Proceso de codificado, se almacenan las variables en un cell array 
%(que puede guardar cualquier cosa)
for i = 1:length(cadena)
    encoding{i} = cadena(i);
end


inicialEnc = encoding;
inicialPro = probs;


% Iniciar el proceso en el que se combinan probabilidades
encodingProbs = probs;
rear = 1;
while(length(encodingProbs) > 1)
    
    %Ordenar las probabilidaes
    [encodingProbs,indices] = sort(encodingProbs, 'ascend');
    %Ordenar por los indices
    encoding = encoding(indices);
    encoding
    
    %Crear nuevos simbolos  -> Se unen las probabilidades mas pequeñas y se
    %suman los valores
    new_node = strcat(encoding(2), encoding(1));
    new_prob = sum(encodingProbs(1:2));
    
    % Sacar los simbolos que ya se han usado
    encoding = encoding(3:length(encoding));  % Se reduce tamaño
    encodingProbs = encodingProbs(3:length(encodingProbs));
    
    % Agregar el simbolo unificado a la lista que se acaba de crear
    encoding = [encoding, new_node];
    encodingProbs = [encodingProbs, new_prob];
    
    display('Arreglo de simbolos:  ')
    display(encoding)
    display('Arreglo de probabilidades:  ')
    display(encodingProbs)
    
    %Guardar el nuevo simbolo unificado a una nueva tabla 
    newq_str(rear) = new_node;
    newq_prob(rear) = new_prob;
    rear = rear + 1;
end

% Unir los todas los simbolos, los originales y los que se crearon al unir
% las probabilidades
arbol = [newq_str, inicialEnc];
arbolPro = [newq_prob, inicialPro];
%Organizar todos los elementos
[sortedArbolPro, indices] = sort(arbolPro, 'descend');
sortedArbol = arbol(indices);   % Se ordena de acuerdo a las probabilidades

% Aqui ya se tienen juntas las probabilidades y esta arado el arbol
display("Union de los elementos de la entrada por peso de sus probabiliades")
display(sortedArbol)
display(sortedArbolPro)

padre(1) = 0;
hijo = 2;
for i = 2: length(sortedArbol)
    elemento = sortedArbol{i};
    
    % se buscar encontrar cual es el padre de este elemento, es decir que
    % el hijo deberia ser una subcadena de este
    count = 1;
    posiblePadre = sortedArbol{i-count};
    busqueda = strfind(posiblePadre, elemento);
    while(isempty(busqueda))
        count =  count + 1;
        posiblePadre = sortedArbol{i-count};
        busqueda = strfind(posiblePadre, elemento);
    end
    padre(i) = i - count;
end
    
display("Apas");
display(padre);


% Esto solo es la representacion 
treeplot(padre);
title(strcat('Huffman Coding Tree - "',cadena,'"'));


% Para asignar los codigos a los componentes se puede poner lo siguiente: 
[xs,ys,h,s] = treelayout(padre);
% Donde se aprovecha las propieades de los arboles


%Poner los textos en cada uno de los nodos
text(xs,ys, sortedArbol);

%Asignar los pesos 

for i = 2:length(sortedArbol)
	% Get my coordinate
	my_x = xs(i);
	my_y = ys(i);

	% Get parent coordinate
	parent_x = xs(padre(i));
	parent_y = ys(padre(i));

	% Calculate weight coordinate (midpoint)
	mid_x = (my_x + parent_x)/2;
	mid_y = (my_y + parent_y)/2;

	% Calculate weight (positive slope = 1, negative = 0)
	slope  = (parent_y - my_y)/(parent_x - my_x);
	if (slope > 0)
		weight(i) = 1;
	else
		weight(i) = 0;
	end
	text(mid_x,mid_y,num2str(weight(i)));
end


% Asignar los codigos a los valores:
for i = 1:length(sortedArbol)
    code{i} = '';
    index = i;
    p = padre(index);
    while(p ~= 0)
        w = num2str(weight(index));
        code{i} = strcat(w,code{i});
        index = padre(index);
        p = padre(index)
    end
end

codeBook = [sortedArbol', code']




end

