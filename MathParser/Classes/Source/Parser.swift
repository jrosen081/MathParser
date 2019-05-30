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
		var updatedString = Parser.changeMinusIntoOther(change: Operators.subOp, into: string)
		guard updatedString.contains(Operators.divOp) || updatedString.contains(Operators.multOp) || updatedString.contains(Operators.addOp) || updatedString.contains(Operators.subOp) ||  updatedString.contains(Operators.powOp) || updatedString.contains("(") || Decimal(string) != nil else {
			return nil
		}
		// Handles anything with parenthesis.
		// Since that needs to be parsed first, it gets the value and inputs it into the string.
		if updatedString.contains("(") {
			let idx = updatedString.firstIndex(of: "(")!
			var parenCounts = 0
			var nextIdx = updatedString.index(after: idx)
			while nextIdx != updatedString.endIndex {
				if updatedString[nextIdx] == ")"  {
					parenCounts -= 1
				} else if updatedString[nextIdx] == "(" {
					parenCounts += 1
				}
				if parenCounts == -1 {
					// Allows multiplication without the mult sign
					var myIdx = updatedString.index(after: nextIdx)
					while (myIdx != updatedString.endIndex && updatedString.index(after: myIdx) != updatedString.endIndex && updatedString[myIdx] == " ") {
						myIdx = updatedString.index(after: myIdx)
					}
					// If the next thing is an open parenthesis, we should multiply
					if myIdx != updatedString.endIndex && updatedString[myIdx] == "(" {
						updatedString.insert(Character(Operators.multOp), at: myIdx)
					}
					updatedString.replaceSubrange(idx..<nextIdx, with: "\(decimal: Parser.parse(string: String(updatedString[updatedString.index(after: idx)..<nextIdx]))?.evaluate())")
					return Parser.parse(string: updatedString)
				}
				nextIdx = updatedString.index(after: nextIdx)
			}
			return nil
		} else if updatedString.contains(Operators.addOp) || updatedString.contains(Operators.subOp) {
			// Deals with Adding and Subtracting
			// Splits the values by addition and subtracting and evaluates those last
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
			// Deals with Multiplication and Division
			// Splits the values by multiplication and division and evaluates those last
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
			// Deals with Power
			let split = updatedString.split(separator: Operators.powOp.first!).lazy.map(String.init).map({$0.trimmingCharacters(in: .whitespaces)})
			if let first = split.last, let firstExpr = Parser.parse(string: first.replacingOccurrences(of: "~", with: Operators.subOp)) {
				// This gets reversed due to the fact that power is right associative.
				return split.dropLast().reversed().reduce(firstExpr, {(result: Expression?, next: String) in
					if let val = result, let nextVal = Parser.parse(string: next.replacingOccurrences(of: "~", with: Operators.subOp)) {
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
	/// Does the String end with a number?
	/// - returns: Whether or not the String ends with a valid number value
	func endsWithNum() -> Bool {
		let val = self.trimmingCharacters(in: .whitespaces)
		if let lastVal = val.last {
			return Float(String(lastVal)) != nil || String(lastVal) == ")" || !Operators.allOperators.contains(String(lastVal))
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
	
	/// Initializes the decimal with a string input (hopefully)
	init?(_ string: String) {
		if let _ = Decimal(string: string.replacingOccurrences(of: Operators.subOp, with: "-")) {
			self.init(string: string.replacingOccurrences(of: Operators.subOp, with: "-"))
		} else {
			self.init(string: string)
		}
	}
}

extension String.StringInterpolation {
	/// Appends a possible decimal value.
	/// If the value is nil, it prints "nil"
	/// - Parameter decimal: The number to append
	mutating func appendInterpolation(decimal: Decimal?) {
		if let d = decimal {
			self.appendInterpolation(d)
		} else {
			self.appendInterpolation("nil")
		}
	}
}
