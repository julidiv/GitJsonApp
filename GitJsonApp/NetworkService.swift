//
//  NetworkService.swift
//  GitJsonApp
//

//

import Foundation
class NetworkService {
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
        
    }
}
