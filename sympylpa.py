# -*- coding: utf-8 -*-
"""
Created on Tue Jun 14 11:34:20 2022

@author: Bjarke
"""

import sympy as sp
import numpy as np



sp.init_printing()

# R1 = 5600
# R2 = 4700
# R3 = 27000
# c1 = 330e-12
# c2 = 33e-12


x = sp.Symbol('x', real=True,positive=True)
R1,R2,R3,c1,c2 = sp.symbols(['R1','R2','R3','c1','c2'], real=True,positive=True)
a,b,c,d,e,_2 = sp.symbols(['a','b','c','d','e','2'], real=True,positive=True)

ex = (R3/(R1+1j*x*c2*(R1*R2+R2*R3+R1*R3)-c2*c1*R1*R2*R3*x**2))
ex2 = R3/R1/sp.sqrt(2)
ex3 = a/(b+1j*c*x-d*x**2)
ex4 = e

sol = sp.solve(sp.Abs(ex)-ex2,x)
sol2 = sp.solve(sp.Abs(ex3)-ex4,x)
# print(sp.simplify(sol[0]))

soll = sol2[1]
s = soll.subs(e,a/b/sp.sqrt(_2))