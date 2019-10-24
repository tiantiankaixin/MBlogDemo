//
//  MMenuViewController.swift
//  MAlgorithmDemo
//
//  Created by mal on 2019/10/17.
//  Copyright © 2019 mal. All rights reserved.
//

import UIKit

let KCellIdentifier = "cellIdentifier"


class MMenuItem {
    
    var itemTitle:String = ""
    var itemClass:UIViewController.Type?
    class func ItemWith(title:String, itemClass:UIViewController.Type) -> MMenuItem{
        
        let item = MMenuItem()
        item.itemTitle = title
        item.itemClass = itemClass
        return item
    }
}

class MMenuViewController: UITableViewController {

    var dataSource:[MMenuItem] = [MMenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: KCellIdentifier)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return self.dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: KCellIdentifier)!
        let item = self.dataSource[indexPath.row]
        cell.textLabel?.text = item.itemTitle
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = self.dataSource[indexPath.row]
        
        if let vc = item.itemClass?.init(){

            if let navi = self.navigationController{

                vc.view.backgroundColor = UIColor.white
                navi.pushViewController(vc, animated: true)
            }
        }
    }
    
    func mAddItem(item:MMenuItem){
        
        self.dataSource.append(item)
    }
}
