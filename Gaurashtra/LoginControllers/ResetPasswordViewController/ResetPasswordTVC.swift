//
//  ResetPasswordTVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 07/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class ResetPasswordTVC: UITableViewCell {

     private var getTextField : GetTextField = { UITextField in }
    @IBOutlet weak var txtField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.txtField.delegate = self
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
        case ResetPassworCellType.otp.rawValue:
            setPlaceholderOnTextField(withPlaceholder: ResetPassworCellType.otp.getPlaceHolder(), withText: String.getString(dictData[kOtp]), andSecureTextEntryStatus: false)
            self.txtField.keyboardType = UIKeyboardType.phonePad
           // self.btnView.isHidden = true
            // self.self.securePasswordImgV.isHidden = true
            
            
        case ResetPassworCellType.password.rawValue:
            setPlaceholderOnTextField(withPlaceholder: ResetPassworCellType.password.getPlaceHolder(), withText: String.getString(dictData[kPassword]), andSecureTextEntryStatus: false)
            txtField.isSecureTextEntry = true
            
        case ResetPassworCellType.confirmPassword.rawValue:
            setPlaceholderOnTextField(withPlaceholder: ResetPassworCellType.confirmPassword.getPlaceHolder(), withText: String.getString(dictData[kConPassword]), andSecureTextEntryStatus: false)
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
extension ResetPasswordTVC: UITextFieldDelegate
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
