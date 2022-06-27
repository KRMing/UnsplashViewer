//
//  ImageDTO.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/20.
//

import Foundation

struct ImageDTO: Codable {
  public let id: String
  public let date: Date
  public let width: Int
  public let height: Int
  public let colorInHex: String
  public let blurHash: String?
  public let likes: Int
  public let description: String?
  public let user: UserDTO
  public let profileImage: ProfileImageURLsDTO?
  public let imageURLs: ImageURLsDTO
  
  enum CodingKeys: String, CodingKey {
    case id
    case date = "created_at"
    case width
    case height
    case colorInHex = "color"
    case blurHash = "blur_hash"
    case likes
    case description
    case user
    case profileImage = "profile_image"
    case imageURLs = "urls"
  }
  
  init(from decoder: Decoder) throws {
    let keys = try decoder.container(keyedBy: CodingKeys.self)
    let dateString = try keys.decode(String.self, forKey: .date)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = AppConstants.serverDateFormat
    
    self.id = try keys.decode(String.self, forKey: .id)
    self.date = dateFormatter.date(from: dateString)!
    self.width = try keys.decode(Int.self, forKey: .width)
    self.height = try keys.decode(Int.self, forKey: .height)
    self.colorInHex = try keys.decode(String.self, forKey: .colorInHex)
    self.blurHash = try? keys.decode(String.self, forKey: .blurHash)
    self.likes = try keys.decode(Int.self, forKey: .likes)
    self.description = try? keys.decode(String.self, forKey: .description)
    self.user = try keys.decode(UserDTO.self, forKey: .user)
    self.profileImage = try? keys.decode(ProfileImageURLsDTO.self, forKey: .profileImage)
    self.imageURLs = try keys.decode(ImageURLsDTO.self, forKey: .imageURLs)
  }
  
  public func asDomainModel() -> Image {
    return Image(
      id: String(format: AppConstants.idWithUUIDStringFormat, id, UUID().uuidString),
      date: date,
      width: width,
      height: height,
      colorInHex: colorInHex,
      blurHash: blurHash,
      likes: likes,
      description: description,
      user: user.asDomainModel(),
      imageURLs: imageURLs.asDomainModel()
    )
  }
}

struct ImageURLsDTO: Codable {
  let raw: String
  let full: String
  let regular: String
  let small: String
  let thumbnail: String
  
  enum CodingKeys: String, CodingKey {
    case raw
    case full
    case regular
    case small
    case thumbnail = "thumb"
  }
  
  public func asDomainModel() -> ImageURLs {
    return ImageURLs(raw: raw, full: full, regular: regular, small: small, thumbnail: thumbnail)
  }
}
