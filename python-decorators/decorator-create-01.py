import time
import math

# take function as an argument
def calculate_time(func):
    def inner(*args,**kwargs):
        begin = time.time()
        func(*args,**kwargs)
        end = time.time()

        print("Total time taken -->",func.__name__ , end-begin)

    return inner

@calculate_time
def factorial(number):
    time.sleep(2)
    print(math.factorial(number))

factorial(10)
