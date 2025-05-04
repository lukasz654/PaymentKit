//  Payment.swift
//  PaymentKit
//
//  Created by lla.

import Foundation

public struct Payment: Equatable {
    public let id: UUID
    public let amount: Decimal
    public let card: Card
    public let date: Date

    public init(id: UUID = UUID(), amount: Decimal, card: Card, date: Date = Date()) {
        self.id = id
        self.amount = amount
        self.card = card
        self.date = date
    }
}
