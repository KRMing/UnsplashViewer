//
//  User.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/22.
//

import Foundation

struct User {
  let id: String
  let username: String
  let name: String
  let profileImage: ProfileImageURLs
  
  init(id: String, username: String, name: String, profileImage: ProfileImageURLs) {
    self.id = id
    self.username = username
    self.name = name
    self.profileImage = profileImage
  }
}
