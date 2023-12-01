//
//  ReadNotificationVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 12/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit

class ReadNotificationVC: GaurashtraBaseVC {

    
    @IBOutlet weak var tblReadNotification: UITableView!
    var str : String = "A table view controller displays structured, repeatable information in a vertical list. You use the UITableViewController class in your iOS app to build a table view controller Working with a table view controller also means working with a few important iOS development concepts such as subclassing the delegation design pattern, and re-using views"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblReadNotification.rowHeight = UITableView.automaticDimension
        self.tblReadNotification.estimatedRowHeight = 120
    }
    

    @IBAction func backAction(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
extension ReadNotificationVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblReadNotification.dequeueReusableCell(withIdentifier: ReadNotificationTVC.cellIdentifier(), for: indexPath) as! ReadNotificationTVC
        cell.lblDecs.text = str
        
        return cell
    }
    
    
}
