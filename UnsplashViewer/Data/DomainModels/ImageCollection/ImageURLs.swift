//
//  ImageURLs.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/22.
//

import Foundation

struct ImageURLs {
  let raw: String
  let full: String
  let regular: String
  let small: String
  let thumbnail: String
  
  init(raw: String, full: String, regular: String, small: String, thumbnail: String) {
    self.raw = raw
    self.full = full
    self.regular = regular
    self.small = small
    self.thumbnail = thumbnail
  }
}
