//
//  ImageCell.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/20.
//

import Foundation

struct ImageCell: Equatable {
  public let id: String
  public let date: Date
  public let thumbnailURL: String
  public let likes: Int
  public let isOverlayOn: Bool

  init(id: String, date: Date, thumbnailURL: String, likes: Int, isOverlayOn: Bool = false) {
    self.id = id
    self.date = date
    self.thumbnailURL = thumbnailURL
    self.likes = likes
    self.isOverlayOn = isOverlayOn
  }
  
  public static func == (lhs: ImageCell, rhs: ImageCell) -> Bool {
    return lhs.id == rhs.id
    && lhs.date == rhs.date
    && lhs.thumbnailURL == rhs.thumbnailURL
    && lhs.likes == rhs.likes
    && lhs.isOverlayOn == rhs.isOverlayOn
  }
  
  public func copyWith(
    id: String? = nil,
    date: Date? = nil,
    thumbnailURL: String? = nil,
    likes: Int? = nil,
    isOverlayOn: Bool? = nil
  ) -> ImageCell {
    return ImageCell(
      id: id ?? self.id,
      date: date ?? self.date,
      thumbnailURL: thumbnailURL ?? self.thumbnailURL,
      likes: likes ?? self.likes,
      isOverlayOn: isOverlayOn ?? self.isOverlayOn
    )
  }
}
