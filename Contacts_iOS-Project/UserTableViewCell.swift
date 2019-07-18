//
//  UserTableViewCell.swift
//  Contacts_iOS-Project
//
//  Created by Kakashi on 17/07/2019.
//  Copyright © 2019 Kannan. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var c_pic: UIImageView!
    @IBOutlet weak var tha: UILabel!
    @IBOutlet weak var mail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUser(user: RandomUser, index: Int) {
        let picUrl = URL(string: user.picture.thumbnail)
        getImage(from: picUrl!)
        
        c_pic.layer.borderWidth = 1
        c_pic.layer.borderColor = UIColor.purple.cgColor
        c_pic.layer.masksToBounds = false
        c_pic.layer.cornerRadius = c_pic.frame.height/2
        c_pic.clipsToBounds = true
        
        if (index%2 == 0) {
        backgroundColor = UIColor.green
        }
        else
        {
            backgroundColor = UIColor.white
        }
    }
    
    func getImage(from url: URL) {
        getData(from: url) {data, response, error in
            guard let data = data, error == nil else {return}
            DispatchQueue.main.async {
                self.c_pic.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }    
}
