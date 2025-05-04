//  DelayExecutor.swift
//  PaymentKit
//
//  Created by lla.

import Foundation

public struct DelayExecutor {

    public init() {
        
    }

    public func execute(after seconds: TimeInterval, on queue: DispatchQueue = .main, _ block: @escaping () -> Void) {
        queue.asyncAfter(deadline: .now() + seconds, execute: block)
    }
}
