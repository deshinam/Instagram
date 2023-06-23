import LocalAuthentication
import UIKit

class UserAuthentication {
    func authenticateTapped() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        print("Success")
                        // perform action
                    } else {
                        print(error ?? "")
                    }
                }
            }
        } else {
            print("Biometry unavailable")
        }
    }
}
