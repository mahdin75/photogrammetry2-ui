function o = isNotZero(a)
o = 0;
    for i = 1: length(a)
        if a(i)
            o = 1;
        end
    end
end
