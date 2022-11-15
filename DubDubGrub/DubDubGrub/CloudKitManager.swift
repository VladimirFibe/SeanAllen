import CloudKit

struct CloudKitManager {
    static func getLocations(completed: @escaping (Result<[DDGLocation], Error>) -> Void) {
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
}
