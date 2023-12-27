//
//  ToyConstant.swift
//  Toy
//
//  Created by Fluper on 10/08/17.
//  Copyright © 2017 Fluper. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

import UIKit


//MARK: ---------Color Constants---------
let kWhiteColor               = UIColor.white
let APP_THEME_UP = UIColor.init(red: 252/255, green: 184/255, blue: 37/255, alpha: 1)
let APP_THEME_DOWN = UIColor.init(red: 251/255, green: 136/255, blue: 51/255, alpha: 1)
let LOCATION_COLOR = UIColor.init(red: 35/255, green: 187/255, blue: 212/255, alpha: 1)
let APP_BACKGROUND_THEME = UIColor.init(red: 237/255, green: 238/255, blue: 238/255, alpha: 1)
let BUTTON_BACKGROUND_THEME = UIColor.init(red: 226/255, green: 1888/255, blue: 157/255, alpha: 1)
let BUTTON_BACKGROUND_THEME1 = UIColor.init(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1)


//MARK: ---------UIFont Constants---------


//MARK: ---------Method Constants---------
let kSharedAppDelegate          = UIApplication.shared.delegate as! AppDelegate
let kSharedInstance             = SharedClass.sharedInstance
let kSharedUserDefaults         = UserDefaults.standard
let kScreenWidth                = UIScreen.main.bounds.size.width
let kScreenHeight               = UIScreen.main.bounds.size.height


func isInternetAvailable() -> Bool
{
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    return (isReachable && !needsConnection)
}




func print_debug(items: Any)
{
  print(items)
}

func print_debug_fake(items: Any)
{
  
}

enum LoginCellType: Int
{
    case emailId = 0
    case password
    static let count = 2
    
    func getPlaceHolder() -> String
    {
        switch self
        {
        case .emailId:
            return "EmailId"
        
        case .password:
            return "Password"
       
            
        default:
            return ""
        }
    }
}





enum ResetPassworCellType: Int
{
    case otp = 0
    case password
    case confirmPassword
   
    static let count = 3
    
    func getPlaceHolder() -> String
    {
        switch self
        {
     
            
        case .otp:
            return "Enter OTP"
            
        case .password:
            return "Enter New Password"
        case .confirmPassword:
            return "Enter Confirm Password"
            
        default:
            return ""
        }
    }
}


enum SupermarketHomeCellType: Int
{
    case AboutSupermarket = 0

    static let count = 1

}
enum HomeOptions: Int
{
    
    case first = 0
    case topSelling
    case otherServices
    case bestOffer
    case banner2
    case videoBanner
    case bestProduct
    case banner3
    case recentlyViewed
    case shopByBrand
    case doubleBanner
    case recommendedProd
    case lastBanner
    
    
    static let count = 13
    
   
    
}



enum SideMenuOptions: Int
{
    
    case home = 0
    case aboutUs
    case contactUs
    case termAndConditions
    case returnPolicy
    case cancellationPolicy
    case faq
   
    
    static let count = 7
    
//    static func getCellNameAndImage(forIndexPath indexPath: IndexPath) -> (String, UIImage)
//    {
//        switch indexPath.row
//        {
//
//        case SideMenuOptions.home.rawValue:
//            return ("Home",#imageLiteral(resourceName: "homeGray"))
//        case SideMenuOptions.shareApp.rawValue:
//            return ("Share App",#imageLiteral(resourceName: "share"))
//
//        case SideMenuOptions.supports.rawValue:
//            return ("Supports",#imageLiteral(resourceName: "suports"))
//
//        default:
//            return ("",UIImage())
//        }
//    }
  
}

//#MARK:-------UserSideMenuOptions---------------

//MARK: ---------Enums---------



enum SellerCellType: Int
{
    case firstName = 0
    case lastName
    case mobile
    case emailAddress
    case city
    case locality
    
    static let count = 6
    
    func getPlaceHolder() -> String
    {
        switch self
        {
        case .firstName:
            return "First Name"
        case .lastName:
            return "Last Name"
        case .mobile:
            return "Mobile No."
        case .emailAddress:
            return "Email Address"
        case .city:
            return "City"
        case .locality:
            return "Locality"
        
        default:
            return ""
        }
    }
}


enum ProfileCellType: Int
{
    case userName = 0
    case emailAddress
    case phoneNo
    case address
   
    static let count = 4
    
