# PaymentKit

PaymentKit is a lightweight Swift library that provides a card payment form. It includes built-in validation, result handling, and a SwiftUI-based UI that can be embedded into UIKit apps.

---

## Requirements

- iOS 18.0+
- macOS 15.0+
- Swift 6
- Xcode 16+

---

## Installation

### Using Swift Package Manager (SPM)

1. In Xcode, open your project.
2. Go to **File > Add Packages…**
3. Enter the URL of this repository:
   ```
   https://github.com/lukasz654/PaymentKit.git
   ```
4. Add to your app target.

---

## Integration

### 1. Import the framework

```swift
import PaymentKit
```

---

### 2. Create and embed the payment form

In a UIKit-based app (e.g. in `SceneDelegate.swift`):

```swift
let viewModel = CardFormViewModel(
    validateCardInfoUseCase: ValidateCardInfoUseCase(),
    processPaymentUseCase: ProcessPaymentUseCase(
        paymentProcessor: MockPaymentProcessor(simulateSuccess: true),
        encryptor: SimulatedAESCardEncryptor()
    )
)

let paymentVC = PaymentFormViewController(viewModel: viewModel)
window.rootViewController = UINavigationController(rootViewController: paymentVC)
```

---

## Features

- Built with SwiftUI
- Works with UIKit apps via `UIHostingController`
- Card number formatting
- Input validation (card number, expiration, CVV)
- Simulated async payment handling (2-second delay)
- Simulated AES encryption
- Success/failure result handling
- Light and dark mode support
- Accessible with VoiceOver and Dynamic Type
- Includes unit and UI test


