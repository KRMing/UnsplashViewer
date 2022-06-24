//
//  ImageCell.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/20.
//

import Foundation

struct ImageCell: Equatable {
  public let id: String
  public let isOverlayOn: Bool
  public let image: Image
  
  init(id: String, isOverlayOn: Bool = false, image: Image) {
    self.id = id
    self.isOverlayOn = isOverlayOn
    self.image = image
  }
  
  public static func == (lhs: ImageCell, rhs: ImageCell) -> Bool {
    return lhs.id == rhs.id
    && lhs.isOverlayOn == rhs.isOverlayOn
    && lhs.image == rhs.image
  }
  
  public func copyWith(
    id: String? = nil,
    isOverlayOn: Bool? = nil,
    image: Image? = nil
  ) -> ImageCell {
    return ImageCell(
      id: id ?? self.id,
      isOverlayOn: isOverlayOn ?? self.isOverlayOn,
      image: image ?? self.image
    )
  }
}
