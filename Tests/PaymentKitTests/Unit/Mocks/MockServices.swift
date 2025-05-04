
//  MockServices.swift
//  PaymentKit
//
//  Created by lla.

import Foundation
@testable import PaymentKit

final class AlwaysFailingPaymentProcessor: PaymentProcessing {
    func process(payment: Payment, completion: @escaping (Result<Void, PaymentError>) -> Void) {
        completion(.failure(.processingFailed))
    }
}

final class AlwaysSucceedingPaymentProcessor: PaymentProcessing {
    func process(payment: Payment, completion: @escaping (Result<Void, PaymentError>) -> Void) {
        completion(.success(()))
    }
}

final class DummyEncryptor: CardEncrypting {
    func encrypt(card: Card) throws -> String {
        return "encrypted"
    }
}
