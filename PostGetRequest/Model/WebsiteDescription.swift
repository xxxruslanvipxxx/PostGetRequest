//
//  WebsiteDescription.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 1.02.24.
//

import Foundation

struct WebsiteDescription: Decodable {
    let websiteName: String
    let websiteDescription: String
    let courses: [Course]
}
