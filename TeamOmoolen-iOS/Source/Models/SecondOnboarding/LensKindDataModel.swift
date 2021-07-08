//
//  File.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/06/30.
//

import Foundation
import UIKit

struct LensKindDataModel {
    let image: UIImage
    let title: String
    
    init(image: String, title: String) {
        self.image = UIImage(named: image) ?? UIImage()
        self.title = title
    }
}
