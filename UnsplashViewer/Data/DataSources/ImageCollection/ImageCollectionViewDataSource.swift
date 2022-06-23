//
//  ImageCollectionViewDataSource.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/17.
//

import Foundation
import RxDataSources

typealias ImageCollectionViewDataSource = RxCollectionViewSectionedAnimatedDataSource<ImageCollectionSectionDataSourceType>

struct ImageCollectionDataSourceType: Equatable, IdentifiableType {
  public let identity: String
  public let imageCell: ImageCell
  
  init(identity: String, imageCell: ImageCell) {
    self.identity = identity
    self.imageCell = imageCell
  }
  
  public static func == (
    lhs: ImageCollectionDataSourceType,
    rhs: ImageCollectionDataSourceType
  ) -> Bool {
    return lhs.identity == rhs.identity
    && lhs.imageCell == rhs.imageCell
  }
}

struct ImageCollectionSectionDataSourceType: AnimatableSectionModelType {
  typealias Item = ImageCollectionDataSourceType
  
  public var identity: String
  public var items: [Item]
  
  init(identity: String, items: [Item]) {
    self.identity = identity
    self.items = items
  }
  
  init(original: ImageCollectionSectionDataSourceType, items: [Item]) {
    self = original
    self.items = items
  }
}
