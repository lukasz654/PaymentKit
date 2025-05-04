//  CardFormView_Previews.swift
//  PaymentKit
//
//  Created by lla.

import SwiftUI

struct CardFormView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CardFormViewModel(
            validateCardInfoUseCase: ValidateCardInfoUseCase(),
            processPaymentUseCase: ProcessPaymentUseCase(
                paymentProcessor: MockPaymentProcessor(),
                encryptor: SimulatedAESCardEncryptor()
            )
        )
        CardFormView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
