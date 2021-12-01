//
//  FavoriteListViewController.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2021/11/17.
//

import UIKit
import RealmSwift
import SafariServices

class FavoriteListViewController: UIViewController {
    
    var data = [
        favorite(title: "창골구장", phoneNumber: "010-2323-2233", address: "사랑시 고백구 행복동 삼각산로 13"),
        favorite(title: "도봉산구장", phoneNumber: "010-2323-2233", address: "사랑시 고백구 행복동 삼각산로 13"),
        favorite(title: "불암산구장", phoneNumber: "010-2323-2233", address: "사랑시 고백구 행복동 삼각산로 13")
    ]
    
    var tasks: Results<Ground>!
    let localRealm = try! Realm()
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        
        header.backgroundColor = UIColor(named: "BrandGreen")
        
        let headerLabel = UILabel(frame: header.bounds)
        headerLabel.text = "FAVORITE GROUNDS"
        headerLabel.font = UIFont(name: "thonburi", size: 18)
        headerLabel.textColor = UIColor(named: "BrandWhite")
        headerLabel.textAlignment = .center
        header.addSubview(headerLabel)
        tableView.tableHeaderView = header
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.FavoriteTableViewCellcellNibName, bundle: nil), forCellReuseIdentifier: K.FavoriteTableViewCellcellIdentifier)
        tasks = localRealm.objects(Ground.self)
        print(tasks)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
}

extension FavoriteListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.FavoriteTableViewCellcellIdentifier, for: indexPath) as! FavoriteTableViewCell
        print("data: \(data)")
        let row = tasks[indexPath.row]
        let phone = row.phoneData
        cell.nameLabel.text = row.placeNameData
        cell.addressLabel.text = row.addressData
        if phone != "" {
            cell.phoneLabel.text = row.phoneData
        } else {
            cell.phoneLabel.text = "번호정보없음"
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = tasks[indexPath.row]
        let urlData = row.placeURLData
        let url = NSURL(string: urlData)
        let groundSafariView: SFSafariViewController = SFSafariViewController(url: url! as URL)
        self.present(groundSafariView, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            let taskToDelete = self.tasks[indexPath.row]
            try! self.localRealm.write {
                self.localRealm.delete(taskToDelete)
            }
            
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    
}
