##################### size_vs_duration.jl  #############################################
# 
# This code can be redistributed and/or modified
# under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
#  
# This program is distributed ny the authors in the hope that it will be 
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
#  
# If you use this code please cite:
#       H. Sun, I. Kryven, and G. Bianconi, “Critical time-dependent 
#       branching process modelling epidemic spreading with containment 
#       measures”, Journal of Physics A: Mathematical and Theoretical, 2022.
#
###################################################################################    
#
#     Hanlin Sun (hanlin.sun@qmul.ac.uk)
#    
####################################################################################

using PoissonRandom
using DelimitedFiles
using StatsBase
using SpecialFunctions

function weightedSample(num, prob)  # Sample the duration of infection from the input ''prob'' 
    # num: Number of samples
    # prob: D(t) sequence

    s = zeros(Int64, num)
    for i = 1:num
        comp = [0; cumsum(prob)] .< rand()
        j = 1
        while (comp[j] == 1)
            j += 1
        end
        s[i] = j - 1
    end
    return s
end

function main()
    max_duration = 10000    # Upper bound for the power-law distribution, for sampling the probability from the power-law distribution
    alpha = 2.2    # Exponent of the power-law distrbution
    repeat = 1000000    # Number of realizations of the avalanche

    Z_record = zeros(Int64, repeat)    # Record the size of the avalanche of each realization
    T_record = zeros(Int64, repeat)    # Record the duration of the avalanche of each realization

    # Generate the probability sequence D(t) up to t = max_duration, using the original definition with Gamma function

    prob = zeros(max_duration)
    for i = 1:max_duration
        prod = 1
        for j = 1:i-1
            prod = prod * (1 - (alpha - 1) / (j + alpha - 1))
        end
        prod = prod * (alpha - 1) / (i + alpha - 1)
        prob[i] = prod
    end
    prob = prob ./ sum(prob)



    l = 0.999 * (alpha - 2) / (alpha - 1)    # λ near the critical λc

    tt = 0
    @time for r = 1:repeat
        if mod(r, 1000) == 0
            @show r
        end
        total_infection = 1  # Start from a single seed
    
        T = weightedSample(1, prob)

        t = 1
        while length(T) > 0
            T = T[T.>=t]   # Remove the recovered nodes
            T1 = Int64[]
            for j = 1:length(T)
                dz = pois_rand(l)   # new infections
                total_infection += dz
                s = weightedSample(dz, prob)    # life-time of the new infections
                T1 = [T1; s]
            end

            T = [T; t .+ T1]

            t += 1

        end

        Z_record[r] = total_infection
        T_record[r] = t


    end

    data_record = [T_record, Z_record]
    open("data.txt", "w") do io
        writedlm(io, data_record)
    end
end

@time main()
