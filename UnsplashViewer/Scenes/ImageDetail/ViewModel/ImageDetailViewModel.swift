//
//  ImageDetailViewModel.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/23.
//

import Foundation
import RxSwift

class ImageDetailViewModel {
  private let imageRepository: ImageRepository = DI.injector.find()
  private var disposeBag = DisposeBag()
  
}
