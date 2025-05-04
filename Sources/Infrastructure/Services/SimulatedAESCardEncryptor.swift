//  SimulatedAESCardEncryptor.swift
//  PaymentKit
//
//  Created by lla.

import Foundation

public final class SimulatedAESCardEncryptor: CardEncrypting {
    public init() {}

    public func encrypt(card: Card) throws -> String {
        let plain = """
        \(card.number.value)|\(card.expirationDate.month)/\(card.expirationDate.year)|\(card.cvv.value)
        """
        guard let encrypted = String(plain.reversed()).data(using: .utf8)?.base64EncodedString() else {
            throw PaymentError.encryptionFailed
        }
        return encrypted
    }
}
