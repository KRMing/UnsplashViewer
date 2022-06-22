//
//  Image.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/22.
//

import Foundation

struct Image {
  public let id: String
  public let date: Date
  public let width: Int
  public let height: Int
  public let colorInHex: String
  public let blurHash: String
  public let likes: Int
  public let description: String?
  public let user: User
  public let imageURLs: ImageURLs
  
  init(
    id: String,
    date: Date,
    width: Int,
    height: Int,
    colorInHex: String,
    blurHash: String,
    likes: Int,
    description: String?,
    user: User,
    imageURLs: ImageURLs
  ) {
    self.id = id
    self.date = date
    self.width = width
    self.height = height
    self.colorInHex = colorInHex
    self.blurHash = blurHash
    self.likes = likes
    self.description = description
    self.user = user
    self.imageURLs = imageURLs
  }
}
