//
//  ImageRepository.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/17.
//

import Foundation
import RxSwift

class ImageRepository {
  let httpService: HTTPService = DI.injector.find()
  
  public func getImages() -> Observable<[Image]> {
    let dtoObs: Observable<[ImageDTO]> = httpService.get(path: "/photos")
    return dtoObs.map { dtos in
      dtos.map { $0.asDomainModel() }
    }
  }
}
