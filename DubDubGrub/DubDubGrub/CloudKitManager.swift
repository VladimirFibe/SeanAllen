import CloudKit

final class CloudKitManager {
    
    static let shared = CloudKitManager()
    private init(){}
    var userRecord: CKRecord?
    var profileRecordID: CKRecord.ID?
    
    func getUserRecord() {
        CKContainer.default().fetchUserRecordID { recordID, error in
            guard let recordID, error == nil else { return }
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { userRecord, error in
                guard let userRecord = userRecord, error == nil else { return }
                self.userRecord = userRecord
                if let profileReference = userRecord["userProfile"] as? CKRecord.Reference {
                    self.profileRecordID = profileReference.recordID
                }
            }
        }
    }
    
    func getLocations(completed: @escaping (Result<[DDGLocation], Error>) -> Void) {
        let sordDescriptor = NSSortDescriptor(key: DDGLocation.kNname, ascending: true)
        let query          = CKQuery(recordType: RecordType.location, predicate: NSPredicate(value: true))
        query.sortDescriptors = [sordDescriptor]
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                completed(.failure(error))
                return
            } else if let records = records {
                let locations: [DDGLocation] = records.map { $0.convertToDDGlocation()}
                completed(.success(locations))
            }
            
        }
    }
    
    func getCheckedInProfiles(for locationID: CKRecord.ID, completed: @escaping (Result<[DDGProfile], Error>) -> Void) {
        let reference = CKRecord.Reference(recordID: locationID, action: .none)
        let predicate = NSPredicate(format: "isCheckedIn == %@", reference)
        let query     = CKQuery(recordType: RecordType.profile, predicate: predicate)
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { records, error in
            guard let records = records, error == nil else {
                completed(.failure(error!))
                return
            }
            
            let profiles = records.map { $0.convertToDDGProfile() }
            completed(.success(profiles))
        }
    }
    
    func getCheckedInProfilesDictionary(completed: @escaping (Result<[CKRecord.ID: [DDGProfile]], Error>) -> Void) {
        let predicate = NSPredicate(format: "isCheckedInNilCheck == 1")
        let query = CKQuery(recordType: RecordType.profile, predicate: predicate)
        let operation = CKQueryOperation(query: query)
        var chekedInProfiles: [CKRecord.ID: [DDGProfile]] = [:]
        operation.recordFetchedBlock = { record in
            let profile = DDGProfile(record: record)
            
            guard let locationReference = profile.isCheckedIn else { return }
            
            chekedInProfiles[locationReference.recordID, default: []].append(profile)
        }
        
        operation.queryCompletionBlock = { cursor, error in
            if let error = error {
                completed(.failure(error))
                return
            }
            #warning("handle cursor")
            completed(.success(chekedInProfiles))
        }
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    func getCheckedInProfilesCount(completed: @escaping (Result<[CKRecord.ID: Int], Error>) -> Void) {
        let predicate = NSPredicate(format: "isCheckedInNilCheck == 1")
        let query     = CKQuery(recordType: RecordType.profile, predicate: predicate)
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = [DDGProfile.kIsCheckedIn]
        
        var chekedInProfiles: [CKRecord.ID: Int] = [:]
        operation.recordFetchedBlock = { record in
            guard let locationReference: CKRecord.Reference = record[DDGProfile.kIsCheckedIn] else { return }
            
            if let count = chekedInProfiles[locationReference.recordID] {
                chekedInProfiles[locationReference.recordID] = count + 1
            } else {
                chekedInProfiles[locationReference.recordID] = 1
            }
        }
        
        operation.queryCompletionBlock = { cursor, error in
            if let error = error {
                completed(.failure(error))
                return
            }
            completed(.success(chekedInProfiles))
        }
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    func batchSave(records: [CKRecord], completed: @escaping (Result<[CKRecord], Error>) -> Void) {
        let opertaton = CKModifyRecordsOperation(recordsToSave: records)
        
        opertaton.modifyRecordsCompletionBlock = { savedRecords, _, error in
            guard let savedRecords = savedRecords, error == nil else {
                completed(.failure(error!))
                return
            }
            completed(.success(savedRecords))
        }
        CKContainer.default().publicCloudDatabase.add(opertaton)
    }
    
    func save(record: CKRecord, completed: @escaping (Result<CKRecord, Error>) -> Void) {
        CKContainer.default().publicCloudDatabase.save(record) { record, error in
            guard let record, error == nil else {
                completed(.failure(error!))
                return
            }
            completed(.success(record))
        }
    }
    
    func fetchRecord(with id: CKRecord.ID, completed: @escaping (Result<CKRecord, Error>) -> Void) {
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: id) { record, error in
            guard let record, error == nil else {
                completed(.failure(error!))
                return
            }
            completed(.success(record))
        }
    }
}
