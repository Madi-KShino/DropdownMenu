//
//  SlideMenuViewController.swift
//  DropdownMenu
//
//  Created by Madison Shino on 7/12/20.
//  Copyright © 2020 madiShino. All rights reserved.
//

import UIKit

class SlideMenuViewController: UIViewController {

    @IBOutlet var userButton: UIButton!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var usersTableView: UITableView!
    @IBOutlet var slideView: UIView!
    
    let transparentView = UIView()
    let dismissArrow = UIButton()
    var menuIsOpen = false
    var currentUser: User?
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUsers()
        removeCurrentUserFromUsersArray()
        
        usersTableView.dataSource = self
        usersTableView.delegate = self
        
        userButton.layer.cornerRadius = userButton.frame.height / 2
        userButton.layer.borderWidth = 2
        userButton.layer.borderColor = #colorLiteral(red: 0.9206742048, green: 0.6506631374, blue: 0.2290223688, alpha: 1)
        
        if currentUser != nil {
            usernameLabel.text = currentUser!.username + " - " + currentUser!.id
        }
        
        slideView.alpha = 0
        slideView.frame = CGRect(x: 0, y: 0, width: 0, height: view.frame.height)
        usersTableView.frame = CGRect(x: 5, y: 50, width: 0, height: view.frame.height)
        usersTableView.tableFooterView = UIView()
        
        dismissArrow.setImage(#imageLiteral(resourceName: "leftArrow"), for: .normal)
        dismissArrow.setTitleColor(#colorLiteral(red: 0.9206742048, green: 0.6506631374, blue: 0.2290223688, alpha: 1), for: .normal)
        dismissArrow.tintColor = #colorLiteral(red: 0.9206742048, green: 0.6506631374, blue: 0.2290223688, alpha: 1)
        
    }
    
    @IBAction func userButtonTapped(_ sender: Any) {
        addTransparentView()
        toggleMenu()
    }
    
    func toggleMenu() {
        if menuIsOpen {
            menuIsOpen = false
        } else {
            menuIsOpen = true
        }
    }
    
    func setUsers() {
        let userOne = User(username: "lbecker", id: "demoSage300", image: nil)
        let userTwo = User(username: "pres", id: "aloha1", image: nil)
        let userThree = User(username: "fgalloway", id: "demoSage300", image: nil)
        let userFour = User(username: "madi", id: "demoSage300", image: #imageLiteral(resourceName: "madi"))
        users = [userOne, userTwo, userThree, userFour]
        currentUser = userOne
    }
    
    func removeCurrentUserFromUsersArray() {
        var index = 0
        for user in users {
            if user.username == currentUser?.username {
                users.remove(at: index)
                return
            }
            index += 1
        }
    }
    
    func addTransparentView() {
        transparentView.frame = self.view.frame
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        self.view.addSubview(transparentView)
        self.view.addSubview(dismissArrow)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        
        slideView.layer.cornerRadius = 5
        transparentView.alpha = 0
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.usersTableView.frame = CGRect(x: 5, y: 50, width: 295, height: self.view.frame.height)
            self.slideView.frame = CGRect(x: 0, y: 0, width: 300, height: self.view.frame.height)
            self.dismissArrow.frame = CGRect(x: 305, y: self.view.frame.height / 2, width: 30, height: 30)
            self.slideView.alpha = 1
            self.view.bringSubviewToFront(self.slideView)
            self.view.bringSubviewToFront(self.usersTableView)
        }, completion: nil)
    }
    
    @objc func dismissTransparentView() {
        toggleMenu()
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.usersTableView.frame = CGRect(x: 5, y: 50, width: 0, height: self.view.frame.height)
            self.slideView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.frame.height)
            self.dismissArrow.frame = CGRect(x: -30, y: self.view.frame.height / 2, width: 30, height: 30)
            self.slideView.alpha = 0
            self.transparentView.alpha = 0.0
        }, completion: nil)
    }
}

extension SlideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width, height: headerView.frame.height)
        label.textColor = #colorLiteral(red: 0.9206742048, green: 0.6506631374, blue: 0.2290223688, alpha: 0.8699108715)
        headerView.addSubview(label)
        if section == 0 {
            label.text = "Current User"
        } else {
            label.text = "Available Users"
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return users.count >= 1 ? users.count + 1 : 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        if indexPath.section == 1 && indexPath.row == users.count || users.count == 0 {
            cell.user = nil
        } else if indexPath.section == 1 {
            let user = users[indexPath.row]
            cell.user = user
        } else {
            cell.user = currentUser
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > users.count {
            print("Add User")
        } else {
            print("Log in user")
        }
    }
}

