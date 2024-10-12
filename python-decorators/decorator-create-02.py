def mydec(func):
    def innerFunc(*args,**kwargs):
        print("Before Execution")
        returnValue = func(*args,**kwargs)
        print("After Execution")

        return returnValue

    return innerFunc

@mydec
def addThreeNumber(a,b,c):
    print("Inside the add number function")
    result = a+b+c
    return result

a,b,c=2,3,4
print("Result-->",addThreeNumber(a,b,c))

@mydec
def multiplyNumbers(a,b):
    print("Inside the multiplication Function")
    result = a*b
    print("Multiplication Result -->{}".format(result))

multiplyNumbers(2,10)
