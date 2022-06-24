//
//  ImageRepository.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/17.
//

import Foundation
import RxSwift

class ImageRepository {
  private let httpService: HTTPService = DI.injector.find()
  
  public func getImages(
    page: Int,
    numberOfItemsPerPage: Int
  ) -> Observable<[Image]> {
    let queryParameters = [
      "page": page,
      "per_page": numberOfItemsPerPage
    ]
    let dtoObs: Observable<[ImageDTO]> = httpService.get(
      path: "/photos",
      queryParameters: queryParameters
    )
    
    return dtoObs.map { dtos in
      dtos
        .map { $0.asDomainModel() }
    }
  }
}
