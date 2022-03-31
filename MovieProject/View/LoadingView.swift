//
//  LoadingView.swift
//  MovieProject
//
//  Created by M Hilmy Tsaqif Veradin on 23/01/22.
// swiftlint:disable line_length

import UIKit

class LoadingView: UIView {
  //MARK: - Properties
  private lazy var textTitle: UILabel = {
    let headerTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    headerTitle.font = UIFont.systemFont(ofSize: 100, weight: .medium)
    headerTitle.text = "😞"
    headerTitle.textAlignment = .center
    return headerTitle
  }()

  private lazy var textDescription: UILabel = {
    let headerTitle = UILabel(frame: CGRect(x: 100, y: 100, width: 300, height: 40))
    headerTitle.font = UIFont.systemFont(ofSize: 22, weight: .medium)
    headerTitle.text = "Looks Like We Can't find the movie you've been searching for"
    headerTitle.textAlignment = .center
    headerTitle.numberOfLines = 0
    return headerTitle
  }()
  
  //MARK: - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Helpers
  fileprivate func setupView() {
    backgroundColor = .white
    
    addSubview(textTitle)
    textTitle.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 150, paddingLeft: 100, paddingRight: 100)
    
    addSubview(textDescription)
    textDescription.anchor(top: textTitle.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 20, paddingLeft: 100, paddingBottom: 0, paddingRight: 100)
  }
  
}
