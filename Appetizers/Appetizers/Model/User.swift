import Foundation

struct User: Codable {
    var firstname           = ""
    var lastname            = ""
    var email               = ""
    var birthdate           = Date()
    var extraNapkins        = false
    var frequentRefills     = false
}
