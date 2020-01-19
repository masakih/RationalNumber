//
//  RationalNumberParser.swift
//  RationalNumber
//
//  Created by Hori,Masaki on 2020/01/19.
//  Copyright © 2020 Hori,Masaki. All rights reserved.
//


struct RationalNumberParser {
    
    func parse(_ text: String) -> RationalNumber {
        
        if text.contains("+") {
            
            return text
                .components(separatedBy: "+")
                .map(parse)
                .reduce(RationalNumber.zero, +)
        }
        
        let nums = text
            .components(separatedBy: "/")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .compactMap(Int.init)
        
        switch nums.count {
        case 1: return .init(integer: nums[0])
        case 2: return .init(numerator: nums[0], denominator: nums[1])
        default: return .zero
        }
    }
}

extension RationalNumber: ExpressibleByStringLiteral {
    
    public init(string: String) {
        
        self = RationalNumberParser().parse(string)
    }
    
    public init(stringLiteral value: String) {
        
        self = RationalNumberParser().parse(value)
    }
}
