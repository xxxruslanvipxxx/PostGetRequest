//
//  ImageProperties.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 6.02.24.
//

import UIKit

struct ImageProperties {
    
    let key: String
    let data: Data
    
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        guard let data = image.pngData() else { return nil }
        self.data = data
    }
}
