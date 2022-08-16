//
//  ViewController.swift
//  GitJsonApp
//
//

import UIKit
import Alamofire
import SwiftUI

class ViewController: UIViewController {
    @IBOutlet var table: UITableView!
    var search = UISearchController(searchResultsController: nil)
    let networkServise = NetworkService()
    var searceBook: SearchBook? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        writeInTableView()
        writeSearchBar()
        
        
    }
    
    
    private func writeSearchBar() {
        navigationItem.searchController = search
        search.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        search.obscuresBackgroundDuringPresentation = false
        
    }
    
    
    private func writeInTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "list")
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searceBook?.docs.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = table.dequeueReusableCell(withIdentifier: "list", for: indexPath)
        let name = searceBook?.docs[indexPath.row]
        list.textLabel?.text = name?.name
        return list
    }
 
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let url = "https://openlibrary.org/books/OL7353617M.json"
        
        networkServise.reguest(url: url) { [weak self] (result) in
            switch result {
            case .success(let searchBook):
                self?.searceBook = searchBook
                self?.table.reloadData()
            case .failure(let error):
                print(error)
            }
          
                
            }
        }
        
    }


