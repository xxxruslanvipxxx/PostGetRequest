//
//  Course.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 31.01.24.
//

import Foundation

struct Course: Decodable {
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
}
