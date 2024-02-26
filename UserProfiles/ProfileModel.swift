// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let menuModel = try? JSONDecoder().decode(MenuModel.self, from: jsonData)

import Foundation

// MARK: - MenuModelElement
class ProfileModel: Codable {
    let profileImageUrl:String
    let profileImage: String
    let yourName, phone, birthday: String
    let isMale: Bool
    let notes: String
    
    enum CodingKeys: String, CodingKey {
        case profileImageUrl = "profile_image_url"
        case profileImage = "profile_image"
        case yourName = "your_name"
        case phone, birthday
        case isMale = "is_male"
        case notes
    }
    
    init(profileImageUrl: String, profileImage: String, yourName: String, phone: String, birthday: String, isMale: Bool, notes: String) {
        self.profileImageUrl = profileImageUrl
        self.profileImage = profileImage
        self.yourName = yourName
        self.phone = phone
        self.birthday = birthday
        self.isMale = isMale
        self.notes = notes
    }
}


typealias MenuModel = [ProfileModel]
