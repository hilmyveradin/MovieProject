//
//  ProductCell.swift
//  MovieProject
//
//  Created by M Hilmy Tsaqif Veradin on 23/01/22.
//
// swiftlint:disable line_length

import UIKit
import Kingfisher

class ProductCell: UITableViewCell {
  
  //MARK: - Properties
  private lazy var productNameLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.boldSystemFont(ofSize: 16)
    lbl.textAlignment = .left
    lbl.numberOfLines = 0
    return lbl
  }()
  
  private lazy var productDescriptionLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.systemFont(ofSize: 16)
    lbl.textAlignment = .left
    lbl.numberOfLines = 0
    return lbl
  }()
  
  lazy var productImage: UIImageView = {
    let imgView = UIImageView()
    return imgView
  }()
  
  let imageURL: String! = "https://image.tmdb.org/t/p/original"
  var posterURL: String! = ""
  
  var cellContent: Film? {
    didSet {
      productNameLabel.text = cellContent?.filmTitle
      productDescriptionLabel.text = getFormattedDate(strDate: cellContent!.releaseDate, currentFomat: "yyyy-MM-dd", expectedFromat: "MMMM yyyy")
    }
  }
  
  //MARK: - Initialization
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Helpers
  fileprivate func setupView() {
    addSubview(productImage)
    addSubview(productNameLabel)
    addSubview(productDescriptionLabel)

    productImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, width: 60, height: 90)
    productNameLabel.anchor(top: topAnchor, left: productImage.rightAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 20, paddingLeft: 10)
    productDescriptionLabel.anchor(top: productNameLabel.bottomAnchor, left: productImage.rightAnchor, right: nil, paddingLeft: 10)
  }

  private func getFormattedDate(strDate: String, currentFomat: String, expectedFromat: String) -> String {
      let dateFormatterGet = DateFormatter()
      dateFormatterGet.dateFormat = currentFomat

      let date: Date = dateFormatterGet.date(from: strDate) ?? Date()

      dateFormatterGet.dateFormat = expectedFromat
      return dateFormatterGet.string(from: date)
  }

}
