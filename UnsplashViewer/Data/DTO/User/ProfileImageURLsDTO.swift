//
//  ProfileImageURLsDTO.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/21.
//

import Foundation

struct ProfileImageURLsDTO: Codable {
  public let small: String
  public let medium: String
  public let large: String
  
  enum CodingKeys: String, CodingKey {
    case small
    case medium
    case large
  }
  
  public func asDomainModel() -> ProfileImageURLs {
    return ProfileImageURLs(small: small, medium: medium, large: large)
  }
}
