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


//tuples
let violet = ("#EE82EE", 238, 130, 238)
print("Violet is"+violet.0)

//assigning the values in the tuples variables in one go
let(hex, red, green, blue)  = violet
print("violet is "+hex)

//optionals
var score: Int?
//since it's optional, it will store nil
print(score)

score = 80
//printing WITHOUT unwrapping
print(score)
//printing AFTER unwrapping
print(score!)

//unwrapping the optional
if(score != nil)
{
    print(score!)
}

//unwrapping and assigning a local var to the optional
if let currentScore = score
{
    print(currentScore)
}

//implicitly unwrapped optionals cannot be nil during run time - CRASHES! WORLD WILL END!!

let newScore : Int! = 95
print("value \(newScore)")

