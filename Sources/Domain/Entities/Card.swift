//  Card.swift
//  PaymentKit
//
//  Created by lla.

import Foundation

public struct Card: Equatable {
    public let number: CardNumber
    public let expirationDate: ExpirationDate
    public let cvv: CVV

    public init(number: CardNumber, expirationDate: ExpirationDate, cvv: CVV) {
        self.number = number
        self.expirationDate = expirationDate
        self.cvv = cvv
    }
}
