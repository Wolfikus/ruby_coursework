def alg_euclid_ext(x,mod,result=1)
    for n in 0..mod-1 do  
        res = (n*x)%mod
        if res == result 
            puts "Result is: #{n}"
            break
        elsif n >= mod-1
            puts "No result found"
        end
    end
end

#alg_euclid_ext(125,322)
#alg_euclid_ext(125,232)
#alg_euclid_ext(128,251)