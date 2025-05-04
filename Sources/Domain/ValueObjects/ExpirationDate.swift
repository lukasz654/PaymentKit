//  ExpirationDate.swift
//  PaymentKit
//
//  Created by lla.

import Foundation

public struct ExpirationDate: Equatable {
    public let month: Int
    public let year: Int

    public init(month: Int, year: Int) throws {
        guard (1...12).contains(month) else {
            throw PaymentError.invalidExpirationDate
        }

        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date()) % 100
        let currentMonth = calendar.component(.month, from: Date())

        if year < currentYear || (year == currentYear && month < currentMonth) {
            throw PaymentError.expiredCard
        }

        self.month = month
        self.year = year
    }
}
