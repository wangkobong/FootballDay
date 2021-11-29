//
//  FavoriteListViewController.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2021/11/17.
//

import UIKit

class FavoriteListViewController: UIViewController {
    
    var data = [
        favorite(title: "창골구장", phoneNumber: "010-2323-2233", address: "사랑시 고백구 행복동 삼각산로 13"),
        favorite(title: "도봉산구장", phoneNumber: "010-2323-2233", address: "사랑시 고백구 행복동 삼각산로 13"),
        favorite(title: "불암산구장", phoneNumber: "010-2323-2233", address: "사랑시 고백구 행복동 삼각산로 13")
    ]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.FavoriteTableViewCellcellNibName, bundle: nil), forCellReuseIdentifier: K.FavoriteTableViewCellcellIdentifier)
    }
    
}

extension FavoriteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.FavoriteTableViewCellcellIdentifier, for: indexPath) as! FavoriteTableViewCell
        print("data: \(data)")
        let row = data[indexPath.row]
        cell.nameLabel.text = row.title
        cell.phoneLabel.text = row.phoneNumber
        cell.addressLabel.text = row.address
        
        return cell
    }
    
    
}
