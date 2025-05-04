//  PaymentResultView.swift
//  PaymentKit
//
//  Created by lla.

import SwiftUI

public struct PaymentResultView: View {
    let result: PaymentResult
    let onTryAgain: () -> Void
    let presenter = PaymentResultPresenter()

    public var body: some View {
        VStack(spacing: 24) {
            if result.isSuccess {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.system(size: 64))
            } else {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
                    .font(.system(size: 64))
            }

            Text(presenter.message(for: result))
                .font(.title2)
                .multilineTextAlignment(.center)

            Button("Try again", action: onTryAgain)
                .padding()
                .background(Color.primary.opacity(0.1))
                .cornerRadius(10)
        }
        .padding()
    }
}
