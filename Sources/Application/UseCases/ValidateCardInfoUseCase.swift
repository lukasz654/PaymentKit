//  ValidateCardInfoUseCase.swift
//  PaymentKit
//
//  Created by lla.

import Foundation

public struct ValidateCardInfoUseCase {
    public init() {}

    public func execute(cardNumber: String, expirationMonth: Int, expirationYear: Int, cvv: String) -> Result<Card, PaymentError> {
        do {
            let number = try CardNumber(cardNumber)
            let date = try ExpirationDate(month: expirationMonth, year: expirationYear)
            let code = try CVV(cvv)
            let card = Card(number: number, expirationDate: date, cvv: code)
            return .success(card)
        } catch let error as PaymentError {
            return .failure(error)
        } catch {
            return .failure(.processingFailed)
        }
    }
}
