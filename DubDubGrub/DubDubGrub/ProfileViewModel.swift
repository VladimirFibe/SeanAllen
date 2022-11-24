import CloudKit

enum ProfileContext { case create, update }

final class ProfileViewModel: ObservableObject {
    @Published var firstname    = ""
    @Published var lastname     = ""
    @Published var companyname  = ""
    @Published var bio          = ""
    @Published var avatar       = PlaceholderImage.avatar
    @Published var isShownig    = false
    @Published var isLoading    = false
    @Published var isCheckedIn  = false
    @Published var alertItem: AlertItem?
    
    private var existingRecord: CKRecord? {
        didSet { profileContext = .update}
    }
    var profileContext = ProfileContext.create
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
    
    func getCheckedInStatus() {
        guard let profileRecordId = CloudKitManager.shared.profileRecordID else { return }
        
        CloudKitManager.shared.fetchRecord(with: profileRecordId) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case.success(let record):
                    if let _ = record[DDGProfile.kIsCheckedIn] as? CKRecord.Reference {
                        isCheckedIn = true
                    } else {
                        isCheckedIn = false
                    }
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func checkOut() {
        guard let profileID = CloudKitManager.shared.profileRecordID else {
            alertItem = AlertContext.unableToGetProfile
            return }
        CloudKitManager.shared.fetchRecord(with: profileID) { result in
                switch result {
                case .success(let record):
                    record[DDGProfile.kIsCheckedIn] = nil
                    record[DDGProfile.kIsCheckedInNilCheck] = nil
                    CloudKitManager.shared.save(record: record) { result in
                        DispatchQueue.main.async { [self] in
                            switch result {
                            case .success(_):
                                isCheckedIn = false
                            case .failure(_):
                                alertItem = AlertContext.unableToCheckInOrOut
                            }
                        }
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self.alertItem = AlertContext.unableToCheckInOrOut
                    }
                }
        }
        
    }
    
    func createProfile() {
        guard isValidProfile else {
            alertItem = AlertContext.invalidProfile
            return
        }
        
        let profileRecord = createProfileRecord()
        
        guard let userRecord = CloudKitManager.shared.userRecord else {
            alertItem = AlertContext.noUserRecord
            return
        }
        
        userRecord["userProfile"] = CKRecord.Reference(record: profileRecord, action: .none)
        showLoadingView()
        CloudKitManager.shared.batchSave(records: [userRecord, profileRecord]) { result in
            DispatchQueue.main.async { [self] in
                hideLoadingView()
                
                switch result {
                case .success(let records):
                    for record in records where record.recordType == RecordType.profile {
                        existingRecord = record
                        CloudKitManager.shared.profileRecordID = record.recordID
                    }
                    alertItem = AlertContext.createProfileSuccess
                case .failure(_):
                    alertItem = AlertContext.createProfileFailure
                }
            }
        }
    }
    
    func getProfile() {
        
        guard let userRecord = CloudKitManager.shared.userRecord else {
            alertItem = AlertContext.noUserRecord
            return
        }
        
        guard let profileReference = userRecord["userProfile"] as? CKRecord.Reference else { return }
        let profileRecordID = profileReference.recordID
        showLoadingView()
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { result in
            DispatchQueue.main.async { [self] in
                hideLoadingView()
                getCheckedInStatus()
                switch result {
                case .success(let record):
                    existingRecord = record
                    
                    let profile = DDGProfile(record: record)
                    firstname = profile.fistName
                    lastname = profile.lastName
                    companyname = profile.companyName
                    bio = profile.bio
                    avatar = profile.avatar.convertToUIImage(in: .square)
                case .failure(_):
                    alertItem = AlertContext.unableToGetProfile
                }
            }
        }
    }
    
    func updateProfile() {
        guard isValidProfile else {
            alertItem = AlertContext.invalidProfile
            return
        }
        
        guard let profileRecord = existingRecord else {
            alertItem = AlertContext.unableToGetProfile
            return
        }
        
        profileRecord[DDGProfile.kFirstName] = firstname
        profileRecord[DDGProfile.kLastName] = lastname
        profileRecord[DDGProfile.kCompanyName] = companyname
        profileRecord[DDGProfile.kBio] = bio
        profileRecord[DDGProfile.kAvatar] = avatar.convertToCKAsset()
        
        showLoadingView()
        CloudKitManager.shared.save(record: profileRecord) { result in
            DispatchQueue.main.async { [self] in
                hideLoadingView()
                
                switch result {
                case .success(_):
                    alertItem = AlertContext.updateProfileSuccess
                case .failure(_):
                    alertItem = AlertContext.updateProfileFailure
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
    func saveButtonAction() { profileContext == .create ? createProfile() : updateProfile() }
    private func showLoadingView() { isLoading = true }
    private func hideLoadingView() { isLoading = false }
}
