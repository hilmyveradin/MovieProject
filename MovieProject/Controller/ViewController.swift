//
//  ViewController.swift
//  MovieProject
//
//  Created by M Hilmy Tsaqif Veradin on 25/12/21.
//
// swiftlint:disable line_length

import UIKit
import Alamofire

class ViewController: UIViewController {
  
  // MARK: - Properties
  private lazy var tableView: UITableView = UITableView()
  
  private lazy var searchBar: UISearchBar = {
    let txtField = UISearchBar()
    txtField.placeholder = "Search for A Moveee"
    txtField.showsCancelButton = true
    return txtField
  }()
  
  let URL = "https://api.themoviedb.org/3/search/movie?api_key=0af831ea11484d607de09f3c882b7fb3&language=en-US&query="
  let URLImage = "https://image.tmdb.org/t/p/original"
  var URLQuery: String!
  var isQueryExisist: Bool!
  
  var data: [Film] = []
  
  // MARK: - Life Cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  // MARK: - Helpers
  fileprivate func setupView() {
    view.backgroundColor = .white
    view.addSubview(searchBar)
    searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10, width: 0, height: 50)
    searchBar.delegate = self
    
    // Check based on query
    if URLQuery != nil && isQueryExisist == true {
      // Set table view
      view.addSubview(tableView)
      tableView.anchor(top: searchBar.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 100)
      tableView.dataSource = self
      tableView.delegate = self
      resetQuery()
      
    } else if URLQuery != nil && isQueryExisist == false {
      let viewDemo = LoadingView()
      view.addSubview(viewDemo)
      viewDemo.anchor(top: searchBar.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
      resetQuery()
      
    } else {
      let viewDemo = StartView()
      view.addSubview(viewDemo)
      viewDemo.anchor(top: searchBar.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
      resetQuery()
    }
  }
  
  fileprivate func resetQuery() {
    isQueryExisist = false
  }
  
}

// MARK: - TableView Delegate and Data Source
extension ViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = data[indexPath.row]
    
    let cell = ProductCell()
    cell.cellContent = item
    
    let url = Foundation.URL(string: URLImage+item.posterPath)
    
    cell.productImage.kf.setImage(with: url, placeholder: UIImage(named: "progress"), options: nil, progressBlock: nil, completionHandler: nil)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = data[indexPath.row]
    
    let detailViewController = DetailViewController()
    let navigationController = UINavigationController(rootViewController: detailViewController)
    
    detailViewController.navigationTitle = item.filmTitle
    detailViewController.posterURL = item.posterPath
    
    navigationController.modalPresentationStyle = .fullScreen
    present(navigationController, animated: true, completion: nil)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}

// MARK: - SearchBar Delegate
extension ViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    let urlString = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?.lowercased()
    URLQuery = urlString!
    fetchFilms()
    searchBar.endEditing(true)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    URLQuery = nil
    viewDidLoad()
    searchBar.endEditing(true)
  }
  
}

// MARK: - Networking
extension ViewController {
  func fetchFilms() {
//    print(URL+URLQuery)
    AF.request(URL+URLQuery)
      .validate()
      .responseDecodable(of: Films.self) { (response) in
        guard let films = response.value else {
//          print("not exists")
          self.viewDidLoad()
          self.resetQuery()
          return
        }
        
        //check films result
        if films.totalResults == 0 {
//          print(1)
          self.viewDidLoad()
          
        } else {
//          print(2)
          self.isQueryExisist = true
          self.data = films.all
          DispatchQueue.main.async {
            self.tableView.reloadData()
          }
          self.viewDidLoad()
        }
        
      }
  }
  
}
