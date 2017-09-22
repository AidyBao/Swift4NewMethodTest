//
//  MQSearchViewController.swift
//  Test
//
//  Created by 120v on 2017/9/21.
//  Copyright © 2017年 MQ. All rights reserved.
//

import UIKit

class MQSearchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchBarDelegate {
  
    
    static let cellIdentifer = "myCell"
    var searchController: UISearchController?
    
    var tableView: UITableView?
    var itemArray : Array = [String]()
    var tempsArray : Array = [String]()

    func initData()
    {
        for i in 0 ..< 30 {
            let str = "夜如何其\(i)……………………"
            itemArray.append(str)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        self.navigationItem.title = "发现"
        self.definesPresentationContext = true
        self.initData()
        self.initSubView()
    }
    
    func initSubView() {
        self.tableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - (self.navigationController?.navigationBar.frame.height)! - UIApplication.shared.statusBarFrame.height), style: UITableViewStyle.plain)
        self.tableView?.backgroundColor = UIColor.clear
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        let aaaView = UIView()
        aaaView.backgroundColor = UIColor.white
        self.tableView?.tableFooterView = aaaView
        self.view.addSubview(self.tableView!)
        
        let resultVC = UINavigationController(rootViewController: MQSearchResultViewController())
        self.searchController = UISearchController(searchResultsController: resultVC)
        self.searchController?.searchResultsUpdater = self
        self.searchController?.searchBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        self.searchController?.searchBar.delegate = self
        
        self.tableView?.tableHeaderView = self.searchController?.searchBar
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
        cell?.backgroundColor = UIColor.clear
        return cell!
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        //do somthing...
    }
    
    
    //mark - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        //
        let nav_VC = self.searchController?.searchResultsController as! UINavigationController
        let resultVC = nav_VC.topViewController as! MQSearchResultViewController
        self.searchContentForText(searchText: (self.searchController?.searchBar.text)!)
        resultVC.itemArray = self.tempsArray
        resultVC.tableView?.reloadData()
    }
    
    func searchContentForText(searchText: String)
    {
        self.tempsArray.removeAll()
        for str in self.itemArray {
            //
            if str.components(separatedBy: searchText).count > 1 {
                self.tempsArray.append(str)
            }
        }
    }
}

