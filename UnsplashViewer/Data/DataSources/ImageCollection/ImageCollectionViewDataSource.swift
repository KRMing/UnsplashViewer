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
  public let image: ImageCell
  
  init(identity: String, image: ImageCell) {
    self.identity = identity
    self.image = image
  }
  
  public static func == (
    lhs: ImageCollectionDataSourceType,
    rhs: ImageCollectionDataSourceType
  ) -> Bool {
    return lhs.identity == rhs.identity
    && lhs.image == rhs.image
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
