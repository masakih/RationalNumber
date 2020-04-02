//
//  RationalNumber.swift
//  RationalNumber
//
//  Created by Hori,Masaki on 2020/01/19.
//  Copyright © 2020 Hori,Masaki. All rights reserved.
//

func gcd(_ a: Int, _ b: Int) -> Int {
    
    if a.isMultiple(of: b) { return b }
    
    return gcd(b, a % b)
}

public struct RationalNumber {
    
    public var numerator: Int
    public var denominator: Int
    
    public init(numerator: Int, denominator: Int) {
        
        precondition(denominator != 0, "Error: Divid Zero")
        
        let _gcd = gcd(numerator, denominator)
        
        self.numerator = numerator / _gcd
        self.denominator = denominator / _gcd
        
        if self.denominator < 0 {
            
            self.numerator *= -1
            self.denominator *= -1
        }
    }
    
    public init(integer value: Int) {
        
        self = RationalNumber(numerator: value, denominator: 1)
    }
    
    public var double: Double {
        
        Double(numerator) / Double(denominator)
    }
}

extension RationalNumber: AdditiveArithmetic {
    
    public static var zero: RationalNumber {
        
        .init(integer: 0)
    }
    
    public static func + (lhs: RationalNumber, rhs: RationalNumber) -> RationalNumber {
        
        lhs.appended(rhs)
    }
    
    public static func += (lhs: inout RationalNumber, rhs: RationalNumber) {
        
        lhs = lhs + rhs
    }
    
    public static func - (lhs: RationalNumber, rhs: RationalNumber) -> RationalNumber {
        
        lhs + rhs.inverse
    }
    
    public static func -= (lhs: inout RationalNumber, rhs: RationalNumber) {
        
        lhs = lhs - rhs
    }
    
    var inverse: RationalNumber {
        
        .init(numerator: numerator * -1, denominator: denominator)
    }
    
    func appended(_ other: RationalNumber) -> RationalNumber {
        
        // 桁あふれは無視
        
        let l_numerator = self.numerator * other.denominator
        let r_numerator = other.numerator * self.denominator
        
        return RationalNumber(numerator: l_numerator + r_numerator,
                              denominator: self.denominator * other.denominator)
    }
}

extension RationalNumber: Comparable {
    
    public static func < (lhs: RationalNumber, rhs: RationalNumber) -> Bool {
        
        let d = lhs - rhs
        
        return d.numerator < 0
    }
}

extension RationalNumber: SignedNumeric {
            
    public init?<T>(exactly source: T) where T : BinaryInteger {
        
        guard let i = Int(exactly: source) else { return nil }
        
        numerator = i
        denominator = 1
    }
    
    public var magnitude: RationalNumber {
        
        .init(numerator: abs(numerator), denominator: denominator)
    }
    
    public static func * (lhs: RationalNumber, rhs: RationalNumber) -> RationalNumber {
        
        let s1 = gcd(lhs.numerator, rhs.denominator)
        let s2 = gcd(lhs.denominator, rhs.numerator)
        
        let sl1 = lhs.numerator / s1
        let sl2 = lhs.denominator / s2
        let sr1 = rhs.numerator / s2
        let sr2 = rhs.denominator / s1
        
        return RationalNumber(numerator: sl1 * sr1, denominator: sl2 * sr2)
    }
    
    public static func *= (lhs: inout RationalNumber, rhs: RationalNumber) {
        
        lhs = lhs * rhs
    }
    
    public init(integerLiteral value: Int) {
        
        numerator = value
        denominator = 1
    }
}

extension RationalNumber {
    
    public static func / (lhs: RationalNumber, rhs: RationalNumber) -> RationalNumber {
        
        lhs * rhs.reciprocal
    }
    
    public static func /= (lhs: inout RationalNumber, rhs: RationalNumber) {
        
        lhs = lhs / rhs
    }
    
    var reciprocal: RationalNumber {
        
        .init(numerator: denominator, denominator: numerator)
    }
}

extension RationalNumber {
    
    public var prettyDescription: String {
        
        if denominator == 1 { return String(numerator) }
        
        let k = numerator / denominator
        let n = numerator - k * denominator
        return k != 0 ? "\(k)+\(n)/\(denominator)" : "\(numerator)/\(denominator)"
    }
}
