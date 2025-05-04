//  PaymentProcessing.swift
//  PaymentKit
//
//  Created by lla.

import Foundation

public protocol PaymentProcessing {
    func process(payment: Payment, completion: @escaping (Result<Void, PaymentError>) -> Void)
}
