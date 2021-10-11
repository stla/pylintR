import numpy as np
import copy

def function_without_docstring(x, y):
  return x + y

def comparison_with_None(x):
  """Compare with None"""
  if x == None:
    return 0
  else:
    return 1
    
def check_type(x):
  """Use isinstance instead"""
  if type(x) == list:
    print("x is a list")
  else:
    print("x is not a list")

def f(this, function, has, a, lot, of, arguments):
  print("And we don't use them")

