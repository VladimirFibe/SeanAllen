import SwiftUI

final class ProfileViewModel: ObservableObject {
    @AppStorage("user") private var userData: Data?
    @Published var user = User()
    
    @Published var alertItem: AlertItem?
    
    init() {
        retrieveUser()
    }
    var isValidForm: Bool {
        guard !user.firstname.isEmpty && !user.lastname.isEmpty && !user.email.isEmpty else {
            alertItem = AlertContext.invalidForm
            return false
        }
        guard user.email.isValidEmail else {
            alertItem = AlertContext.invalidEmail
            return false
        }
        return true
    }
    
    func saveChanges() {
        guard isValidForm else { return }
        do {
            let data = try JSONEncoder().encode(user)
            userData = data
            alertItem = AlertContext.userSaveSuccess
        } catch {
            alertItem = AlertContext.invalidUserData
        }
    }
    
    func retrieveUser() {
        guard let userData = userData else { return }
        do {
            user = try JSONDecoder().decode(User.self, from: userData)
        } catch {
            alertItem = AlertContext.invalidUserData
        }
    }
}