    func getPlaceHolder() -> String
    {
        switch self
        {
        case .userName:
            return "Username"
         
            
      
      
        case .emailAddress:
      
            return "Email Address"
            
            
            
        case .phoneNo:
            return "PhoneNo"
            
            
        case .address:
            return "Address"
      
        default:
            return ""
        }
    }
}

enum SignUpCellType: Int
{

    case firstname = 0
    case lastname
    case phone
    case email
    case password
    case confirmPassword

    static let count = 6

    func getPlaceHolder() -> String
    {
        switch self
        {
       
        case .firstname:
            return "First Name"
            
        case .lastname:
            return "Last Name"
        case .phone:
            
            return "Phone"
   
        case .email:
            
            return "Email"
            
        case .password:
         
            return "Password"
        case .confirmPassword:
            return "Confirm Password"
        default:
            return ""
        }
    }
}


enum ChangePasswordCellType: Int
{
    
    case oldPassword = 0
    case newPassword
    case confirmPassword
   
    
    static let count = 3
    
    func getPlaceHolder() -> String
    {
        switch self
        {
            
        case .oldPassword:
            return "Old Password"
            
        case .newPassword:
            return "New Password"
      
        case .confirmPassword:
            return "Confirm Password"
        default:
            return ""
        }
    }
}



enum VehicleInfoCellType: Int
{
    case vehicleNumber = 0
    case vehicleModel
    case vehicleMake
    case vehicleType
    case vehicleCategory
    case vehicleCapacity
    case registrationExpiry
    
    static let count = 7
    
    func getPlaceHolder() -> String
    {
        switch self
        {
        case .vehicleNumber:
            return "Vehicle Number"
        case .vehicleModel:
            return "Vehicle Model"
        case .vehicleMake:
            return "Vehicle Make"
        case .vehicleType:
            return "Vehicle Type"
        case .vehicleCategory:
            return "Vehicle Category"
        case .vehicleCapacity:
            return "Vehicle Capacity"
        case .registrationExpiry:
            return "Registration Expiry"
       
        default:
            return ""
        }
    }
}


enum DriverInfoCellType: Int
{
    case mobileNumber = 0
    case firstName
    case lastName
    case addressOne
    case addressTwo
    case country
    case state
    case city
    case zipcode
    case emailAddress
    
    static let count = 10
    
    func getPlaceHolder() -> String
    {
        switch self
        {
        case .mobileNumber:
            return "Mobile Number"
        case .firstName:
            return "First Name"
        case .lastName:
            return "Last Name"
        case .addressOne:
            return "Address Line 1"
        case .addressTwo:
            return "Address Line 2"
        case .country:
            return "Country"
        case .state:
            return "State"
        case .city:
            return "City"
        case .zipcode:
            return "Zipcode"
        case .emailAddress:
            return "Email Address"
        default:
            return ""
        }
    }
}

enum DriverSignUpCellType: Int
{
    case mobileNumber = 0
    case firstName
    case lastName
    case addressOne
    case addressTwo
    case country
    case state
    case city
    case zipcode
    case emailAddress
    
    static let count = 10
    
    func getPlaceHolder() -> String
    {
        switch self
        {
        case .mobileNumber:
            return "Mobile Number"
        case .firstName:
            return "First Name"
        case .lastName:
            return "Last Name"
        case .addressOne:
            return "Address Line 1"
        case .addressTwo:
            return "Address Line 2"
        case .country:
            return "Country"
        case .state:
            return "State"
        case .city:
            return "City"
        case .zipcode:
            return "Zipcode"
        case .emailAddress:
            return "Email Address"
        default:
            return ""
        }
    }
}

enum AddressVCCellType: Int
{
    case fullName = 0
    case phoneNo
    case nickName
    case city
    case houseNumber
    case area
    case pincode
    case streetName
    case landmark
    
    static let count = 9
    func getPlaceHolder() -> String
    {
        switch self
        {
            
            
        case .fullName:
            return "Full Name"
        case .phoneNo:
            return "Phone No"
        case .nickName:
           return "Nickname, e.g Home/office"
        case .city:
            return "City"
        case .houseNumber:
            return "House no"
        case .area:
            return "Area"
        case .pincode:
            return " Pincode"
        case .streetName:
            return "Street Name(optional)"
        case .landmark:
            return "Landmark(Optional)"
        default:
            return ""
        }
    }
}

enum SuperMarketSignUpCellType: Int
{
 
    
  case email = 0
  case superMarketName
  case superMarketAddress
  case password
  case confirmPassword
    
