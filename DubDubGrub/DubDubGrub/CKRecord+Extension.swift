import CloudKit

extension CKRecord {
    func convertToDDGlocation() -> DDGLocation { DDGLocation(record: self) }
    func convertToDDGProfile() -> DDGProfile { DDGProfile(record: self)}
}
