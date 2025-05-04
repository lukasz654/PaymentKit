//  CardNumber.swift
//  PaymentKit
//
//  Created by lla.

import Foundation

public struct CardNumber: Equatable {
    public let value: String

    public init(_ value: String) throws {
        let sanitized = value.replacingOccurrences(of: " ", with: "")
        guard sanitized.count >= 13 && sanitized.count <= 19, sanitized.allSatisfy(\.isNumber) else {
            throw PaymentError.invalidCardNumber
        }
        self.value = sanitized
    }
}
