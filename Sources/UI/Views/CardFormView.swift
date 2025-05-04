//  CardFormView.swift
//  PaymentKit
//
//  Created by lla.

import SwiftUI

public struct CardFormView: View {
    @ObservedObject var viewModel: CardFormViewModel

    public init(viewModel: CardFormViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack(spacing: 16) {
            Text("Amount: $\(NSDecimalNumber(decimal: viewModel.amount).doubleValue, specifier: "%.2f")")
                .font(.headline)
                .accessibilityLabel("Amount to pay")

            TextField("Card number", text: $viewModel.cardNumber)
                .keyboardType(.numberPad)
                .textContentType(.creditCardNumber)
                .accessibilityLabel("Card number")
                .onChange(of: viewModel.cardNumber) { _, newValue in
                        let formatted = viewModel.formatCardNumber(newValue)
                        if formatted != newValue {
                            viewModel.cardNumber = formatted
                        }
                    }

            HStack {
                TextField("MM", text: $viewModel.expirationMonth)
                    .keyboardType(.numberPad)
                    .accessibilityLabel("Expiration month")
                TextField("YY", text: $viewModel.expirationYear)
                    .keyboardType(.numberPad)
                    .accessibilityLabel("Expiration year")
            }

            SecureField("CVV", text: $viewModel.cvv)
                .keyboardType(.numberPad)
                .accessibilityLabel("CVV code")

            if viewModel.isProcessing {
                ProgressView()
            } else {
                Button("Pay") {
                    viewModel.submitPayment()
                }
                .disabled(!viewModel.isFormValid)
                .accessibilityLabel("Pay button")
            }
        }
        .padding()
        .sheet(isPresented: $viewModel.isResultVisible) {
            if let result = viewModel.result {
                PaymentResultView(result: result) {
                    viewModel.reset()
                }
            }
        }
        .textFieldStyle(.roundedBorder)
    }
}
