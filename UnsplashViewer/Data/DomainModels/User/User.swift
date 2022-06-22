//
//  User.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/22.
//

import Foundation

struct User {
  public let id: String
  public let username: String
  public let name: String
  public let profileImage: ProfileImageURLs
  
  init(id: String, username: String, name: String, profileImage: ProfileImageURLs) {
    self.id = id
    self.username = username
    self.name = name
    self.profileImage = profileImage
  }
}
