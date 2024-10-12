def create_addr(x):
    def addr(y):
        return x+y
    return addr

add = create_addr(20)
print(add(20))
