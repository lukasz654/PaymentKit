//  CVV.swift
//  PaymentKit
//
//  Created by lla.

import Foundation

public struct CVV: Equatable {
    public let value: String

    public init(_ value: String) throws {
        guard value.count >= 3 && value.count <= 4, value.allSatisfy(\.isNumber) else {
            throw PaymentError.invalidCVV
        }
        self.value = value
    }
}
