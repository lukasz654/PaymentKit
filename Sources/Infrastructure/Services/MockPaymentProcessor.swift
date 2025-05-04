//  MockPaymentProcessor.swift
//  PaymentKit
//
//  Created by lla.

import Foundation

public final class MockPaymentProcessor: PaymentProcessing {
    private let delayExecutor: DelayExecutor
    private let simulateSuccessProvider: () -> Bool

    public init(delayExecutor: DelayExecutor = .init(), simulateSuccessProvider: @escaping () -> Bool = { true }) {
        self.delayExecutor = delayExecutor
        self.simulateSuccessProvider = simulateSuccessProvider
    }

    public func process(payment: Payment, completion: @escaping (Result<Void, PaymentError>) -> Void) {
        delayExecutor.execute(after: 2.0) {
            if self.simulateSuccessProvider() {
                completion(.success(()))
            } else {
                completion(.failure(.processingFailed))
            }
        }
    }
}
