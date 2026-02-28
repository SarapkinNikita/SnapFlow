import UIKit

class OAuth2TokenStorage {
    var token: String? {
        get {
            let defaults = UserDefaults.standard
            return defaults.string(forKey: "BearerToken")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "BearerToken")
        }
    }
}
