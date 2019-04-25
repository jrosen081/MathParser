//
//  PowExpression.swift
//  MathParser_Example
//
//  Created by Jack Rosen on 4/24/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

struct PowExpression: Expression {
	let leftExpression: Expression
	let rightExpression: Expression
	
	
	/// Evaluates the subtraction
	func evaluate() -> Decimal? {
		return leftExpression.evaluate() ^^^ rightExpression.evaluate()
	}
}
