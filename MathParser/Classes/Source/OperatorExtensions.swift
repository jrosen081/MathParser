//
//  OperatorExtensions.swift
//  MathParser_Example
//
//  Created by Jack Rosen on 4/24/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

infix operator  +++
infix operator ---
infix operator ***
infix operator /+/
infix operator ^^^

extension Optional where Wrapped == Decimal{
	static func +++ (lhs: Wrapped?, rhs: Wrapped?) -> Wrapped? {
		if let l = lhs, let r = rhs {
			return l + r
		} else {
			return nil
		}
	}
	
	static func --- (lhs: Wrapped?, rhs: Wrapped?) -> Wrapped? {
		if let l = lhs, let r = rhs {
			return l - r
		} else {
			return nil
		}
	}
	
	static func *** (lhs: Wrapped?, rhs: Wrapped?) -> Wrapped? {
		if let l = lhs, let r = rhs {
			return l * r
		} else {
			return nil
		}
	}
	
	static func /+/ (lhs: Wrapped?, rhs: Wrapped?) -> Wrapped? {
		if let l = lhs, let r = rhs, r != 0 {
			return l / r
		} else {
			return nil
		}
	}
	
	static func ^^^ (lhs: Wrapped?, rhs: Wrapped?) ->Wrapped? {
		if let l = lhs, let r = rhs {
			var value: Wrapped = 1
			for _ in 0 ..< Int(r.doubleValue){
				value *= l
			}
			return value
		} else {
			return nil
		}
	}
}

extension Decimal {
	var doubleValue: Double {
		return (self as NSDecimalNumber).doubleValue
	}
}
