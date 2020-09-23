//
//  PostController.swift
//  Reddit
//
//  Created by LAURA JELENICH on 9/23/20.
//

//https://www.reddit.com/r/funny/.json
import Foundation
import UIKit.UIImage

struct StringConstants {
    fileprivate static let baseURL = "https://www.reddit.com"
    fileprivate static let rEndpoint = "r"
    fileprivate static let funnyEndpoint = "funny"
    fileprivate static let jsonExtension = "json"
}

class PostController {

    static func fetchPosts(completion: @escaping (Result<[Post], PostError>) -> Void) {
        guard let baseURL = URL(string: StringConstants.baseURL) else {return completion(.failure(.invalidURL))}
        let rComponentURL = baseURL.appendingPathComponent(StringConstants.rEndpoint)
        let funnyComponentURL = rComponentURL.appendingPathComponent(StringConstants.funnyEndpoint)
        //The .json is the extension
        let finalURL = funnyComponentURL.appendingPathExtension(StringConstants.jsonExtension)
        //Print the final URL to make sure it's correct!
        print(finalURL)
        
        //Start the data task
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                let secondLevelDictionary = topLevelDictionary.data
                let thridLevelObject = secondLevelDictionary.children
                var postsPlaceHolderArray: [Post] = []
                for object in thridLevelObject {
                    let post = object.data
                    postsPlaceHolderArray.append(post)
                }
                completion(.success(postsPlaceHolderArray))
                
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchThumbnail(for post: Post, completion: @escaping (Result<UIImage, PostError>) -> Void) {
        guard let url = post.thumbnail else { return completion(.failure(.invalidURL))}
        print(url)
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownImageError(error)))
            }
            guard let data = data else { return completion(.failure(.noData)) }
            guard let thumbnailImage = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            completion(.success(thumbnailImage))
        }.resume() 
    }
}
