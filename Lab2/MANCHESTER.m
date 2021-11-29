function final = MANCHESTER(x, amplitud)
    t=[0:0.01:length(x)];  
    final = [];
    it = 1;
    init = 1;
    for i=1:length(x)
        for j=init:length(t)
            if t(j)<=it
                if(x(i) == 0)
                    if(it-t(j)<=1/2)
                        final = [final amplitud];
                    else
                        final = [final -amplitud];
                    end
                else
                    if(it-t(j)>=1/2)
                        final = [final x(i)*amplitud];
                    else
                        final = [final -x(i)*amplitud];
                    end
                end
            else
                it=it+1;
                init = j;
                break
            end
        end
    end