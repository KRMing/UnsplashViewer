//
//  ImageCollectionViewModel.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/17.
//

import Foundation
import RxSwift

class ImageCollectionViewModel {
  let numberOfCellsPerRow = 3
  
  var disposeBag = DisposeBag()
  var dataSource: ImageCollectionDataSource?
  
  /// TEMP CODE
  let dataFromApi = Observable.just(Array(0...98))
    .map { $0.map { Image(value: $0) } }
    .asDriver(onErrorJustReturn: [])
}
