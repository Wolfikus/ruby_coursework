require 'mathn'
require 'truth-table'

$w0 = 3
$w_vect = [2, 2, 2, 2]
$nu = 0.3
max_err = 0.1

F = Matrix[*TruthTable.new("x1 || !x2 || !(x3 || x4)").rows]
V = Vector[*TruthTable.new("x1 || !x2 || !(x3 || x4)").result]

def calculate_net(arr_of_variables)
    net_res = $w0
    arr_of_variables.each_with_index {|element, i|
        arr_of_variables[i] = ((element)? 1 : 0)
        net_res += $w_vect[i] * arr_of_variables[i]
    }
    net_res
end

def reference(x)
    x[0] || !x[1] || !(x[2] || x[3]) 
end

def f_haviside(net)
    if net >= 1
        1
    else
        0
    end
end

def d_hav(net)
    1
end

def f_tan(net)
    0.5 * (Math.tanh(net) + 1)
end

def d_tan(net)
    0.5 * (1 - tanh(net) ** 2)
end

1000.times do |n|
    sum_err = 0
    0.upto(F.row_count-1) { |i| 
                    vect = F.row(i).to_a
                    ref = ((reference(vect))? 1: 0)
                    f = f_haviside(calculate_net(vect))

                    if (ref-f).abs >= max_err
                        puts "Current Epoch: #{n+1}"
                        err = ref - f
                        dw = Vector[*vect] * 0.3 * err * d_hav(vect)
                        dw0 = 1 * 0.3 * err * d_hav(vect)
                        p $w_vect = dw + Vector[*$w_vect] 
                        p $w0 = dw0 + $w0
                        sum_err += err
                    end
    }
    
    if sum_err == 0
        puts "END on #{n+1} epoch"
        break
    end
end
