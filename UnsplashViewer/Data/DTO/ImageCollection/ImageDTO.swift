//
//  ImageDto.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/20.
//

import Foundation

struct ImageDTO: Codable {
  /// TEMP CODE
  let id: String
  let creationDate: Date
  let width: Int
  let height: Int
  let colorInHex: String
  let blurHash: String
  let likes: Int
  let description: String?
  let user: UserDTO
  let profileImage: ProfileImageDTO?
  let imageURLs: ImageURLsDTO
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case creationDate = "created_at"
    case width = "width"
    case height = "height"
    case colorInHex = "color"
    case blurHash = "blur_hash"
    case likes = "likes"
    case description = "description"
    case user = "user"
    case profileImage = "profile_image"
    case imageURLs = "urls"
  }
  
  init(from decoder: Decoder) throws {
    let keys = try decoder.container(keyedBy: CodingKeys.self)
    let creationDateString = try keys.decode(String.self, forKey: .creationDate)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = AppConstants.serverDateFormat
    
    self.id = try keys.decode(String.self, forKey: .id)
    self.creationDate = dateFormatter.date(from: creationDateString)!
    self.width = try keys.decode(Int.self, forKey: .width)
    self.height = try keys.decode(Int.self, forKey: .height)
    self.colorInHex = try keys.decode(String.self, forKey: .colorInHex)
    self.blurHash = try keys.decode(String.self, forKey: .blurHash)
    self.likes = try keys.decode(Int.self, forKey: .likes)
    self.description = try? keys.decode(String.self, forKey: .description)
    self.user = try keys.decode(UserDTO.self, forKey: .user)
    self.profileImage = try? keys.decode(ProfileImageDTO.self, forKey: .profileImage)
    self.imageURLs = try keys.decode(ImageURLsDTO.self, forKey: .imageURLs)
  }
  
  public func asDomainModel() -> Image {
    return Image(id: self.id)
  }
}

struct ImageURLsDTO: Codable {
  let raw: String
  let full: String
  let regular: String
  let small: String
  let thumbnail: String
  
  enum CodingKeys: String, CodingKey {
    case raw = "raw"
    case full = "full"
    case regular = "regular"
    case small = "small"
    case thumbnail = "thumb"
  }
}
