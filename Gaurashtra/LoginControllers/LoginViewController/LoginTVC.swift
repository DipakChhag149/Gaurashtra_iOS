//
//  LoginTVC.swift
//  Gaurashtra
//
//  Created by abc on 24/09/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit
typealias GetTextField = (_ textfield: UITextField) -> ()


class LoginTVC: UITableViewCell {
    
    @IBOutlet weak var txtField: UITextField!
    
    private var getTextField : GetTextField = { UITextField in }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
      
       
//       self.txtfi.text = loginPassword
        
        
        
        
        
        txtField.delegate = self
        getTextField(txtField)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(withData dictData: Dictionary<String, Any>, forIndexPath indexPath: IndexPath, getTextField textField: @escaping GetTextField)
    {
        txtField.tag = indexPath.row
        
        switch indexPath.row
        {
        case LoginCellType.emailId.rawValue:
            setPlaceholderOnTextField(withPlaceholder: LoginCellType.emailId.getPlaceHolder(), withText: String.getString(dictData[kUserPhone]), andSecureTextEntryStatus: false)
            self.txtField.keyboardType = UIKeyboardType.emailAddress
            let loginEmail = String.getString(kSharedUserDefaults.string(forKey: "LoginEmail"))
                         
            self.txtField.text    = loginEmail
//            self.txtField.attributedPlaceholder = NSAttributedString(string: "Email ID",
//                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            
        //    self.btnView.isHidden = true
            
            
        case LoginCellType.password.rawValue:
            setPlaceholderOnTextField(withPlaceholder: LoginCellType.password.getPlaceHolder(), withText: String.getString(dictData[kPassword]), andSecureTextEntryStatus: false)
           
//            self.txtField.attributedPlaceholder = NSAttributedString(string: "Password",
//                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            
            
            txtField.isSecureTextEntry = true
            
            
        default:
            break
        }
        getTextField = textField
    }
    func setPlaceholderOnTextField(withPlaceholder placeholder: String, withText strText: String, andSecureTextEntryStatus isSecureText: Bool)
    {
        txtField.attributedPlaceholder = NSMutableAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        //  txtField.isSecureTextEntry = isSecureText
        //txtField.text = strText
    }

}
//MARK:- ----------UITextField Delegate Methods----------
extension LoginTVC: UITextFieldDelegate
{
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        getTextField(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}
