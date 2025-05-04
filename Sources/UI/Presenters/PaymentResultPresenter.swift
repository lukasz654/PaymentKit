//  PaymentResultPresenter.swift
//  PaymentKit
//
//  Created by lla.

import Foundation

public struct PaymentResultPresenter {
    public init() {}

    public func message(for result: PaymentResult) -> String {
        switch result {
        case .success:
            return "Payment completed successfully"
        case .failure:
            return "Payment failed"
        }
    }
}
