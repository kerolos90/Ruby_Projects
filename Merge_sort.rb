def merge_sort(array)
    if array.length <3
        array.sort!
    else
       left =  merge_sort(array[0..array.length/2-1])
       right = merge_sort(array[array.length/2..array.length])
       merge(left, right)
    end
end


def merge(l,r,m_array=[])
    while !l.empty? && !r.empty?
        if l[0] < r[0]
            m_array.push(l[0])
            l.shift
        else 
            m_array.push(r[0])
            r.shift
        end
    end
    m_array = m_array + l + r
    m_array
end

arry = [2,3,1,5,3,1]
p arry
p merge_sort(arry)

