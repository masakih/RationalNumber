//
//  RationalNumberParserTests.swift
//  RationalNumberTests
//
//  Created by Hori,Masaki on 2020/01/19.
//  Copyright © 2020 Hori,Masaki. All rights reserved.
//

import XCTest
@testable import RationalNumber

class RationalNumberParserTests: XCTestCase {

    var parser = RationalNumberParser()
    

    func testParse() {
        
        XCTAssertEqual(try? parser.parse("1/16"), RationalNumber(numerator: 1, denominator: 16))
        
        XCTAssertEqual(try? parser.parse(" 1"), RationalNumber(numerator: 1, denominator: 1))
        
        XCTAssertEqual(try? parser.parse("1+1/4"), RationalNumber(numerator: 5, denominator: 4))
        
        XCTAssertEqual(try? parser.parse("1 +1/4"), RationalNumber(numerator: 5, denominator: 4))
        
        XCTAssertEqual(try? parser.parse("1 +1/4+2/4"), RationalNumber(numerator: 7, denominator: 4))
        
        XCTAssertThrowsError(try parser.parse("/"))
        XCTAssertThrowsError(try parser.parse("1/"))
        XCTAssertThrowsError(try parser.parse("/1"))
        
        
        XCTAssertEqual(try parser.parse("2 / 2 / 5"), RationalNumber(numerator: 1, denominator: 5))
    }
    
    func testExpressibleByStringLiteral() {
        
        let a: RationalNumber = "1/1"
        XCTAssertEqual(a, RationalNumber(integer: 1))
        
        XCTAssertTrue(a == "1/1")
    }

}
