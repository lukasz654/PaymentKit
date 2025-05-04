//  CardFormViewModel.swift
//  PaymentKit
//
//  Created by lla.

import Foundation
import Combine

@MainActor
public final class CardFormViewModel: ObservableObject {
    @Published public var cardNumber: String = ""
    @Published public var expirationMonth: String = ""
    @Published public var expirationYear: String = ""
    @Published public var cvv: String = ""

    @Published public var isFormValid: Bool = false
    @Published public var isProcessing: Bool = false
    @Published public var result: PaymentResult?
    @Published public var amount: Decimal
    @Published public var isResultVisible: Bool = false

    public let presenter = PaymentResultPresenter()

    private let validateCardInfoUseCase: ValidateCardInfoUseCase
    private let processPaymentUseCase: ProcessPaymentUseCase
    private let amountGenerator: () -> Decimal

    private var cancellables = Set<AnyCancellable>()

    public init(
        validateCardInfoUseCase: ValidateCardInfoUseCase,
        processPaymentUseCase: ProcessPaymentUseCase,
        amountGenerator: @escaping () -> Decimal = { Decimal(Double.random(in: 10...100).rounded()) }
    ) {
        self.validateCardInfoUseCase = validateCardInfoUseCase
        self.processPaymentUseCase = processPaymentUseCase
        self.amountGenerator = amountGenerator
        self.amount = amountGenerator()

        setupValidation()
    }

    private func setupValidation() {
        Publishers.CombineLatest4($cardNumber, $expirationMonth, $expirationYear, $cvv)
            .map { [weak self] number, monthStr, yearStr, cvv in
                guard let self, let month = Int(monthStr), let year = Int(yearStr) else { return false }
                let result = self.validateCardInfoUseCase.execute(
                    cardNumber: number,
                    expirationMonth: month,
                    expirationYear: year,
                    cvv: cvv
                )
                if case .success = result {
                    return true
                }
                return false
            }
            .assign(to: &$isFormValid)
    }

    public func submitPayment() {
        guard let month = Int(expirationMonth), let year = Int(expirationYear) else {
            result = .failure(error: .invalidExpirationDate, date: Date())
            return
        }

        let validation = validateCardInfoUseCase.execute(
            cardNumber: cardNumber,
            expirationMonth: month,
            expirationYear: year,
            cvv: cvv
        )

        switch validation {
        case .failure(let error):
            result = .failure(error: error, date: Date())

        case .success(let card):
            isProcessing = true
            processPaymentUseCase.execute(amount: amount, card: card) { [weak self] result in
                guard let self = self else { return }
                self.result = result
                self.isProcessing = false
                self.isResultVisible = true
            }
        }
    }

    public func reset() {
        cardNumber = ""
        expirationMonth = ""
        expirationYear = ""
        cvv = ""
        result = nil
        isResultVisible = false
        amount = amountGenerator()
    }

    public func formatCardNumber(_ input: String) -> String {
        let digits = input.filter(\.isNumber)
        return stride(from: 0, to: digits.count, by: 4)
            .map { i in
                let start = digits.index(digits.startIndex, offsetBy: i)
                let end = digits.index(start, offsetBy: 4, limitedBy: digits.endIndex) ?? digits.endIndex
                return String(digits[start..<end])
            }
            .joined(separator: " ")
    }
}
