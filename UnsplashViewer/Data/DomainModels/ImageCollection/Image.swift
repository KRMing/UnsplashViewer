//
//  Image.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/22.
//

import Foundation

struct Image {
  let id: String
  let date: Date
  let width: Int
  let height: Int
  let colorInHex: String
  let blurHash: String
  let likes: Int
  let description: String?
  let user: User
  let imageURLs: ImageURLs
  
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
