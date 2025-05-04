# PaymentKit – Architecture Overview & Design Decisions

## Architecture

PaymentKit follows Clean Architecture and Domain-Driven Design principles. The codebase is structured into clear layers:

- **Domain Layer** – Defines core entities (`Card`, `Payment`), value objects (`CardNumber`, `ExpirationDate`, `CVV`), and interfaces (`CardEncrypting`, `PaymentProcessing`). It contains no dependencies on other layers.
- **Application Layer** – Contains use cases like `ValidateCardInfoUseCase` and `ProcessPaymentUseCase`, responsible for orchestrating business logic using domain interfaces.
- **Infrastructure Layer** – Provides mock implementations such as `MockPaymentProcessor`, `SimulatedAESCardEncryptor`, and `DelayExecutor` for simulating async payment processing.
- **UI Layer** – Built in SwiftUI, includes `CardFormView`, its view model (`CardFormViewModel`), UIKit bridge (`PaymentFormViewController`), and preview support.
- **Validation Layer** – Contains simple, reusable validators used outside of domain value objects, mainly in the view model.

## Design Decisions

- **MVVM + Clean Architecture**: Ensures separation of concerns, scalability, and testability.
- **Dependency Injection**: Used throughout to decouple components and support mocking in unit tests.
- **SwiftUI + UIKit Bridge**: The form is implemented in SwiftUI but can be embedded in UIKit apps via `UIHostingController`.
- **Automatic Amount Generation**: Each payment gets a randomly generated amount.
- **Simulated Encryption**: Card data is "encrypted" using a simple reversed string + Base64.
- **Mocked Payment Processor**: Simulates success or failure after a 2-second delay to mimic real payment scenarios.
- **Accessibility**: Labels and system fonts are used to support VoiceOver and Dynamic Type.
- **Tests**: Includes both unit tests and UI test covering the main flow.
