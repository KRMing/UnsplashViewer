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
  var disposeBag = DisposeBag()
  
  private var imageCellsSubject: BehaviorSubject<[ImageCell]>
  
  public var dataSource: ImageCollectionViewDataSource?
  public var imageCellsDriver: Driver<[ImageCell]>
  
  init() {
    self.imageCellsSubject = BehaviorSubject<[ImageCell]>(value: [ImageCell]())
    self.imageCellsDriver = self.imageCellsSubject.asDriver(onErrorJustReturn: [ImageCell]())
    
    bind()
  }
  
  private func bind() {
    imageRepository
      .getImages()
      .subscribe { [weak self] images in
        self?.imageCellsSubject.on(.next(images))
      }
      .disposed(by: disposeBag)
  }
  
  public func setOverlayOn(for imageId: String) {
    guard var imageCells = try? imageCellsSubject.value() else { return }
    
    guard let index = imageCells.firstIndex(where: { $0.id == imageId }) else { return }
    
    let isOverlayOn = imageCells[index].isOverlayOn
    imageCells[index] = imageCells[index].copyWith(isOverlayOn: !isOverlayOn)
    
    imageCellsSubject.on(.next(imageCells))
  }
}
