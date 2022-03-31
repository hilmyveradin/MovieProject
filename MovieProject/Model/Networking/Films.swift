//
//  Films.swift
//  MovieProject
//
//  Created by M Hilmy Tsaqif Veradin on 09/01/22.
//

import UIKit

struct Films: Decodable {
  let all: [Film]
  let page: Int
  let totalResults: Int

  enum CodingKeys: String, CodingKey {
    case all = "results"
    case page
    case totalResults = "total_results"
  }

}
