import CloudKit
import SwiftUI

struct DDGProfile: Identifiable {
    
    static let kFirstName           = "fisrtName"
    static let kLastName            = "lastName"
    static let kAvatar              = "avatar"
    static let kCompanyName         = "companyName"
    static let kBio                 = "bio"
    static let kIsCheckedIn         = "isCheckedIn"
    static let kIsCheckedInNilCheck = "isCheckedInNilCheck"
    
    let id: CKRecord.ID
    let fistName: String
    let lastName: String
    let avatar: CKAsset!
    let companyName: String
    let bio: String
    let isCheckedIn: CKRecord.Reference?
    
    init(record: CKRecord) {
        id          = record.recordID
        fistName    = record[Self.kFirstName] as? String ?? "N/A"
        lastName    = record[Self.kLastName] as? String ?? "N/A"
        avatar      = record[Self.kAvatar] as? CKAsset
        companyName = record[Self.kCompanyName] as? String ?? "N/A"
        bio         = record[Self.kBio] as? String ?? "N/A"
        isCheckedIn = record[Self.kIsCheckedIn] as? CKRecord.Reference
    }
    
    func createImage() -> UIImage {
        if let avatar {
            return avatar.convertToUIImage(in: .square)
        } else {
            return PlaceholderImage.square
        }
    }
}
