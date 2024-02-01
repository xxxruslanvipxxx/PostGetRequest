//
//  Course.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 31.01.24.
//

import Foundation

struct Course: Decodable {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
    let number_of_lessons: Int
    let number_of_tests: Int
}
