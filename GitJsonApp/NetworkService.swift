//
//  NetworkService.swift
//  GitJsonApp
//

//

import Foundation
import Alamofire
class NetworkService {
    
    enum Link: String {
        
        case url = "https://openlibrary.org/books/OL7353617M.json"
    }
    
    func reguest(url: String, completion: @escaping (Result<SearchBook, Error>) -> Void) {
        guard let urlString = URL(string: url) else { return }
        URLSession.shared.dataTask(with: urlString) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Happend error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let books = try JSONDecoder().decode(SearchBook.self, from: data)
                    completion(.success(books))
                } catch let jsonError {
                    print("Happend json error",jsonError)
                    completion(.failure(jsonError))
                    
                }
                
            }
            
        }.resume()
        
        func fetchBooks() {
            AF.request(Link.url.rawValue)
                .validate()
                .responseJSON { dataResponse in
                    switch dataResponse.result {
                    case .success( let value) :
                        let books = Books.getBooks(from: value)
                        completion(.success(books))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                    
                    
                }
        }
    }
}
