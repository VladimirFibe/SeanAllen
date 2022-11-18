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
              bio.count < 100 else { return false}
        return true
    }
    
    func createProfile() {
        guard isValidProfile else {
            alertItem = AlertContext.invalidProfile
            return }
        
        let profileRecord = CKRecord(recordType: RecordType.profile)
        profileRecord[DDGProfile.kFirstName] = firstname
        profileRecord[DDGProfile.kLastName] = lastname
        profileRecord[DDGProfile.kCompanyName] = companyname
        profileRecord[DDGProfile.kBio] = bio
        profileRecord[DDGProfile.kAvatar] = avatar.convertToCKAsset()
        
        CKContainer.default().fetchUserRecordID { recordID, error in
            guard let recordID = recordID, error == nil else { return }
            
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { userRecord, error in
                guard let userRecord = userRecord, error == nil else { return }
                
                userRecord["userProfile"] = CKRecord.Reference(record: profileRecord, action: .none)
                
                let opertaton = CKModifyRecordsOperation(recordsToSave: [userRecord, profileRecord])
                
                opertaton.modifyRecordsCompletionBlock = { savedRecords, _, error in
                    guard let savedRecords = savedRecords, error == nil else { return }
                    print(savedRecords)
                }
                CKContainer.default().publicCloudDatabase.add(opertaton)
            }
        }
    }
    
    func getProfile() {
        CKContainer.default().fetchUserRecordID { recordID, error in
            guard let recordID, error == nil else { return }
            
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { userRecord, error in
                guard let userRecord, error == nil else { return }
                
                let profileReference = userRecord["userProfile"] as! CKRecord.Reference
                let prifileRecordID = profileReference.recordID
                
                CKContainer.default().publicCloudDatabase.fetch(withRecordID: prifileRecordID) { profileRecord, error in
                    guard let profileRecord, error == nil else { return }
                    
                    DispatchQueue.main.async {
                        let profile = DDGProfile(record: profileRecord)
                        self.firstname = profile.fistName
                        self.lastname = profile.lastName
                        self.companyname = profile.companyName
                        self.bio = profile.bio
                        self.avatar = profile.avatar.convertToUIImage(in: .square)
                    }
                }
            }
        }
    }
}
