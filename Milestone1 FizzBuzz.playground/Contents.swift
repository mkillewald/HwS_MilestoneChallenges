//: Playground - noun: a place where people can play

import UIKit

// Hacking with Swift Guide Milestone 1 Challenge: Fizz Buzz test

func fizzBuzz(number: Int) -> String {
    if number % 3 == 0 && number % 5 == 0 {
        return "Fizz Buzz"
    } else if number % 3 == 0 {
        return "Fizz"
    } else if number % 5 == 0 {
        return "Buzz"
    } else {
        return String(number)
    }
}

fizzBuzz(number: 3)
fizzBuzz(number: 5)
fizzBuzz(number: 15)
fizzBuzz(number: 16)

for number in 1 ... 100 {
    print(fizzBuzz(number: number))
}



 