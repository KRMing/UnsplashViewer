//
//  UserDTO.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/21.
//

import Foundation

struct UserDTO: Codable {
  let id: String
  let username: String
  let name: String
  let profileImage: ProfileImageURLsDTO
  
  enum CodingKeys: String, CodingKey {
    case id
    case username
    case name
    case profileImage = "profile_image"
  }
  
  public func asDomainModel() -> User {
    return User(id: id, username: username, name: name, profileImage: profileImage.asDomainModel())
  }
}
