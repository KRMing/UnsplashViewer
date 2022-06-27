//
//  Interceptor.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/20.
//

import Foundation
import Alamofire

class Interceptor {
  private static let accessToken = HTTPConstants.accessToken
  
  // - MARK: Request Adapter
  public struct adapter: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
      var urlRequest = urlRequest
      urlRequest.setValue("Client-ID \(accessToken)", forHTTPHeaderField: "Authorization")
      urlRequest.setValue("v1", forHTTPHeaderField: "Accept-Version")

      return urlRequest
    }
  }
  
  // - MARK: Request Retrier
  public struct retrier: RequestRetrier {
    func should(
      _ manager: SessionManager,
      retry request: Request,
      with error: Error,
      completion: @escaping RequestRetryCompletion
    ) {
      
    }
  }
}
