//
//  User.swift
//  DropdownMenu
//
//  Created by Madison Shino on 7/7/20.
//  Copyright © 2020 madiShino. All rights reserved.
//

import Foundation
import UIKit

class User {
    var username: String
    var id: String
    var image: UIImage?
    
    init(username: String, id: String, image: UIImage?) {
        self.username = username
        self.id = id
        self.image = image
    }
}
