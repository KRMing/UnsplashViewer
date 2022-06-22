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
  
  public func getImages() -> Observable<[ImageCell]> {
    let queryParameters = ["per_page": 30]
    let dtoObs: Observable<[ImageDTO]> = httpService.get(
      path: "/photos",
      queryParameters: queryParameters
    )
    
    return dtoObs.map { dtos in
      dtos
        .map { $0.asDomainModel() }
        .map {
          ImageCell(
            id: $0.id,
            date: $0.date,
            thumbnailURL: $0.imageURLs.thumbnail,
            likes: $0.likes,
            isOverlayOn: false
          )
        }
    }
  }
}
