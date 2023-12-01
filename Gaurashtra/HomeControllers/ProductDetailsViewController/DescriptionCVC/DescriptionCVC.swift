//
//  DescriptionCVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 26/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit
import SwiftSoup
import WebKit

class DescriptionCVC: UICollectionViewCell {

   
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var kitWeb: WKWebView!
    var document: Document = Document.init("")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureProdDecsCell(withStrData stringData : String , forIndxPath indxPath : IndexPath)
    {
        
        //String productDescText = Jsoup.parse("<html>" + productdetailsDTO.getResult().getProduct().getData().getProductDescription() + "</html>").text();
    
        do {
            let html: String = stringData
            let doc: Document = try SwiftSoup.parse(html)
            
            let text: String = try doc.body()!.text() // "An example link"
            
          //  print(text)
            
             let doc2 = "<font face='System' size='8' color= 'black'>" + text
             self.webView.loadHTMLString(doc2, baseURL: nil)
            
        } catch Exception.Error(let type, let message) {
          //  print(message)
        } catch {
           // print("error")
        }
     
    }

    
//    func downloadHTML() {
//        // url string to URL
//        guard let url = URL(string: urlTextField.text ?? "") else {
//            // an error occurred
//            UIAlertController.showAlert("Error: \(urlTextField.text ?? "") doesn't seem to be a valid URL", self)
//            return
//        }
//
//        do {
//            // content of url
//            let html = try String.init(contentsOf: url)
//            // parse it into a Document
//            document = try SwiftSoup.parse(html)
//            // parse css query
//            parse()
//        } catch let error {
//            // an error occurred
//            UIAlertController.showAlert("Error: \(error)", self)
//        }
//
//    }
//
//    //Parse CSS selector
//    func parse() {
//        do {
//            //empty old items
//            items = []
//            // firn css selector
//            let elements: Elements = try document.select(cssTextField.text ?? "")
//            //transform it into a local object (Item)
//            for element in elements {
//                let text = try element.text()
//                let html = try element.outerHtml()
//                items.append(Item(text: text, html: html))
//            }
//
//        } catch let error {
//            UIAlertController.showAlert("Error: \(error)", self)
//        }
//
//
//    }
    
}
