//
//  PostError.swift
//  Reddit
//
//  Created by LAURA JELENICH on 9/23/20.
//

import Foundation

enum PostError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case thrownImageError(Error)
    case unableToDecode
}
