%Ä¿±êº¯Êý
function f = function_b3_1(x)
    r_in = x(1:30);
    x_in = x(31:60);
    r_out = x(61:90);
    x_out = x(91:120);
    f = sum(r_in .* x_in) - sum(r_out .* x_out) + 25.5;
end
