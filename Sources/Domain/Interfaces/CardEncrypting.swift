//  CardEncrypting.swift
//  PaymentKit
//
//  Created by lla.

import Foundation

public protocol CardEncrypting {
    func encrypt(card: Card) throws -> String
}
