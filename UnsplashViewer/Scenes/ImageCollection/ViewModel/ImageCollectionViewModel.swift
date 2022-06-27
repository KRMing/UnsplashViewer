//
//  ImageCollectionViewModel.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/17.
//

import Foundation
import RxSwift
import RxCocoa

struct ImageCollectionViewArgs {}

class ImageCollectionViewModel {
  private let imageRepository: ImageRepository = DI.injector.find()
  private var disposeBag = DisposeBag()
  
  private var args: ImageCollectionViewArgs
  private var imageCellsSubject: BehaviorSubject<[ImageCell]>
  
  public var dataSource: ImageCollectionViewDataSource?
  public var imageCellsDriver: Driver<[ImageCell]>
  
  public var currentPage: Int = 0
  public let numberOfItemsPerPage: Int = 30
  public var loadNextPageThreshold: Int {
    return currentPage * numberOfItemsPerPage - 8
  }
  
  init(args: ImageCollectionViewArgs) {
    self.args = args
    self.imageCellsSubject = BehaviorSubject<[ImageCell]>(value: [ImageCell]())
    self.imageCellsDriver = self.imageCellsSubject
      .asDriver(onErrorJustReturn: [ImageCell]())
  }
  
  public func getImages(
    page: Int? = nil,
    numberofItemsPerPage: Int? = nil,
    resetImages: Bool = false
  ) {
    if resetImages {
      currentPage = 0
    }
    
    currentPage += 1
    let page = page ?? currentPage
    let numberOfItemsPerPage = numberofItemsPerPage ?? numberOfItemsPerPage
    
    _ = imageRepository
      .getImages(page: page, numberOfItemsPerPage: numberOfItemsPerPage)
      .map {
        $0.map {
          ImageCell(
            id: String(
              format: AppConstants.idWithUUIDStringFormat,
              $0.id,
              UUID().uuidString
            ),
            isOverlayOn: false,
            image: $0
          )
        }
      }
      .subscribe(onNext: { [weak self] imageCells in
        let currentCells = try? self?.imageCellsSubject.value()
        if currentCells == nil || currentCells!.isEmpty || resetImages {
          self?.imageCellsSubject.on(.next(imageCells))
        } else {
          self?.imageCellsSubject.on(.next(currentCells! + imageCells))
        }
      })
      .disposed(by: disposeBag)
  }
  
  public func setOverlayOn(for imageId: String) {
    guard var imageCells = try? imageCellsSubject.value() else { return }
    
    guard
      let index = imageCells.firstIndex(where: { $0.image.id == imageId })
    else { return }
    
    let isOverlayOn = imageCells[index].isOverlayOn
    imageCells[index] = imageCells[index].copyWith(isOverlayOn: !isOverlayOn)
    
    imageCellsSubject.on(.next(imageCells))
  }
  
  @objc public func refreshPage() {
    getImages(resetImages: true)
  }
}
