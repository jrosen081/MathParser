//
//  Parser.swift
//  MathParser_Example
//
//  Created by Jack Rosen on 4/24/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

public class Parser {
	/// Parses the string into an expression.
	/// Will return nil if the string is not parseable.
	/// - parameter string: The string to parse
	/// - returns: An expression that will result in the value
	public static func parse(string: String) -> Expression? {
		let updatedString = Parser.changeMinusIntoOther(change: Operators.subOp, into: string)
		guard updatedString.contains(Operators.divOp) || updatedString.contains(Operators.multOp) || updatedString.contains(Operators.addOp) || updatedString.contains(Operators.subOp) ||  updatedString.contains(Operators.powOp) || Decimal(string) != nil else {
			return nil
		}
		if updatedString.contains(Operators.addOp) || updatedString.contains(Operators.subOp) {
			let addAll = updatedString.split(separator: Operators.addOp[Operators.addOp.startIndex]).map(String.init)
			let subMids = addAll.map({string in string.split(separator: Operators.subOp.first!).map(String.init)})
			return subMids.reduce(Decimal(0) as Expression, {(result: Expression?, next: [String]) -> Expression? in
				if let res = result {
					if let first = next.first {
						guard let value = next.dropFirst().reduce(Parser.parse(string: first.replacingOccurrences(of: "~", with: Operators.subOp)), { (insideResult: Expression?, unParsed: String) -> Expression? in
							if let val = insideResult, let nextVal = Parser.parse(string: unParsed.replacingOccurrences(of: "~", with: Operators.subOp)){
								return SubExpression(leftExpression: val, rightExpression: nextVal)
							} else {
								return nil
							}
						}) else {
							return nil
						}
						return AddExpression(leftExpression: res, rightExpression: value)
					} else {
						return res
					}
				} else {
					return nil
				}
			})
		} else if updatedString.contains(Operators.multOp) || updatedString.contains(Operators.divOp) {
			let multAll = updatedString.split(separator: Operators.multOp.first!).map(String.init)
			let divMids = multAll.map({string in string.split(separator: Operators.divOp.first!).map(String.init)})
			return divMids.reduce(Decimal(1), {(result: Expression?, next: [String]) -> Expression? in
				if let res = result {
					if let first = next.first {
						guard let out = next.dropFirst().reduce(Parser.parse(string: first.replacingOccurrences(of: "~", with: Operators.subOp)), { (insideResult: Expression?, unParsed: String) -> Expression? in
							if let val = insideResult, let nextVal = Parser.parse(string: unParsed.replacingOccurrences(of: "~", with: Operators.subOp)){
								return DivExpression(leftExpression: val, rightExpression: nextVal)
							} else {
								return nil
							}
						}) else  {
							return nil
						}
						return MultExpression(leftExpression: res, rightExpression: out)
					} else {
						return nil
					}
				} else {
					return nil
				}
			})
		} else if updatedString.contains(Operators.powOp) {
			let split = updatedString.split(separator: Operators.powOp.first!).lazy.map(String.init).map({$0.trimmingCharacters(in: .whitespaces)})
			if let first = split.last, let firstExpr = Parser.parse(string: first) {
				return split.dropLast().reversed().reduce(firstExpr as? Expression, {(result, next) in
					if let val = result, let nextVal = Parser.parse(string: next) {
						return PowExpression(leftExpression: nextVal, rightExpression: val)
					} else {
						return nil
					}
				})
			} else {
				return nil
			}
		} else {
			return Decimal(string)!
		}
	}
	
	/// Changes the minus simbol into a different one
	/// This is done to differentiate between negative and subtract
	static func changeMinusIntoOther(change: String , into string: String) -> String {
		var newString = ""
		for char in string {
			if String(char) == change && !newString.endsWithNum() {
				newString += "~"
			} else {
				newString += String(char)
			}
		}
		return newString
	}
}

extension String {
	func endsWithNum() -> Bool {
		let val = self.trimmingCharacters(in: .whitespaces)
		if let lastVal = val.last {
			return Float(String(lastVal)) != nil
		} else {
			return false
		}
	}
}

extension Decimal: Expression {
	/// A Decimal evaluatees to itself
	public func evaluate() -> Decimal? {
		return self
	}
	
	init?(_ string: String) {
		if let _ = Decimal(string: string.replacingOccurrences(of: Operators.subOp, with: "-")) {
			self.init(string: string.replacingOccurrences(of: Operators.subOp, with: "-"))
		} else {
			self.init(string: string)
		}
	}
}
