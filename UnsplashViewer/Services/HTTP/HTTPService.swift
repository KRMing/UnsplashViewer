//
//  HTTPService.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/16.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

final class HTTPService {
  private let scheduler: ConcurrentDispatchQueueScheduler
  private let baseUrl: String
  private let session: SessionManager
  
  init() {
    self.scheduler = ConcurrentDispatchQueueScheduler(
      qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1)
    )
    self.baseUrl = HTTPConstants.baseURL
    
    /// Setup Alamofire Custom Session
    let configuration = URLSessionConfiguration.ephemeral
    self.session = SessionManager(configuration: configuration)
    self.session.adapter = Interceptor()
  }
  
  public func get<T: Decodable>(
    path: String? = nil,
    queryParameters: [String: Any]? = nil
  ) -> Observable<T> {
    let urlPath = "\(baseUrl)" + ((path != nil) ? "\(path!)/" : "")
    return self.session.rx.request(.get, urlPath, parameters: queryParameters)
      .observeOn(self.scheduler)
      .debug()
      .validate(statusCode: 200 ..< 300)
      .validate(contentType: ["text/json"])
      .data()
      .flatMap { data -> Observable<T> in
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return Observable.just(decoded)
      }
  }
}
