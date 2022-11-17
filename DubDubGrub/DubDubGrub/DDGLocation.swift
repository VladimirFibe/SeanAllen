import CloudKit
import UIKit
struct DDGLocation: Identifiable {
    
    static let kNname       = "name"
    static let kDescription = "description"
    static let kSqureAsset  = "squareAsset"
    static let kBannerAsset = "bannerAsset"
    static let kAddress     = "address"
    static let kLocation    = "location"
    static let kWebsiteURL  = "websiteURL"
    static let kPhoneNumber = "phoneNumber"

    let id: CKRecord.ID
    let name: String
    let description: String
    let squareAsset: CKAsset!
    let bannerAsset: CKAsset!
    let address: String
    let location: CLLocation
    let websiteURL: String
    let phoneNumber: String
    
    init(record: CKRecord) {
        id  = record.recordID
        name        = record[Self.kNname] as? String ?? "N/A"
        description = record[Self.kDescription] as? String ?? "N/A"
        squareAsset = record[Self.kSqureAsset] as? CKAsset
        bannerAsset = record[Self.kBannerAsset] as? CKAsset
        address     = record[Self.kAddress] as? String ?? "N/A"
        location    = record[Self.kLocation] as? CLLocation ?? CLLocation(latitude: 0, longitude: 0)
        websiteURL  = record[Self.kWebsiteURL] as? String ?? "N/A"
        phoneNumber = record[Self.kPhoneNumber] as? String ?? "N/A"
    }
    
    func createSquare() -> UIImage {
        createImage(from: squareAsset, in: .square)
    }
    
    func createBanner() -> UIImage {
        createImage(from: bannerAsset, in: .banner)
    }
    private func createImage(from asset: CKAsset?, in dimension: ImageDimension) -> UIImage {
        guard let asset = asset else {
            switch dimension {
            case .square:
                return PlaceholderImage.square
            case .banner:
                return PlaceholderImage.banner
            }
        }
        return asset.convertToUIImage(in: dimension)
    }
}
