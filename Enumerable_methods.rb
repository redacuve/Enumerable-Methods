module Enumerable
    def my_each
        if block_given?
            i = 0
            while i < self.length
                yield(self[i])
                i += 1
            end
        else
            "No block given"
        end
    end

    def my_each_with_index
        if block_given?
            i = 0
            while i < self.length
                yield(self[i], i)
                i += 1
            end
        else
            "No block given"
        end
    end

    def my_select
        ary = []
        if block_given?
            self.my_each{|elem| ary.push(elem) if yield(elem)}
        else
            "No block given"
        end
        return ary
    end

    def my_all?
        if block_given?
            self.my_each{|elem|
                unless yield(elem)
                    return false
                end
            }
            return true
        else
            self.my_each{|elem|
                unless elem
                    return false
                end
            }
            return true
        end
    end

    def my_any?
        if block_given?
            self.my_each{|elem|
                if yield(elem)
                    return true
                end
            }
            return false
        else
            self.my_each{|elem|
                if elem
                    return true
                end
            }
            return false
        end
    end

    def my_none?
        if block_given?
            self.my_each{|elem|
                if yield(elem)
                    return false
                end
            }
            return true
        else
            self.my_each{|elem|
                if elem
                    return false
                end
            }
            return true
        end
    end

    def my_count
        if block_given?
            c = 0
            self.my_each{|elem|
                if yield(elem)
                    c += 1
                end
            }
            return c
        else
            c = 0
            self.my_each{|elem|
                c += 1
            }
            return c
        end
    end

    def my_map(proc = nil)
        if proc
            ary = []
            self.my_each{|elem|
                ary.push(proc.call(elem))
            }
            return ary
        elsif block_given?
            ary = []
            self.my_each{|elem|
                ary.push(yield(elem))
            }
            return ary
        else
            return to_enum(:my_map)
        end
    end

    def my_inject(param = nil)
        if block_given?
            if param
                c = param
            else
                c = 0
            end
            self.my_each{|elem|
                c = yield(c,elem)
            }
            return c
        else
            "No block Given (LocalJumpError)"
        end
    end
end

def multiply_els(arr)
    arr.my_inject(1){|product, element| product * element}
end



