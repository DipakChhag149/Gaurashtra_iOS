//
//  SignUpTVC.swift
//  Gaurashtra
//
//  Created by abc on 24/09/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class SignUpTVC: UITableViewCell {

     private var getTextField : GetTextField = { UITextField in }
    
    @IBOutlet weak var txtField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        case SignUpCellType.firstname.rawValue:
            setPlaceholderOnTextField(withPlaceholder: SignUpCellType.firstname.getPlaceHolder(), withText: String.getString(dictData[kFirstName]), andSecureTextEntryStatus: false)
 
            txtField.autocapitalizationType = .words

            
        case SignUpCellType.lastname.rawValue:
            setPlaceholderOnTextField(withPlaceholder: SignUpCellType.lastname.getPlaceHolder(), withText: String.getString(dictData[kLastName]), andSecureTextEntryStatus: false)
            
            txtField.autocapitalizationType = .words

            
            
        case SignUpCellType.phone.rawValue:
            setPlaceholderOnTextField(withPlaceholder: SignUpCellType.phone.getPlaceHolder(), withText: String.getString(dictData[kTelephone]), andSecureTextEntryStatus: false)
             self.txtField.keyboardType = UIKeyboardType.phonePad
            

            
            
        case SignUpCellType.email.rawValue:
            setPlaceholderOnTextField(withPlaceholder: SignUpCellType.email.getPlaceHolder(), withText: String.getString(dictData[kEmail]), andSecureTextEntryStatus: false)
            self.txtField.keyboardType = UIKeyboardType.emailAddress
            

            
            
        case SignUpCellType.password.rawValue:
            setPlaceholderOnTextField(withPlaceholder: SignUpCellType.password.getPlaceHolder(), withText: String.getString(dictData[kPassword]), andSecureTextEntryStatus: false)

             txtField.isSecureTextEntry = true
        
            
            
        case SignUpCellType.confirmPassword.rawValue:
            setPlaceholderOnTextField(withPlaceholder: SignUpCellType.confirmPassword.getPlaceHolder(), withText: String.getString(dictData[kConPassword]), andSecureTextEntryStatus: false)
            

            
            txtField.isSecureTextEntry = true
            
            
        default:
            break
        }
        getTextField = textField
    }
    func setPlaceholderOnTextField(withPlaceholder placeholder: String, withText strText: String, andSecureTextEntryStatus isSecureText: Bool)
    {
        txtField.attributedPlaceholder = NSMutableAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
       
    }

}
//MARK:- ----------UITextField Delegate Methods----------
extension SignUpTVC: UITextFieldDelegate
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
