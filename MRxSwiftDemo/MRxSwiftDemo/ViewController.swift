//
//  ViewController.swift
//  MRxSwiftDemo
//
//  Created by mal on 2020/6/10.
//  Copyright © 2020 mal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }

    func setUpTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.mj_header = AIRefreshHeader(refreshingBlock: { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                if let ws = self {
                    ws.tableView.mj_header?.endRefreshing()
                }
            }
        })
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell.textLabel?.text = "测试\(indexPath.row + 1)"
            return cell
        }
        return UITableViewCell()
    }
}

