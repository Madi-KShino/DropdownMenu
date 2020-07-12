//
//  HomeMenuViewController.swift
//  DropdownMenu
//
//  Created by Madison Shino on 7/7/20.
//  Copyright © 2020 madiShino. All rights reserved.
//

import UIKit

class HomeMenuViewController: UIViewController {

    @IBOutlet var userButton: UIButton!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var usersTableView: UITableView!
    
    let transparentView = UIView()
    var menuIsOpen = false
    var currentUser: User?
    var users: [User] = []
    var height: Int = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUsers()
        removeCurrentUserFromUsersArray()
        height = (users.count + 1) * 50
        
        usersTableView.dataSource = self
        usersTableView.delegate = self
        
        userButton.layer.cornerRadius = userButton.frame.height / 2
        userButton.layer.borderWidth = 2
        userButton.layer.borderColor = #colorLiteral(red: 0.9206742048, green: 0.6506631374, blue: 0.2290223688, alpha: 1)
        
        if currentUser != nil {
            usernameLabel.text = currentUser?.username
            idLabel.text = currentUser?.id
            idLabel.alpha = 0
            idLabel.isHidden = true
        }
        usersTableView.alpha = 0
        usersTableView.frame = CGRect(x: 6, y: 87, width: 200, height: 0)
    }
    
    @IBAction func userButtonTapped(_ sender: Any) {
        addTransparentView()
        toggleMenu()
    }
    
    func toggleMenu() {
        if menuIsOpen {
            menuIsOpen = false
            UIView.animate(withDuration: 0.4, delay: 0, options:  .transitionCrossDissolve, animations: {
                self.idLabel.isHidden = true
                self.idLabel.alpha = 0
            }, completion: nil)
        } else {
            menuIsOpen = true
            UIView.animate(withDuration: 0.4, delay: 0, options:  .transitionCrossDissolve, animations: {
                self.idLabel.isHidden = false
                self.idLabel.alpha = 1
            }, completion: nil)
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
        self.view.addSubview(transparentView)
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        
        usersTableView.layer.cornerRadius = 5
        transparentView.alpha = 0
        
        var tableViewHeight = 0
        if height >= 250 {
            tableViewHeight = 250
        } else {
            tableViewHeight = height
        }
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.usersTableView.frame = CGRect(x: 6, y: 87, width: 200, height: tableViewHeight)
            self.usersTableView.alpha = 1
            self.view.bringSubviewToFront(self.usersTableView)
        }, completion: nil)
    }
    
    @objc func dismissTransparentView() {
        toggleMenu()
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.usersTableView.frame = CGRect(x: 6, y: 87, width: 200, height: 0)
            self.usersTableView.alpha = 0
            self.transparentView.alpha = 0.0
        }, completion: nil)
    }
}

extension HomeMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count >= 1 ? users.count + 1 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        if indexPath.row == users.count || users.count == 0 {
            cell.user = nil
        } else {
            let user = users[indexPath.row]
            cell.user = user
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