  static let count = 5
  func getPlaceHolder() -> String
  {
    switch self
    {
   
   
    case .email:
      return "Email Id"
    case .superMarketName:
        return "SuperMarket Name"
    case .superMarketAddress:
        return "SuperMarket Address"
    case .password:
      return "Password"
    case .confirmPassword:
      return "Confirm Password"
    default:
      return ""
    }
  }
}
enum UserLoginCellType: Int
{
  case email = 0
  case password
  
  static let count = 2
  
  func getPlaceHolder() -> String
  {
    switch self
    {
    case .email:
      return "Email Address"
    case .password:
      return "Password"
    default:
      return ""
    }
  }
}
enum SuperMarketLoginCellType: Int
{
    case email = 0
    case password
    
    static let count = 2
    
    func getPlaceHolder() -> String
    {
        switch self
        {
        case .email:
            return "Email Address"
        case .password:
            return "Password"
        default:
            return ""
        }
    }
}

enum CityPermitCellType: Int
{
    case permitType = 0
    case vehiclePermitNo
    case vehiclePermitExpiryBtn
    case cabNo
    case driverPermitNo
    case driverPermitExpiryBtn
    case driverClassificatonBtn
    case permitIssuingAuthority
    case country
    case state
    case city
    case flageDropRate
    case perMileKmRate
    case nameOfFleet
    case fleetPhoneContact
    case commercialInsurance
    case commercialInsuranceExpiryBtn

    static let count = 17
    
    func getPlaceHolder() -> String
    {
        switch self
        {
        case .permitType:
            return "Permit Type"
        case .vehiclePermitNo:
            return "Vehicle Permit No."
        case .cabNo:
            return "Cab No."
        case .driverPermitNo:
            return "Driver Permit No."
        case .permitIssuingAuthority:
            return "Permit Issuing Authority"
        case .country:
            return "Country"
        case .state:
            return "State"
        case .city:
            return "City"

        case .flageDropRate:
            return "Flage Drop Rate"

        case .perMileKmRate:
            return "Per Mile Rate"

        case .nameOfFleet:
            return "Name Of Fleet"
        case .fleetPhoneContact:
                return "Fleet Phone"
        case .commercialInsurance:
            return "Commercial Insurance"


        default:
            return ""
        }
    }
}




//enum CityPermitCellType: Int
//{
//    case permitType = 0
//    case vehiclePermitNo
//    case cabNo
//    case driverPermitNo
//    case permitIssuingAuthority
//    case country
//    case state
//    case city
//    case flageDropRate
//    case perMileKmRate
//    case nameOfFleet
//    case fleetPhoneContact
//    case commercialInsurance
//    case vehiclePermitExpiryBtn
//    case driverPermitExpiryBtn
//    case driverClassificatonBtn
//    case commercialInsuranceExpiryBtn
//
//    static let count = 17
//
//    func getPlaceHolder() -> String
//    {
//        switch self
//        {
//        case .permitType:
//            return "Permit Type"
//        case .vehiclePermitNo:
//            return "Vehicle Permit No."
//        case .cabNo:
//            return "Cab No."
//        case .driverPermitNo:
//            return "Driver Permit No."
//        case .permitIssuingAuthority:
//            return "Permit Issuing Authority"
//        case .country:
//            return "Country"
//        case .state:
//            return "State"
//        case .city:
//            return "City"
//
//        case .flageDropRate:
//            return "Flage Drop Rate"
//
//        case .perMileKmRate:
//            return "Per Mile Rate"
//
//        case .nameOfFleet:
//            return "Name Of Fleet"
//        case .fleetPhoneContact:
//            return "Fleet Phone"
//        case .commercialInsurance:
//            return "Commercial Insurance"
//
//
//        default:
//            return ""
//        }
//    }
//}
//
//




enum BankCardCellType: Int
{
    case nameOfBank = 0
    case accountHolderName
    case bankAccountNumber
    case reEnterBankAccountNumber
    case bankRountingNumber
    case reEnterBankRountingNumber
    case branchNo
   
    
    static let count = 7
    
    func getPlaceHolder() -> String
    {
        switch self
        {
        case .nameOfBank:
            return "Name of Bank"
        case .accountHolderName:
            return "Account Holder's Name"
        case .bankAccountNumber:
            return "Bank Account Number"
        case .reEnterBankAccountNumber:
            return "Re-Enter Bank Account Number"
        case .bankRountingNumber:
            return "Bank Rounting No."
        case .reEnterBankRountingNumber:
            return "Re-EnterBank Rounting No."
        case .branchNo:
            return "Branch No."
        
        default:
            return ""
        }
    }
}



