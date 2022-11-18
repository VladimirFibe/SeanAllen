import CloudKit

final class CloudKitManager {
    
    static let shared = CloudKitManager()
    private init(){}
    var userRecord: CKRecord?
    func getUserRecord() {
        CKContainer.default().fetchUserRecordID { recordID, error in
            guard let recordID, error == nil else { return }
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { userRecord, error in
                if error == nil {
                    self.userRecord = userRecord
                }
            }
        }
    }
    
    func getLocations(completed: @escaping (Result<[DDGLocation], Error>) -> Void) {
        let sordDescriptor = NSSortDescriptor(key: DDGLocation.kNname, ascending: true)
        let query = CKQuery(recordType: RecordType.location, predicate: NSPredicate(value: true))
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
