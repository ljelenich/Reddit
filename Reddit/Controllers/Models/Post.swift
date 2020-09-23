//
//  Post.swift
//  Reddit
//
//  Created by LAURA JELENICH on 9/23/20.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let data: SecondLevelDictionary
}

struct SecondLevelDictionary: Decodable {
    let children: [ThirdLevelObject]
}

struct ThirdLevelObject: Decodable {
    let data: Post
}

struct Post: Decodable {
    let title: String
    let ups: Int
    let thumbnail: URL?
}
