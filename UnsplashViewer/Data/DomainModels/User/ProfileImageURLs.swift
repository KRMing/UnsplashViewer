//
//  ProfileImageURLs.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/22.
//

import Foundation

struct ProfileImageURLs {
  public let small: String
  public let medium: String
  public let large: String
  
  init(small: String, medium: String, large: String) {
    self.small = small
    self.medium = medium
    self.large = large
  }
}
