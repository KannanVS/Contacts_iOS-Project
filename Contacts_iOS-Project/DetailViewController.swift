//
//  DetailViewController.swift
//  Contacts_iOS-Project
//
//  Created by Kakashi on 18/07/2019.
//  Copyright © 2019 Kannan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var u_name: UILabel!
    
    @IBOutlet weak var pics: UIImageView!
    @IBOutlet weak var street: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var cell: UILabel!
    @IBOutlet weak var city: UILabel!
    
    var user: RandomUser?
    override func viewDidLoad() {
        super.viewDidLoad()
         if let user = user {
            let picUrl = URL(string: user.picture.large)
            getImage(from: picUrl!)
            let fullName = formatName(userName: user.name)
            u_name.text = fullName
            street.text = user.location.street.capitalized
            city.text = user.location.city.capitalized
            email.text = user.email
            phone.text = user.phone
            cell.text = user.cell
        }
    }
    
    func formatName(userName: UserName) -> String {
        return userName.title.capitalized + " " + userName.first.capitalized + " " + userName.last.uppercased()
    }
    
    func getImage(from url: URL) {
        getData(from: url) {data, response, error in
            guard let data = data, error == nil else {return}
            DispatchQueue.main.async {
                self.pics.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
