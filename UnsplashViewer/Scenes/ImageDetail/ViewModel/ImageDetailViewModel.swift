//
//  ImageDetailViewModel.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/23.
//

import Foundation
import RxSwift

struct ImageDetailViewArgs {
  let image: Image
}

class ImageDetailViewModel {
  private let imageRepository: ImageRepository = DI.injector.find()
  private var disposeBag = DisposeBag()
  private let args: ImageDetailViewArgs
  
  public let image: Image
  
  init(args: ImageDetailViewArgs) {
    self.args = args
    
    self.image = args.image
  }
}
