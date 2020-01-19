//
//  RationalNumberTests.swift
//  RationalNumberTests
//
//  Created by Hori,Masaki on 2020/01/19.
//  Copyright © 2020 Hori,Masaki. All rights reserved.
//

import XCTest
@testable import RationalNumber

class RationalNumberTests: XCTestCase {
    
    func testInitialize() {
        
        let a = RationalNumber(numerator: 2, denominator: 16)
        XCTAssertEqual(a.numerator, 1)
        XCTAssertEqual(a.denominator, 8)
        
        let b = RationalNumber(numerator: -1, denominator: 16)
        XCTAssertEqual(b.numerator, -1)
        XCTAssertEqual(b.denominator, 16)
        
        let c = RationalNumber(numerator: 1, denominator: -16)
        XCTAssertEqual(c.numerator, -1)
        XCTAssertEqual(c.denominator, 16)
        
        let d = RationalNumber(integer: 10)
        XCTAssertEqual(d.numerator, 10)
        XCTAssertEqual(d.denominator, 1)
        
        let k = RationalNumber(exactly: 10)
        XCTAssertEqual(k, RationalNumber(integer: 10))
        
    }
    
    func testDouble() {
        
        let a = RationalNumber(numerator: 1, denominator: 2)
        XCTAssertEqual(a.double, 0.5)
    }

    func testAdditiveArithmetic() {
        
        let a = RationalNumber(numerator: 1, denominator: 16)
        let b = RationalNumber(numerator: 5, denominator: 16)
        
        XCTAssertEqual(a + b, RationalNumber(numerator: 3, denominator: 8))
        
        XCTAssertEqual(a - b, RationalNumber(numerator: -1, denominator: 4))
        
        XCTAssertEqual(b - a, RationalNumber(numerator: 1, denominator: 4))
        
        XCTAssertEqual(a - a, RationalNumber.zero)
        
        XCTAssertEqual(-a, RationalNumber(numerator: -1, denominator: 16))
        
        let d = RationalNumber(numerator: 1, denominator: 3)
        XCTAssertEqual(a + d, RationalNumber(numerator: 19, denominator: 48))
        
        
        var c = a
        c += b
        XCTAssertEqual(c, RationalNumber(numerator: 3, denominator: 8))
        
        c -= b
        XCTAssertEqual(c, a)
        
        
        let f = RationalNumber(numerator: 256, denominator: 128)
        XCTAssertEqual(f, RationalNumber(integer: 2))
    }
    
    func testComparable() {
        
        XCTAssertTrue(RationalNumber(integer: 4) > RationalNumber(integer: 3))
        XCTAssertFalse(RationalNumber(integer: 3) > RationalNumber(integer: 4))
        
        XCTAssertTrue(RationalNumber(numerator: 1, denominator: 2) > RationalNumber(numerator: 1, denominator: 4))
        XCTAssertFalse(RationalNumber(numerator: 1, denominator: 4) > RationalNumber(numerator: 1, denominator: 2))
    }
    
    func testNumeric() {
        
        let a = RationalNumber(numerator: 1, denominator: 3)
        let b = RationalNumber(numerator: 5, denominator: 6)
        
        XCTAssertEqual(a * b, RationalNumber(numerator: 5, denominator: 18))
        
        let d = RationalNumber(numerator: 1, denominator: 3)
        XCTAssertEqual(a * d, RationalNumber(numerator: 1, denominator: 9))
        
        
        var c = a
        c *= b
        XCTAssertEqual(c, RationalNumber(numerator: 5, denominator: 18))
        
        // Over flow test
        let g = RationalNumber(integer: Int.max - 7)  // = 9223372036854775800
        let h = RationalNumber(numerator: 3, denominator: 100)
        let i = g * h
        XCTAssertEqual(g, i / h)
        
        
        let j = RationalNumber(numerator: -3, denominator: 10)
        XCTAssertEqual(j.magnitude, RationalNumber(numerator: 3, denominator: 10))
    }
    
    func testField() {
        
        let a = RationalNumber(numerator: 1, denominator: 3)
        let b = RationalNumber(numerator: 5, denominator: 6)
        
        XCTAssertEqual(a / b, RationalNumber(numerator: 2, denominator: 5))
        
        var c = a
        c /= b
        XCTAssertEqual(c, RationalNumber(numerator: 2, denominator: 5))
    }
    
    func testPrettyString() {
        
        let a = RationalNumber(numerator: 1, denominator: 2)
        XCTAssertEqual(a.prettyDescription, "1/2")
        
        let b = RationalNumber(numerator: -1, denominator: 2)
        XCTAssertEqual(b.prettyDescription, "-1/2")
        
        let c = RationalNumber(numerator: 10, denominator: 5)
        XCTAssertEqual(c.prettyDescription, "2")
        
        let d = RationalNumber(numerator: 11, denominator: 5)
        XCTAssertEqual(d.prettyDescription, "2+1/5")
    }
}
