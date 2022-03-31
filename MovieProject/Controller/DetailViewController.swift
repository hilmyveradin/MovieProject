//
//  DetailViewController.swift
//  MovieProject
//
//  Created by M Hilmy Tsaqif Veradin on 27/12/21.
//
// swiftlint:disable line_length

import UIKit
import Alamofire
import Kingfisher

class DetailViewController: UIViewController {
  
  //MARK: - Properties
  var navigationTitle: String! = ""
  var posterURL: String! = ""
  let imageURL: String! = "https://image.tmdb.org/t/p/original"
  var imageView = UIImageView()
  
  //MARK: - View Cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupURL(imageURL: imageURL, posterURL: posterURL)
    setupViews()
  }
  
  //MARK: - Helpers
  fileprivate func setupURL(imageURL: String, posterURL: String) {
    let url = URL(string: imageURL+posterURL)
    imageView.kf.setImage(with: url)
  }
  
  fileprivate func setupViews() {
    // Set navigation item
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(dismissSelf))
    navigationItem.title = navigationTitle
    
    // Set imageView
    view.addSubview(imageView)
    imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
  }

  @objc private func dismissSelf() {
    // dismiss view controller
    dismiss(animated: true, completion: nil)
  }
}

// MARK: SwiftUI Preview
import SwiftUI
#if DEBUG
struct ContentViewControllerContainerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = DetailViewController

    func makeUIViewController(context: Context) -> UIViewControllerType {
        return DetailViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct ContentViewController_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewControllerContainerView().colorScheme(.light) // or .dark
    }
}
#endif
