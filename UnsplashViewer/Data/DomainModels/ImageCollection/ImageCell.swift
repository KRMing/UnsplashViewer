//
//  ImageCell.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/20.
//

import Foundation

struct ImageCell: Equatable {
  public let isOverlayOn: Bool
  public let image: Image
  
  init(isOverlayOn: Bool = false, image: Image) {
    self.isOverlayOn = isOverlayOn
    self.image = image
  }
  
  public static func == (lhs: ImageCell, rhs: ImageCell) -> Bool {
    return lhs.isOverlayOn == rhs.isOverlayOn
    && lhs.image == rhs.image
  }
  
  public func copyWith(
    isOverlayOn: Bool? = nil,
    image: Image? = nil
  ) -> ImageCell {
    return ImageCell(
      isOverlayOn: isOverlayOn ?? self.isOverlayOn,
      image: image ?? self.image
    )
  }
}
