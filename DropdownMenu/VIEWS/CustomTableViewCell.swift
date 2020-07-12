//
//  CustomTableViewCell.swift
//  DropdownMenu
//
//  Created by Madison Shino on 7/7/20.
//  Copyright © 2020 madiShino. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var userImage: UIButton!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userIdLabel: UILabel!
    
    var user: User? {
        didSet {
            setUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUI() {
        userImage.layer.cornerRadius = userImage.frame.height / 2
        userImage.layer.borderWidth = 2
        userImage.layer.borderColor = #colorLiteral(red: 0.9206742048, green: 0.6506631374, blue: 0.2290223688, alpha: 1)
        self.backgroundColor = UIColor.clear
        if user != nil {
            userNameLabel.text = user?.username
            userIdLabel.text = user?.id
            if user?.image != nil {
                userImage.setImage(user?.image, for: .normal)
            } else {
                userImage.setImage(#imageLiteral(resourceName: "userIcon"), for: .normal)
            }
        } else {
            userNameLabel.text = "Add User"
            userIdLabel.text = ""
            userIdLabel.isHidden = true
            userImage.setImage(#imageLiteral(resourceName: "newUser"), for: .normal)
        }
    }
}
