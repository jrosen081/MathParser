# MathParser

[![CI Status](https://img.shields.io/travis/jrosen081/MathParser.svg?style=flat)](https://travis-ci.org/jrosen081/MathParser)
[![Version](https://img.shields.io/cocoapods/v/MathParser.svg?style=flat)](https://cocoapods.org/pods/MathParser)
[![License](https://img.shields.io/cocoapods/l/MathParser.svg?style=flat)](https://cocoapods.org/pods/MathParser)
[![Platform](https://img.shields.io/cocoapods/p/MathParser.svg?style=flat)](https://cocoapods.org/pods/MathParser)

## What it is:
MathParser is a library written in swift that will allow a user to parse a String.

## What you can do with it:
* Addition
* Subtraction
* Multiplication
* Division
* Exponents
* Overload the operators.

## How to use:
Here is an example of how to use the library.
``` swift
let expr = Parser.parse(string: "1 + 2") // Will return an expression that can be evaluated.
let exprValue = expr?.evaluate() // Evaluates the expression (will be 3 in this example)
```

To overload operators (this can be done if wanted):
```swift
Operators.addOp = ">"
let ans = Parser.parse(string: "1 > 2")?.evaluate() // This will evaluate to 3 with the new operator
```

## Public methods:
* Parser.parse
  * This returns an Optional Expression. This will return nil if the String is unparseable.
* Expression.evaluate
  * This returns an Optional Decimal. This will only return nil if there is a division by 0.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

MathParser is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MathParser'
```

## Author

jrosen081, jrosen081@gmail.com

## License

MathParser is available under the MIT license. See the LICENSE file for more info.
