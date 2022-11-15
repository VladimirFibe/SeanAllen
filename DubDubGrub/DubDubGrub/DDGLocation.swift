import CloudKit

struct DDGLocation {
    
    static let kNname       = "name"
    static let kDescription = "description"
    static let kSqureAsset  = "squreAsset"
    static let kBannerAsset = "bunnerAsset"
    static let kAddress     = "address"
    static let kLocation    = "location"
    static let kWebsiteURL  = "websiteURL"
    static let kPhoneNumber = "phoneNumber"
    let ckRecordID: CKRecord.ID
    let name: String
    let description: String
    let squareAsset: CKAsset!
    let bannerAsset: CKAsset!
    let address: String
    let location: CLLocation
    let websiteURL: String
    let phoneNumber: String
    
    init(record: CKRecord) {
        ckRecordID  = record.recordID
        name        = record[Self.kNname] as? String ?? "N/A"
        description = record[Self.kDescription] as? String ?? "N/A"
        squareAsset = record[Self.kSqureAsset] as? CKAsset
        bannerAsset = record[Self.kBannerAsset] as? CKAsset
        address     = record[Self.kAddress] as? String ?? "N/A"
        location    = record[Self.kLocation] as? CLLocation ?? CLLocation(latitude: 0, longitude: 0)
        websiteURL  = record[Self.kWebsiteURL] as? String ?? "N/A"
        phoneNumber = record[Self.kPhoneNumber] as? String ?? "N/A"
    }
}
