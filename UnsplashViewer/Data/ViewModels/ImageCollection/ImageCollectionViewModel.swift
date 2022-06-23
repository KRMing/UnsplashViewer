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
  private let imageRepository: ImageRepository = DI.injector.find()
  private var disposeBag = DisposeBag()
  
  private var imagesSubject: BehaviorSubject<[Image]>
  private var imageCellsSubject: BehaviorSubject<[ImageCell]>
  
  public var dataSource: ImageCollectionViewDataSource?
  public var imageCellsDriver: Driver<[ImageCell]>
  
  init() {
    self.imagesSubject = BehaviorSubject<[Image]>(value: [Image]())
    self.imageCellsSubject = BehaviorSubject<[ImageCell]>(value: [ImageCell]())
    self.imageCellsDriver = self.imageCellsSubject.asDriver(onErrorJustReturn: [ImageCell]())
    
    bind()
  }
  
  private func bind() {
    imageRepository
      .getImages()
      .subscribe { [weak self] images in
        self?.imagesSubject.on(.next(images))
      }
      .disposed(by: disposeBag)
    
    imagesSubject
      .subscribe { [weak self] images in
        self?.imageCellsSubject.on(.next(
          images.map {
            ImageCell(
              isOverlayOn: false,
              image: $0
            )
          }
        ))
      }
      .disposed(by: disposeBag)
  }
  
  public func setOverlayOn(for imageId: String) {
    guard var imageCells = try? imageCellsSubject.value() else { return }
    
    guard let index = imageCells.firstIndex(where: { $0.image.id == imageId }) else { return }
    
    let isOverlayOn = imageCells[index].isOverlayOn
    imageCells[index] = imageCells[index].copyWith(isOverlayOn: !isOverlayOn)
    
    imageCellsSubject.on(.next(imageCells))
  }
}
