import XCTest
@testable import MathParser

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
		Operators.addOp = "+"
		Operators.divOp = "/"
		Operators.subOp = "-"
		Operators.multOp = "*"
		Operators.powOp = "^"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
		let val = Parser.parse(string: "1 + 2")
		XCTAssertNotNil(val)
		XCTAssertEqual(val?.evaluate(), 3)
		XCTAssertEqual(Parser.parse(string: "2 ^ 3")?.evaluate(), 8)
		XCTAssertEqual(Parser.parse(string: "12 ^ 2")?.evaluate(), 144)
		XCTAssertEqual(Parser.parse(string: "1 / 2")?.evaluate(), 0.5)
		XCTAssertNil(Parser.parse(string: "1 + k"))
		XCTAssertEqual(Parser.parse(string: "10 * 3 ^ 2")?.evaluate(), 90)
		XCTAssertEqual(Parser.parse(string: "12 + 4 * 3")?.evaluate(), 24)
    }
    
}
