//
//  Interceptor.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/20.
//

import Foundation
import Alamofire

class Interceptor: RequestAdapter, RequestRetrier {
  private let accessToken = HTTPConstants.accessToken
  
  // - MARK: Request Adapter
  func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
    var urlRequest = urlRequest
    urlRequest.setValue("Client-ID \(accessToken)", forHTTPHeaderField: "Authorization")
    urlRequest.setValue("v1", forHTTPHeaderField: "Accept-Version")

    return urlRequest
  }
  
  // - MARK: Request Retrier
  func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
    
  }
}
