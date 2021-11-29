function final = AMI(x, amplitud)
    t=[0:0.01:length(x)];  
    final = [];
    it = 1;
    init = 1;
    counter = 1;
    for i=1:length(x)
        for j=init:length(t)
            if t(j)<=it
                if(x(i) == 0)
                    final = [final x(i)];
                else
                    if(it-t(j)>=1/2)
                        if(mod(counter,2)~=0)
                            final = [final x(i)*amplitud];
                        else
                            final = [final -x(i)*amplitud];
                        end
                    else
                        final = [final 0];
                    end
                end
            else
                if(x(i)==1)
                    counter = counter +1;
                end
                it=it+1;
                init = j;
                break
            end
        end
        
    end