enum ForgotPassworCellType: Int
{
    case email = 0
    case button
    static let count = 2
    
    func getPlaceHolder() -> String
    {
        switch self
        {
        case .email:
            return "Email Address"
        
        default:
            return ""
        }
    }
}

//MARK: ---------String---------


//
//
//
//         str_SupermarketLogo


let kStr_SupermarketId             = "str_SupermarketId"
let kStr_SupermarketName           = "str_SupermarketName"
let kStr_SupermarketDistance       = "str_SupermarketDistance"
let kStr_SupermarketLogo           = "str_SupermarketLogo"
let kAdmin                         = "Admin"
let kDateFormate                   = "dd-MM-yyyy"
let kMonthFormate                   = "MM"
let kYearFormate                   = "MM/yyyy"
let kTimeFormate                   = "h:mm a"
let kChooseFromGaller              = "Choose from Gallery"
let kChooseFromCamera              = "Choose from Camera"
let kThisdevicehasNoCamera         = "This device has no Camera"
let kCameraNotFound                = "Camera Not Found"
let kAppName                       = "Gaurashtra"
let kConformation                  = "Conform"
let kOk                            = "Ok"
let kCancel                        = "Cancel"
let kNO                            = "No"
let kIsTutorialAlreadyShown        = "isTutorialAlreadyShown"
let kIsUserLoggedIn                = "isUserLoggedIn"
let kMarketLoggedIn                = "isMarketLoggedIn"
let kLoggedInUserDetails           = "loggedInUserDetails"
let kSavedCurrencyDetails          = "SavedCurrencyDetails"
let kLoggedInSupermarketDetails    = "loggedInSupermarketDetails"
let kLoggedInUserId                = "loggedInUserId"
let kLatitude                      = "latitude"
let kLongitude                     = "longitude"
let kDriverStatus                  = "driverStatus"
//let kCurrentDateTime               = "currentDateTime"
let kIsCurrencySaved               = "isCurrencySaved"
let kConfirmationType              = "confirmationType"
let kDropType                      = "dropType"
//let kCancelReson                   = "cancelReson"
let kNumberPlaceHolder             = "Contact No"
let kPlaceHolderFirstName          = "First Name"
let kPlaceHolderLastName           = "Last Name"
let kSelectGenderTxt               = "Select Gender"
let kSelectCountry                 = "Select Country"
let kSelectState                   = "Select Region/State"
let kEmailPlaceHolder              = "Email Address"
let kOrderNo                       = "Order No."
let kDistancePlceholder            = "Distance"
let kPricePlceholder               = "Price"
let kRankPlceholder                = "Rank"
let kProductNamePlceholder         = "Enter Product Name"
let kSupermarketNamePlceholder     = "Enter Supermarket Name"
let kSearchTitle                   = "Search"

let kSearchtext                    = "searchtext"


