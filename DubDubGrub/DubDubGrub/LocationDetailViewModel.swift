import Foundation
import MapKit
import CloudKit

enum CheckInStatus { case checkedIn, checkedOut }
final class LocationDetailViewModel: ObservableObject {
    @Published var checkedInProfiles: [DDGProfile] = []
    @Published var isCheckedIn  = false
    @Published var alertItem: AlertItem?
    @Published var showFriend   = false
    @Published var isLoading    = false

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
    
    func getCheckedInStatus() {
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else { return }
        print("Сейчас проверим")
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let record):
                    print("Идет проверка")
                    if let reference = record[DDGProfile.kIsCheckedIn] as? CKRecord.Reference {
                        isCheckedIn = reference.recordID == location.id
                    } else {
                        isCheckedIn = false
                    }
                case .failure(_):
                    alertItem = AlertContext.unableToGetCheckInStatus
                }
            }
        }
    }
    
    func updateCheckInStatus(to checkInStatus: CheckInStatus) {
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else {
            alertItem = AlertContext.unableToGetProfile
            return
        }
        
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { [self] result in
            switch result {
            case .success(let record):
                switch checkInStatus {
                case .checkedIn:
                    record[DDGProfile.kIsCheckedIn] = CKRecord.Reference(recordID: location.id, action: .none)
                    record[DDGProfile.kIsCheckedInNilCheck] = 1
                case .checkedOut:
                    record[DDGProfile.kIsCheckedIn] = nil
                    record[DDGProfile.kIsCheckedInNilCheck] = 0
                }
                CloudKitManager.shared.save(record: record) { result in
                    DispatchQueue.main.async { [self] in
                        switch result {
                        case .success(let record):
                            let profile = DDGProfile(record: record)
                            switch checkInStatus {
                            case .checkedIn:
                                checkedInProfiles.append(profile)
                            case .checkedOut:
                                checkedInProfiles.removeAll(where: { $0.id == profile.id })
                            }
                            isCheckedIn = checkInStatus == .checkedIn
                        case .failure(_):
                            alertItem = AlertContext.unableToCheckInOrOut
                        }
                    }
                }
            case .failure(_):
                alertItem = AlertContext.unableToCheckInOrOut
            }
        }
    }
    
    func getCheckedInProfiles() {
        showLoadingView()
        CloudKitManager.shared.getCheckedInProfiles(for: location.id) {result in
            DispatchQueue.main.async { [self] in
                hideLoadingView()
                switch result {
                case .success(let profiles):
                    checkedInProfiles = profiles
                case .failure(_):
                    alertItem = AlertContext.unableToGetCheckedInProfiles
                }
            }
        }
    }
    private func showLoadingView() { isLoading = true }
    private func hideLoadingView() { isLoading = false }
}
