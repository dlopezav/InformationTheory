function Lab4Punto1()
  
  % Entradas:
  % px: Probabilidad de ocurrencia del simbolo xi
  % pyx: Matriz Canal
  px = input('Ingrese px = ');
  pyx = input('Ingrese pyx= ');
  
  %[P(Y)] Probabilidad de Ocurrencias
  fprintf("[P(Y)] es: \n")
  py = px * pyx
  
  %[P(X,Y)] Probabilidad de de Transmitir xi y recibir yi
  pxd = diag(px);
  fprintf("[P(X,Y)] es: \n")
  pxy = pxd * pyx
  
  %H(X) entropia de la fuente x
  fprintf("H(X) es: \n")
  hx = sum(px .* log2(1 ./ px))
  
  %H(Y|X) incertidumbre promedio del canal de salida
  fprintf("H(Y|X) es: \n")
  hyx = sum(pyx .* log2(1 ./ pyx))
  
  %H(Y)
  fprintf("H(Y) es: \n")
  hy = sum(py .* log2(1 ./ py))
  
  %H(X,Y) incertidumbre promedio del canal de comunicación
  fprintf("H(X,Y) es: \n")
  hxy =  hyx + hx
  
  %I(X;Y) incertidumbre sobre la entrada del canal que se resuelve observando la salida del canal
  fprintf("I(X;Y) es: \n")
  hxy = hxy - hy; 
  ixy = hx - hxy
  
  %Cs Capacidad por simbolo del canal; Se calcula si  
  if (size(pyx,1)==2 && size(pyx,2)==2)
    if((isequal(sum(pyx,2),[1;1])) && (isequal(sum(pyx,1),[1 1])))
      p = pyx(1,1);
      fprintf("Cs es: \n")
      Cs = 1 + p*log2(p)+(1-p)*log2(1-p)
    end
  end
end