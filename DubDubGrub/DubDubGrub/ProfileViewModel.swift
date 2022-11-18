import CloudKit

final class ProfileViewModel: ObservableObject {
    @Published var firstname    = ""
    @Published var lastname     = ""
    @Published var companyname  = ""
    @Published var bio          = ""
    @Published var avatar       = PlaceholderImage.avatar
    @Published var isShownig    = false
    @Published var alertItem: AlertItem?
    
    var remain: Int {
        100 - bio.count
    }
    
    var isValidProfile: Bool {
        guard !firstname.isEmpty,
              !lastname.isEmpty,
              !companyname.isEmpty,
              !bio.isEmpty,
              avatar != PlaceholderImage.avatar,
              bio.count < 101 else { return false}
        return true
    }
    
    func createProfile() {
        guard isValidProfile else {
            alertItem = AlertContext.invalidProfile
            return }
        
        let profileRecord = createProfileRecord()
        
        guard let userRecord = CloudKitManager.shared.userRecord else { return }
        
        userRecord["userProfile"] = CKRecord.Reference(record: profileRecord, action: .none)
        
        CloudKitManager.shared.batchSave(records: [userRecord, profileRecord]) { result in
            switch result {
                
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
    }
    
    
    func getProfile() {
        
        guard let userRecord = CloudKitManager.shared.userRecord else { return }
        
        guard let profileReference = userRecord["userProfile"] as? CKRecord.Reference else {
            return
        }
        let profileRecordID = profileReference.recordID
        
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let record):
                    let profile = DDGProfile(record: record)
                    self.firstname = profile.fistName
                    self.lastname = profile.lastName
                    self.companyname = profile.companyName
                    self.bio = profile.bio
                    self.avatar = profile.avatar.convertToUIImage(in: .square)
                case .failure(_):
                    break
                }
            }
        }
    }
    
    private func createProfileRecord() -> CKRecord {
        let profileRecord = CKRecord(recordType: RecordType.profile)
        profileRecord[DDGProfile.kFirstName] = firstname
        profileRecord[DDGProfile.kLastName] = lastname
        profileRecord[DDGProfile.kCompanyName] = companyname
        profileRecord[DDGProfile.kBio] = bio
        profileRecord[DDGProfile.kAvatar] = avatar.convertToCKAsset()
        return profileRecord
    }
}
