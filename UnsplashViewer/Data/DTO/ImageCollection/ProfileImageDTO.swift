//
//  ProfileImageDTO.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/21.
//

import Foundation

struct ProfileImageDTO: Codable {
  let smallImageURL: String
  let mediumImageURL: String
  let largeImageURL: String
  
  enum CodingKeys: String, CodingKey {
    case smallImageURL = "small"
    case mediumImageURL = "medium"
    case largeImageURL = "large"
  }
}
