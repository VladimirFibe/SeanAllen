import CloudKit

struct MockData {
    static var location: CKRecord {
        let record = CKRecord(recordType: RecordType.location)
        record[DDGLocation.kNname]          = "Sean's Bar and Grill"
        record[DDGLocation.kAddress]        = "123 Main Street"
        record[DDGLocation.kDescription]    = "This is a test description."
        record[DDGLocation.kWebsiteURL]     = "https://seanallen.co"
        record[DDGLocation.kLocation]       = CLLocation(latitude: 37.331516, longitude: -121.891054)
        record[DDGLocation.kPhoneNumber]    = "111-111-1111"
        return record
    }
    
    static var profile: CKRecord {
        let record = CKRecord(recordType: RecordType.profile)
        record[DDGProfile.kFirstName]   = "Vladimir"
        record[DDGProfile.kLastName]    = "Fibe"
        record[DDGProfile.kCompanyName] = "MacService"
        record[DDGProfile.kBio]         = "I'm happy!!!"
        return record
    }
}
