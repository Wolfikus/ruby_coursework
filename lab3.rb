require 'mathn'

x1 = [[-1,-1,1,-1],[-1,1,1,-1],[1,1,1,-1],[-1,1,1,-1],[-1,1,1,-1],[1,1,1,1]]
x3 = [[1,1,1,1],[-1,-1,1,1],[1,1,1,1],[-1,-1,1,1],[-1,-1,1,1],[1,1,1,1]]
x7 = [[1,1,1,1],[-1,-1,-1,1],[-1,-1,1,-1],[-1,1,-1,-1],[1,-1,-1,-1],[1,-1,-1,-1]]

class Vector
  def transpose
    result = []
    self.count.times do |i|
        result[i] = []
        result[i][0] = self[i]
    end
    result
  end
end

def vectorizeByRow(matrix)
    vect_row = []
    
    matrix.each { |sub_array| sub_array.each do |x| 
            vect_row.push(x) 
        end
    }
    
    vect_row
end

def matrixNull(matrix)
    arr = matrix.to_a
    for i in 0..arr.length
        arr[i][i] = 0
    end
    Matrix[*arr]
end

def distortVector(v)
    arr = v.to_a

    arr[8] = arr[8] * -1
    Vector[*arr]
end

def rnsHopfield(dist_vector,matrix)
    result = matrix * dist_vector
    arr = result.to_a
    arr.collect! {|x|
        if x<0
            x=-1
        else x=1
        end
    }
    result = Vector[*arr]
    result
end

def recogniser(matrix)
    x_v = Vector[*vectorizeByRow(matrix)]
    x_m = x_v * x_v.covector
    x_s = x_m * 3
    x_n = matrixNull(x_s)
    x_d = distortVector(x_v)
    x_r = rnsHopfield(x_d,x_n)
    x_c = x_v - x_r
    
    puts "-------------------------------------"
    puts "INITIAL VECTOR ---" + x_v.to_a.to_s
    puts "DISTORTED VECTOR ---" + x_d.to_a.to_s
    puts "RESTORED VECTOR ---" + x_r.to_a.to_s
    puts "COMPAREMENT VECTOR ---" + x_c.to_a.to_s
    puts "-------------------------------------"
end

recogniser(x1)
#recogniser(x3)
#recogniser(x7)