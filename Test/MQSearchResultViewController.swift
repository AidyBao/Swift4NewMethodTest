//
//  MQSearchResultViewController.swift
//  Test
//
//  Created by 120v on 2017/9/21.
//  Copyright © 2017年 MQ. All rights reserved.
//

import UIKit

class MQSearchResultViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    static let cellIdentifer = "myCell"
    var tableView: UITableView?
    var itemArray : Array = [String]()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "搜索"
        
        self.view.backgroundColor = UIColor.purple
        
        self.tableView?.backgroundColor = UIColor.orange
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.red

        self.intiSubView()
    }

    func intiSubView() {
        self.tableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: UITableViewStyle.plain)
        self.tableView?.backgroundColor = UIColor.clear
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.view.addSubview(self.tableView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: MQSearchViewController.cellIdentifer)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: MQSearchViewController.cellIdentifer)
        }
        
        cell?.textLabel?.text = itemArray[indexPath.row]
        cell?.textLabel?.textColor = UIColor.black
        cell?.backgroundColor = UIColor.gray
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        //do somthing...
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}
