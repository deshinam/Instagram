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
//            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .default))
//            self.present(ac, animated: true)
        }
    }
}
