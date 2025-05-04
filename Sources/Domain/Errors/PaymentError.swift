//  PaymentError.swift
//  PaymentKit
//
//  Created by lla.

import Foundation

public enum PaymentError: Error, Equatable {
    case invalidCardNumber
    case invalidExpirationDate
    case expiredCard
    case invalidCVV
    case encryptionFailed
    case processingFailed
}
