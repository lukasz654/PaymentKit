//  ProcessPaymentUseCase.swift
//  PaymentKit
//
//  Created by lla.

import Foundation

public final class ProcessPaymentUseCase {
    private let paymentProcessor: PaymentProcessing
    private let encryptor: CardEncrypting

    public init(paymentProcessor: PaymentProcessing, encryptor: CardEncrypting) {
        self.paymentProcessor = paymentProcessor
        self.encryptor = encryptor
    }

    public func execute(amount: Decimal, card: Card, completion: @escaping (PaymentResult) -> Void) {
        do {
            _ = try encryptor.encrypt(card: card)

            let payment = Payment(amount: amount, card: card)

            paymentProcessor.process(payment: payment) { result in
                switch result {
                case .success:
                    let result = PaymentResult.success(id: payment.id, amount: payment.amount, date: payment.date)
                    completion(result)

                case .failure(let error):
                    let result = PaymentResult.failure(error: error, date: payment.date)
                    completion(result)
                }
            }
        } catch {
            let result = PaymentResult.failure(
                error: .encryptionFailed,
                date: Date()
            )
            completion(result)
        }
    }
}
