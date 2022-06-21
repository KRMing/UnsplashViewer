//
//  Image.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/20.
//

import Foundation

struct Image {
  let id: String
  let date: Date
  let imageURL: String
  let likes: Int

  init(id: String, date: Date, imageURL: String, likes: Int) {
    self.id = id
    self.date = date
    self.imageURL = imageURL
    self.likes = likes
  }
}
