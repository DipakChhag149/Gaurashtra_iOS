//
//  ImageViewController.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 24/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var collectionV: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var imgArr : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pageControl.numberOfPages = self.imgArr.count
        
        
        self.registerNib()
    }
    private func registerNib() -> Void
    {
        let nibCards = UINib(nibName: ProductImageCVC.identifier(), bundle: nil)
        self.collectionV.register(nibCards, forCellWithReuseIdentifier: ProductImageCVC.identifier())
    }
    
    
    
    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
//#MARK: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  
extension ImageViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return imgArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cellCVUpper = collectionView.dequeueReusableCell(withReuseIdentifier: ProductImageCVC.identifier(), for: indexPath) as! ProductImageCVC
        
        cellCVUpper.configureCell(withArrData: self.imgArr, forindxPath: indexPath)
        
  
        return cellCVUpper
    }
    
    
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
       // print("dfdf")
        //        var dictData: Dictionary<String, Any>
        //        dictData = kSharedInstance.getDictionary(arrMallName[indexPath.item])
        //        let strMallId = String.getString(dictData[kCategoryId])
        //        let storyboard = UIStoryboard(name: kSBSlideMenuVC , bundle: nil)
        //        let vc = storyboard.instantiateViewController(withIdentifier: MallNameViewC.storyboardId()) as! MallNameViewC
        //        vc.strMallId = strMallId
        //        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        
        let width = (320.0 * kScreenWidth) / 320
        let hight = (504.0 * kScreenWidth) / 320
        
        return CGSize(width: width, height: hight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        
        
        //top //left //bottom // right
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        // As we are not using the default scrollable feature from the UIScrollView,
        // we can scroll ourself to the center of the focused cell
        if context.nextFocusedIndexPath != nil && !collectionView.isScrollEnabled {
            if let aPath = context.nextFocusedIndexPath {
                collectionView.scrollToItem(at: aPath, at: .centeredHorizontally, animated: true)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        let cellVisible = Int(scrollView.contentOffset.x / kScreenWidth)
        pageControl.currentPage = cellVisible
        
    }
    
}
