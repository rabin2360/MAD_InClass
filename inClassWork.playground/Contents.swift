//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
let classMax = 20

var message: String = "voila!"

print("THis is astring")
print(message, terminator:"")
print(message + " more:", terminator:"")

var firstName = "first"
var lastName = "second"
print(firstName+" "+lastName)


let age = 20

if age<21
{
    print("No booze!")
}
else
{
    print("Legal booze")
}

//there is no break in switches

//there is a default needed, if nothing else matches


//LOOOPS
for i in 0...age
{
    print(i)
}


//Functions 
func sayHi()
{
    print("Howow")
}

sayHi()