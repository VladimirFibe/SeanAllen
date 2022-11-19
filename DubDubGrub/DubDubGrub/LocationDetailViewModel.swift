import Foundation
import MapKit
import CloudKit

enum CheckInStatus { case checkedIn, checkedOut }
final class LocationDetailViewModel: ObservableObject {
    @Published var checkedInProfiles: [DDGProfile] = []
    @Published var isCheckedIn = false
    @Published var alertItem: AlertItem?
    @Published var showFriend = false
    let location: DDGLocation
    
    var checking: CheckInStatus {
        isCheckedIn ? .checkedOut : .checkedIn
    }
    init(location: DDGLocation) {
        self.location = location
    }
    
    func getDirectionsToLocation() {
        let placemark = MKPlacemark(coordinate: location.location.coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = location.name
        
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
    }
    
    func callLocation() {
        guard let url = URL(string: "") else {
            alertItem = AlertContext.invalidPhoneNumber
            return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            alertItem = AlertContext.invalidPhoneNumber
        }
    }
    
    func updateCheckInStatus(to checkInStatus: CheckInStatus) {
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else { return }
        
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { [self] result in
            switch result {
            case .success(let record):
                switch checkInStatus {
                case .checkedIn:
                    record[DDGProfile.kIsCheckedIn] = CKRecord.Reference(recordID: location.id, action: .none)
                case .checkedOut:
                    record[DDGProfile.kIsCheckedIn] = nil
                }
                CloudKitManager.shared.save(record: record) { result in
                    DispatchQueue.main.async { [self] in
                        switch result {
                        case .success(_):
                            let profile = DDGProfile(record: record)
                            switch checkInStatus {
                            case .checkedIn:
                                checkedInProfiles.append(profile)
                            case .checkedOut:
                                checkedInProfiles.removeAll(where: { $0.id == profile.id })
                            }
                            isCheckedIn = checkInStatus == .checkedIn
                            print("✅ checked in/out successfully!!!")
                        case .failure(_):
                            print("❌ error saving record")
                        }
                    }
                }
            case .failure(_):
                print("❌ error fetching record")
            }
        }
    }
    
    func getCheckedInProfiles() {
        CloudKitManager.shared.getCheckedInProfiles(for: location.id) {[self] result in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let profiles):
                    checkedInProfiles = profiles
                case .failure(_):
                    print("❌ error fetching checkedIn profiles")
                }
            }
        }
    }
}
