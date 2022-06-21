//
//  ImageDto.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/20.
//

import Foundation

struct ImageDTO: Codable {
  /// TEMP CODE
  let val1: String
  let val2: Int
  let val3: Float
  
  enum CodingKeys: String, CodingKey {
    case val1 = "val1"
    case val2 = "val2"
    case val3 = "val3"
  }
  
  init(from decoder: Decoder) throws {
    let keys = try decoder.container(keyedBy: CodingKeys.self)
    
    self.val1 = try keys.decode(String.self, forKey: .val1)
    self.val2 = try keys.decode(Int.self, forKey: .val2)
    self.val3 = try keys.decode(Float.self, forKey: .val3)
  }
  
  public func asDomainModel() -> Image {
    /// TEMP CODE
    return Image(value: 1)
  }
}
