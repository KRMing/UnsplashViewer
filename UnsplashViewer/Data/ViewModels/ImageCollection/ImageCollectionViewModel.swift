//
//  ImageCollectionViewModel.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/17.
//

import Foundation
import RxSwift
import RxCocoa

class ImageCollectionViewModel {
  let numberOfCellsPerRow = 3
  let imageRepository: ImageRepository = DI.injector.find()
  
  var dataSource: ImageCollectionDataSource?
  
  public func getImages() -> Driver<[Image]> {
    return imageRepository.getImages()
      .asDriver(onErrorJustReturn: [])
  }
}
