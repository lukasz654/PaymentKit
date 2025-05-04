//  ProcessPaymentUseCaseTests.swift
//  PaymentKit
//
//  Created by lla.

import XCTest
@testable import PaymentKit

final class ProcessPaymentUseCaseTests: XCTestCase {
    func testSuccessfulPaymentReturnsSuccess() {
        let useCase = ProcessPaymentUseCase(
            paymentProcessor: AlwaysSucceedingPaymentProcessor(),
            encryptor: DummyEncryptor()
        )

        let card = try! Card(
            number: CardNumber("4111 1111 1111 1111"),
            expirationDate: try! ExpirationDate(month: 12, year: 99),
            cvv: try! CVV("123")
        )

        let exp = expectation(description: "Payment completed")

        useCase.execute(amount: 50, card: card) { result in
            switch result {
            case .success(let id, let amount, _):
                XCTAssertEqual(amount, 50)
                XCTAssertNotNil(id)
            case .failure:
                XCTFail("Expected success")
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 3.0)
    }

    func testFailedPaymentReturnsFailure() {
        let useCase = ProcessPaymentUseCase(
            paymentProcessor: AlwaysFailingPaymentProcessor(),
            encryptor: DummyEncryptor()
        )

        let card = try! Card(
            number: CardNumber("4111 1111 1111 1111"),
            expirationDate: try! ExpirationDate(month: 12, year: 99),
            cvv: try! CVV("123")
        )

        let exp = expectation(description: "Payment failed")

        useCase.execute(amount: 50, card: card) { result in
            switch result {
            case .failure(let error, _):
                XCTAssertEqual(error, .processingFailed)
            case .success:
                XCTFail("Expected failure")
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 3.0)
    }
}
