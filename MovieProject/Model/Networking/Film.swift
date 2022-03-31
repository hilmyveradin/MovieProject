//
//  Film.swift
//  MovieProject
//
//  Created by M Hilmy Tsaqif Veradin on 12/01/22.
//

import UIKit

struct Film: Decodable {
  let filmTitle: String
  let overview: String
  let posterPath: String
  let releaseDate: String

  enum CodingKeys: String, CodingKey {
    case filmTitle = "original_title"
    case overview
    case posterPath = "poster_path"
    case releaseDate = "release_date"
  }
}
