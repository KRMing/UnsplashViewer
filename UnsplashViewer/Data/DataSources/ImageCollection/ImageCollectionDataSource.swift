//
//  ImageCollectionDataSource.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/17.
//

import Foundation
import RxDataSources

typealias ImageCollectionDataSource = RxCollectionViewSectionedAnimatedDataSource<ImageCollectionSection>

struct ImageCollection: Equatable, IdentifiableType {
  let identity: String
  let image: Image
  
  init(identity: String, image: Image) {
    self.identity = identity
    self.image = image
  }
  
  static func == (lhs: ImageCollection, rhs: ImageCollection) -> Bool {
    return lhs.identity == rhs.identity
  }
}

struct ImageCollectionSection: AnimatableSectionModelType {
  typealias Item = ImageCollection
  
  var identity: String
  var items: [Item]
  
  init(identity: String, items: [Item]) {
    self.identity = identity
    self.items = items
  }
  
  init(original: ImageCollectionSection, items: [Item]) {
    self = original
    self.items = items
  }
}
