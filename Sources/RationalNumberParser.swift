//
//  RationalNumberParser.swift
//  RationalNumber
//
//  Created by Hori,Masaki on 2020/01/19.
//  Copyright © 2020 Hori,Masaki. All rights reserved.
//

import Foundation

struct RationalNumberParser {
    
    struct ParseError: Error {}
    
    func parse(_ text: String) throws -> RationalNumber {
        
        if text.contains("+") {
            
            return try text
                .components(separatedBy: "+")
                .map(parse)
                .reduce(RationalNumber.zero, +)
        }
        
        if text.hasPrefix("/") || text.hasSuffix("/") {
            
            throw ParseError()
        }
        
        let components = text
            .components(separatedBy: "/")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .map(Int.init)
        let nums = components.compactMap { $0 }
        
        guard components.count == nums.count else {
            
            throw ParseError()
        }
        
        switch nums.count {
        case 1: return .init(integer: nums[0])
        case 2: return .init(numerator: nums[0], denominator: nums[1])
        default: return makeRationalNumer(array: nums)
        }
    }
    
    private func makeRationalNumer(array: [Int]) -> RationalNumber {
        
        precondition(array.count >= 3)
        
        func f(_ base: RationalNumber, _ xs: ArraySlice<Int>) -> RationalNumber {
            
            var xs = xs
            guard let x = xs.popFirst() else { return base }
            
            return f(base / RationalNumber(integer: x), xs)
        }
        
        return f(RationalNumber(numerator: array[0], denominator: array[1]), array[2...])
    }
}

extension RationalNumber: ExpressibleByStringLiteral {
    
    public init?(text: String) {
        
        do {
            self = try RationalNumberParser().parse(text)
        }
        catch {
            return nil
        }
    }
    
    public init(stringLiteral value: String) {
        
        guard let value = RationalNumber(text: value) else {
            
            fatalError("parse error.")
        }
        
        self = value
    }
}
