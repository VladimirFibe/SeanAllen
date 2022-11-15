//
//  CKRecord+Extension.swift
//  DubDubGrub
//
//  Created by Vladimir Fibe on 15.11.2022.
//

import CloudKit

extension CKRecord {
    func convertToDDGlocation() -> DDGLocation { DDGLocation(record: self) }
    func convertToDDGProfile() -> DDGProfile { DDGProfile(record: self)}
}
