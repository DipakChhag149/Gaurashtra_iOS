//
//  ReadNotificationVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 29/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit

class ReadNotificationVC: GaurashtraBaseVC {

    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var tblReadNotification: UITableView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    var dictData : Dictionary<String,Any> = ["":""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // print(dictData)
        
        self.lblTitle.text = String.getString(dictData["notification_title"])
        
        self.tblReadNotification.rowHeight          = UITableView.automaticDimension
        self.tblReadNotification.estimatedRowHeight = 100
        
    }

    @IBAction func backAction(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true) { }
       
    }
    
}
extension ReadNotificationVC : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblReadNotification.dequeueReusableCell(withIdentifier: ReadNotificationTVC.cellIdentifier()) as! ReadNotificationTVC
        
        cell.lblDecs.text = String.getString(dictData["notification_content"])
        
        return cell
    }
  
}
