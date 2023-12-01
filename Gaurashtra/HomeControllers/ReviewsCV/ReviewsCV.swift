//
//  ReviewsCV.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 28/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit

class ReviewsCV: GaurashtraBaseVC {

    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var tblReview: UITableView!
    var reviewList : [Any] = []
    var vcId : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblReview.rowHeight  = UITableView.automaticDimension
        self.tblReview.estimatedRowHeight = 120
    }
    
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        
        if vcId == 1
        {
            self.navigationController?.popViewController(animated: true)
        }else{
             self.dismiss(animated: true) {}
        }
    }
    

}
extension ReviewsCV : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblReview.dequeueReusableCell(withIdentifier: ReviewsTCV.cellIdentifier(), for: indexPath) as! ReviewsTCV
        
        cell.configureCell(withDictData: kSharedInstance.getDictionary(self.reviewList[indexPath.row]), forIndxPath: indexPath)
        
        return cell
        
    }
    
    
}