let kSelectDeliveryTimeTxt          = "Select Delivery Time"
let kSelectLocationTxt              = "Select Location"
let kShopByCategories               = "Shop By Categories"
let kNearestSupermarkets            = "Nearest Supermarkets"
let kProcessing                     = "Processing"
let kYourOrderReceived              = "Your order is Received"
let kOrderPlaced                    = "Order Placed"
let kYourOrderPlaced                = "Your order is Placed"
let kOrderPacked                    = "Order Packed"
let kPreparingYourOrder             = "We are Preparing Your Order"
let kReadyToPickup                  = "Ready To Pickup"
let kYourOrderReadyForPickup        = "Your Order is Ready For Pickup"
let kDelivered                      = "Delivered"
let kYourOrderHasBeenDelivered      = "Your Order has been Delivered"
let kSearchTxtFieldPlaceHolder      = "Enter Product name here...."
let kAdvanceSearch                  = "Advance Search"
let kLogoutPlacehoderString         = "Are you sure you want to logout?"
let kDeleteAccountString            = "Are you sure you want to delete your account?"
let kAreYouSureHaveYouReachedAt     = "Are You Sure have you Reached at"
let kMenu                           = "Menu"
let kMain                           = "Main"
let kSupermarketPlaceHolder         = "Supermarket"
let kOrderHistoryPlaceHolder        = "Order History"
let kAboutUsPlaceHolder             = "About Us"
let kContactUsPlaceHolder           = "Contact Us"
let kShareAppPlaceHolder            = "Share App"
let kLogoutPlaceHolder              = "Logout"
let kUpdatePlaceholder              = "Update"
let kEditProfilePlaceHolder         = "Edit Profile"
let kGetInTouchPlaceHolder          = "Get In Touch"
let kWithMonkeylee                  = "With Monkeylee"
let kAboutContactDetailsPlaceHolder = "It is a mobile application on different platforms(intially IOS and Android) to enable people (Super Markets) worldwide to connect and sell their goods on Monkeyleeplateform/app"
let kPhoneNoPlaceHolder             = "Phone No"
let kDropeUsALine                   = "Drope Us A Line"
let kAddressPlaceHolder             = "Address"
let kSubmitPlaceHolder              = "Sumbit"
let kCustomerServicePlaceHolder     = "You can Get In touch with our 24/7 customer service excutive any time."
let kTRACK_YOUR_ORDER               = "TRACK YOUR ORDER"
let kNO_DATA_FOUND                  = "NO DATA FOUND"
let kPricePlaceholder               = "Price"
let kLoginPlaceholder               = "Login"
let kIOS                            = "ios"
let kBankDetailsStr                 = "Bank Details"
let kAccountHolderNameStr           = "Account Holder Name"
let kBankNameStr                    = "Bank Name"
let kAccountNumberStr               = "Account Number"
let kIFSCCodeStr                    = "IFSC Code"
let kShoppingCartEmpty              = "Your Shopping Cart is Empty"
let kRemoveItem                     = "Do you Want to Remove This Item ?"

let kPleaseSelectAddress            = "Please Select Address"
let kFullNamePlaceholder            = "Full Name"
let kNickNameAddressPlaceholder     = "Nickname, e.g Home/Office"
let kCityPlaceholder                = "City"
let kHouseNumberPlaceholder         = "House no"
let kAreaPlaceholder                = "Area"
let kPincodePlaceholder             = "Pincode"
let kStreetNamePlaceholder          = "Street Name(optional)"
let kLandmarkPlaceholder            = "Landmark(optional)"
let kPleaseSelectPaymentMethod      = "Please Select Payment Method"
let kCongrats                       = "Congrats"
let kYes                            = "Yes"
let kSuccessfullyPayment            = "Successfully payment"
let kShareApp                      = "Share App"
let kTellYourFriendsAboutYiwuLife      = "Tell Your Friends About YiwuLife"
let kInviteYourFriendsShopOnYiwuLife                             = "Invite your Friends on YiwuLife"
let kShare                         = "Share"
let kSignUpStr                     = "Sign Up"
let kEditSupermarketDetails           = "Edit Supermarket Details"
let kEnterBankHolderNameStr            = "Please Enter Bank Account Holder Name"
let kEnterBankNameStr              = "Please Enter Bank  Name"
let kEnterAccountNumberStr         = "Please Enter Bank Account Number"
let kReEnterAccountNumberStr       = "Please Re-Enter Bank Account Number"
let kbankAccountNumberNotMatch     = "bank Account Number Doesn't Match"
let kEnterBankRoutingNumber        = "Please Enter Bank Routing No."
let kReEnterBankRoutingNumber      = "Please re-Enter Bank Routing No."
let kBankRoutingNumberDoesNotMatch = "Please re-Enter Bank Routing No."
let kEnterBranchNo                 = "Please Enter Branch No."
let kEnterIfscStr                  = "Please Enter Bank IFSC Code"
let kEnterUserName                 = "Please enter your name"
let kCancalOrderAlert              = "Do you want to Delete this Address?"
let kEnterCoupenCode               = "Please Enter Coupen Code"
let kFailledToUpdateProfile        = "Failled to update profile"
let kPRIVACYPOLICY                 = "PRIVACY POLICY"
let kTERMSCONDITIONS               = "TERMS & CONDITIONS"
let kEmailAddressStr               = "Email Address"
let kPasswordStr                   = "Password"
let kPleaseSelectGender            = "Please Select Gender"
let kAddContactAlert               =  "you Can't Add More then 4 Contacts"
let kDeleteContactAlert            = "Are you sure you want to Remove this Contact?"


//let phone = "+\(country.phoneExtension)"

//self.countryCodeLbl.text = "\(country.flag!) \(country.countryCode), \(phone)"






