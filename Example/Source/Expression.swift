//
//  Expression.swift
//  MathParser_Example
//
//  Created by Jack Rosen on 4/24/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

public protocol Expression {
	// Evaluates the given expression and returns the value
	func evaluate() -> Decimal?
}



