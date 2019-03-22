%目标函数
function f = function_b2_1(x)
    r_in = x(1:30);
    x_in = x(31:60);
    r_out = x(61:90);
    x_out = x(91:120);
    f = sum(r_in .* x_in) - sum(r_out .* x_out);
end
