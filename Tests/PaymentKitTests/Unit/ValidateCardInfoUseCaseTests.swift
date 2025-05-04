//  ValidateCardInfoUseCaseTests.swift
//  PaymentKit
//
//  Created by lla.

import XCTest
@testable import PaymentKit

final class ValidateCardInfoUseCaseTests: XCTestCase {
    func testValidCardReturnsSuccess() {
        let useCase = ValidateCardInfoUseCase()

        let result = useCase.execute(
            cardNumber: "4242 4242 4242 4242",
            expirationMonth: 12,
            expirationYear: 99,
            cvv: "123"
        )

        switch result {
        case .success(let card):
            XCTAssertEqual(card.cvv.value, "123")
        case .failure:
            XCTFail("Expected success")
        }
    }

    func testInvalidCardNumberFails() {
        let useCase = ValidateCardInfoUseCase()

        let result = useCase.execute(
            cardNumber: "abcd",
            expirationMonth: 12,
            expirationYear: 99,
            cvv: "123"
        )

        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .invalidCardNumber)
        case .success:
            XCTFail("Expected failure")
        }
    }
}
