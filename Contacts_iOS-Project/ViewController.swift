//
//  ViewController.swift
//  Contacts_iOS-Project
//
//  Created by Kakashi on 17/07/2019.
//  Copyright © 2019 Kannan. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    var results: UserBase?
    var userArray: [RandomUser]?
    var userD: RandomUser?
    
    @IBOutlet weak var abc: UIImageView!
    @IBOutlet var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight=60
        fetchUsers()
    }
    
    func fetchUsers(){
        var request = URLRequest(url: URL(string: "https://randomuser.me/api/?results=50&seed=Veerabhagu_Santhanam")!)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do{
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(UserBase.self, from: data!)
                self.userArray = responseModel.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print("JSON Serialization ERROR: ", error)
            }
            }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? DetailViewController else {
            return
        }
        detailViewController.user = self.userD
    }
    
    func formatName(userName: UserName) -> String {
        return userName.title.capitalized + " " + userName.first.capitalized + " " + userName.last.uppercased()
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "user") as? UserTableViewCell else {
            return UITableViewCell()
        }
        if let user = userArray?[indexPath.row] {
            cell.setUser(user: userArray![indexPath.row], index: indexPath.row)
            let fullName = formatName(userName: user.name)
            cell.tha.text = fullName
            cell.mail.text = user.email
        }
        return cell
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userD = userArray![indexPath.row]
        performSegue(withIdentifier: "showUser", sender: nil)
    }
}
