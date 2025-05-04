//  PaymentResult.swift
//  PaymentKit
//
//  Created by lla.

import Foundation

public enum PaymentResult: Equatable {
    case success(id: UUID, amount: Decimal, date: Date)
    case failure(error: PaymentError, date: Date)

    public var isSuccess: Bool {
        if case .success = self { return true }
        return false
    }
}
