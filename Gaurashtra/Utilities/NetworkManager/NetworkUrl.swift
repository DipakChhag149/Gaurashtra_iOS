//
//  NetworkUrl.swift
//  TANetworkingSwift
//
//  Created by Girijesh Kumar on 09/01/16.
//  Copyright © 2016 Girijesh Kumar. All rights reserved.
//

import Foundation
import UIKit

/** --------------------------------------------------------
* HTTP Basic Authentication
*	--------------------------------------------------------
*/
let kNetworkErrorAlert          = "Network error. Check your network connections and try again."
let kMaleStr                    = "Male"
let kMale                       = "1"
let kFemale                     = "2"
let kOther                      = "3"
let kHTTPUsername               = ""
let kHTTPPassword               = ""
let kAppLink                    = "https://itunes.apple.com/us/app/cabbeeDriver/Write Here itune App Id like->id1103530261"
let kOne                        = "1"
let kTwo                        = "2"
let kCode                       = "code"
let kData                       = "data"

let OS                          = UIDevice.current.systemVersion
let kAppVersion                 = "1.0"
let kDeviceModel                = UIDevice.current.model
//let kSemiBoldFont             = UIFont.init(name: "SourceSansPro-Semibold", size: 14.0)
let kRegularFont                = UIFont.init(name: "semi-regular", size: 14.0)
//let kAPIKEY                   = "cesar@123"
//let CLASS_START               = print(__FILE__)
let kResult                     = "result"
let kAddAction                  = "add"
let kEdit                       = "edit"
let kAlgosoft                   = "Gaurashtra"
let kApiKey                     = "Apikey"
let kApiDate                    = "Apidate"

/** --------------------------------------------------------
*	 API Base URL defined by Targets.
*	--------------------------------------------------------
*/
//let kBASEImgURL                 = "https://www.gaurashtra.com/app-testing/image/"
//let kBASEURL                    = "https://gaurashtra.algosoftech.in/api/"
let kBASEImgURL                 = "https://www.gaurashtra.com/app-testing/image/"
let kBASEURL                    = "https://app.gaurashtra.com/api/"
let kLiveRazorPayKey            = "rzp_live_tNlHeOfmNqgtwO"


let kSelectPeople               = ["1","2","3","4","5","6","7","8","9","10"]
let kSelectSubjectsList         = ["Query","Feedback","Complaint"]

let kSelectVehicleModel               = ["2000","2001","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018"]

let kVahicleCatMake                   = ["BMW","Fiat","Ford","General","Honda","Hyndai","Nissan","Tesla","Toyota","Volkswagen"]

let kBMW                         = ["BMW X3","BMW X4","BMW X5","BMW X6"]
let kFiat                        = ["Dodge Durango","Jeep Cherokee","Jeep Grand Cherokee","Jeep Wrangler","Ram Pickup"]

let kFord                        = ["Ford C-MAX","Ford Econoline","Ford Escape","Ford Expedition","Ford Expedition MAX","Ford Explorer","Ford F-150","Ford Focus","Ford Mustang","Ford Super Duty"]

let kGeneral = ["Buick Enclave","Buick LaCrosse","Cadillac ATS","Cadillac CT6","Cadillac CTS","Cadillac Escalade","Cadillac Escalade EXT","Chevrolet Bolt","Chevrolet Colorado","Chevrolet Carvette"]
let kHonda = ["Honda Accord","Honda Civic","Honda CR-V","Honda Odyssey","Honda Pilot"]

let kHyndai = ["Hyundai Elantra","Hyundai Santa Fe","Hyundai Sonata"]
let kNissan = ["Nissan Altima","Nissan Leaf","Nissan Maxima","Nissan Murano","Nissan Pathfinder"]
let kTesla = ["Tesla Model 3","Tesla Model S","Tesla Model X"]
let kToyota = ["Toyota Avalon","Toyota Camry","Toyota Corolla","Toyota Highlander","Toyota Sequoia"]
let kVolkswagen  = ["Volkswagen Atlas","Volkswagen Passat"]

let kSelectTaxiType                   = ["Car(Taxi)","Car(TCP)","Limousine(TCP)","Mini Van(Taxi)","SUV(TCP)","Wheelchair(Taxi)"]

let kSelectTaxiCapacity                   = ["4","4","10","8","6","4"]

let kSelectDriverClassification       = ["Independent"]
let kSelectGender               = ["Male", "Female"]
let kProductQty                   = ["01", "02","03", "04","05", "06","07", "08","09", "10","11", "12","13","14","15"]
//let kSelectYear                = ["01", "02","03", "04","05", "06","07", "08","09", "10","11", "12"]
let kSelectDeliverTime          = ["30 Mins", "40 Mins"]
let kSelectLocation             = ["5 Kms","10 Kms","15 Kms","20 Kms"]
let kSelectDistance             = ["0-5km","5-10 km"]
let kSelectPrice                = ["Low to High","High to Low"]
let kSelectRank                 = ["High","Medium"]
let kSelectType                 = ["Nearest","Cheapest"]


let kAuthentication             = "Authentication"          //Header key of request  encrypt data
let kEncryptionKey              = ""                    //Encryption key replace this with your projectname

let kStripLivePublishKey         = "pk_live_aWtIrDz1lyoLQoXfrP4LpZaW" //pk_test_CDaxip2f9HfFFnTJa8XTSRjW
let kStripTestPublishKey         = "pk_test_CDaxip2f9HfFFnTJa8XTSRjW"
let kViewType                   = "1"
let kLikesType                  = "0"
let kNormalType                 = "3"
let kNormalAccountType          = "1"
let kEnterOPT                   = "Please Enter OTP"
let kPleaseEnterOPT             = "Please Enter OTP"
let kEnterFirstName             = "Please enter first name"
let kEnterLastName              = "Please enter last name"
let kEnterAddress               = "Please Your Enter Address"
let kEnterAddress1               = "Please Your Enter Address 1"
let kEnterAddress2               = "Please Your Enter Address 2"
let kEnterValidEmail            = "Please enter a valid email"
let kSelectModelId              = "Please Select Vehicle Model Id"//kCategoryId
let kGiveRating                 = "Please Give Rating"

let kSelectTypeId              = "Please Select Vehicle Type Id"
let kSelectCategoryId           = "Please Select Vehicle Category Id"
let kSeletRegistExpiry          = "please Select Vehicle Regist Expiry date"
let kEnterVehicleNumber         = "Please Enter Vehicle Number"
let kEnterDriverLicence         = "Please Enter Your Driving Licence "
let kEnterCityName              = "Please Enter City Name"
let kEnterStateName             = "Please enter State Name"
let kEnterFlageDropRate         = "Please Enter Flage Drop Rate"
let kEnterPerMileRate           = "Please Enter PerMile Rate"
let kEnterNameOfFleet           = "Please Enter Name Of Fleet"
let kEnterFleetPhoneContact     = "Please Enter Fleet Phone Contact"
let kEnterkCommercialInsurance  = "Please Enter Commercial Insurance"
let kSelectCommercialInsuranceExpiry = "Please Select Commercial Insurance Expiry"
let kEnterZipcode               = "Please enter Zipcode"
let kEnterCountry               = "Please Enter Country"
let kSelectProfileImgView       = "Please Select Profile Image"//driverPermitImg
let kSelectDLImgView            = "Please Select DL Image"
let kSelectVehiclePermitImg     = "Please Select Vehicle Permit Image"//insuranceImg
let kSelectDriverPermitImg      = "Please Select Driver Permit Image"
let kSelectInsuranceImg         = "Please Select Insurance Image"
let kEnterYourEmail             = "Please enter a valid email"
let kEnterPassword              = "Please enter password"
let kSelectCoupon               = "Please select Coupon"
let kEnterConPassword           = "Please Enter Confirm Password"
let kNewPassword                = "Please Enter New Password"
let kEnterMinimumPassword       = "Please enter Minimum 6 Digits password"
let kEnterPhoneNo               = "Please enter Registered Phone Number"
let kPasswordNotMatch           = "Password do not match"
let kSelectCountryCode          = "Please Select Country Phone Code"
let kEnterMobileNumber          = "Please Enter Mobile Number"
let kEnterPermitType                = "Please Enter Permit Type"
let kEnterVehicleId             = "Please Enter Vehicle Id"
let kEnterVehiclePermitNo       = "Please Enter Vehicle Permit No"
let kSelectVehiclePermitExpiry  = "Please Select Vehicle Permit Expiry Date"
let kEnterCabNo                 = "Please Enter Cab No"
let kEnterDriverPermitNo        = "Please Enter Driver Permit No"
let kSelectDriverPermitExpiry   = "Please Select Driver Permit Expiry"
let kEnterPermitIssuingAuthority = "Please Enter Permit Issuing Authority"
let kSelectDriverClassificationAlert = "Please Select Driver Classification"
let kEnterSupermarketName       = "Please Enter Supermarket Name"
let kEnterSupermarketAddress    = "Please Enter Supermarket Address"
let kEnterSupermarketLocation   = "Please Enter Supermarket Location"
let kSelectDeliveryTime         = "Please Select Delivery Time"
let kTrue                       = "1"
let kEnterHouseNo               = "Please Enter House Number"
let kEnterPinCode               = "Please enter Pincode"
let kEnterPostCode              = "Please enter Postcode"
let kSelectDistanceAlert        = "Please Select Distance"
let kSelectPriceAlert           = "Please Select Price"
let kSelectRankAlert            = "Please Select Rank"
let kEnterProductName           = "Please Enter Product Name"
let kEnterMessage               = "Please enter message can not be empty"
let kEnterReview                = "Please enter your review"
let kPleaseEnterProdeuctName    = "Please Enter Prodeuct Name"
let kDateAndTimeFormate         = "yyyy-MM-dd' 'HH:mm"
let kSelectNationality          = "Please Select Nationality"
let kEnterValidMobileNumber     = "Please Enter Mobile Number"
let kPleaseEnterOTP             = "Please Enter OTP"

//#if DEBUG
//    static int ddLogLevel = LOG_LEVEL_VERBOSE;
//    #elif TEST
//    static int ddLogLevel = LOG_LEVEL_INFO;
//    #elif STAGE
//    static int ddLogLevel = LOG_LEVEL_WARN;
//    #else
//    static int ddLogLevel = LOG_LEVEL_ERROR;
//    #endif

    /*****************************************************************************/
    /* Entry/exit trace macros                                                   */
    /*****************************************************************************/
   // #define TRC_ENTRY()    DDLogVerbose(@"ENTRY: %s:%d:", __PRETTY_FUNCTION__,__LINE__);
   // #define TRC_EXIT()     DDLogVerbose(@"EXIT:  %s:%d:", __PRETTY_FUNCTION__,__LINE__);
    
    
/** --------------------------------------------------------
*		Used Web Services Name
*	--------------------------------------------------------
*/

let kSubcategoryData            = "subcategoryData"
let kCreatOrder                 = "creatOrder"
let kListOfProducts             = "listOfProducts"
let kDiscountprice              = "discountprice"
let kDiscountPrice              = "dicountPrice"
let kIsDetails                  = "isDetails"
let kPercentOff                 = "percentOff"
let kCoupenIdApply              = "coupenId"
let kDeliveryCharges            = "deliveryCharges"
let kDeliveryCharge             = "deliveryCharge"
let kDeliveryType               = "deliveryType"
let kDeliveryTime               = "deliveryTime"
let kGetDeliveryDetails         = "getDeliveryDetails"
let kExpressDelivery            = "expressDelivery"
let kExpressDeliveryCharges     = "expressDeliveryCharges"
let kExpressDeliveryTime        = "expressDeliveryTime"
let kOnlinePayments             = "onlinePayments"
let kCashPayments               = "CashPayments"
let kPaymentMode                = "paymentMode"
let kPaymentInfo                = "paymentInfo"
let kIFSCCode                   = "ifscCode"
let kBankAccountNumber          = " bankAccountNumber"
let kReEnterBankAccountNumber   = "reEnterBankAccountNumber"
let kBankRoutingNumber         = "bankRoutingNumber"
let kBranchNumber               = "branchNumber"
let kBankName                   = "bankName"
let kAccountName                = "accountName"
let kBankAccountHolderName      = "accountHolderName"
let kShowBankDetails            = "ShowBankDetails"
let kBankDetails                = "BankDetails"
let kGetSupermarketDetails      = "getSupermarketDetails"
let kUpdateSuperMarketDetails   = "UpdateSuperMarketDetails"
let kUserProfile                = "userProfile"
let kGetUserAdderssList         = "getUserAdderssList"
let kAddUserAddress             = "addUserAddress"
let kOtpSend                    = "otpSend"
let kSupermarket_address        = "supermarket_address"
let kSupermarket_location       = "supermarket_location"
let kProId                      = "proId"
let kCatid                      = "catid"
let kManageCart                 = "manageCart"
let kGetCategoryProductList     = "getCategoryProductList"
let kProductId                  = "productid"
let kProdId                     = "productId"
let kReview                     = "review"
let kRating                     = "rating"
let kReviewType                 = "reviewType"
let kReviewId                   = "reviewId"
let kActiontype                 = "actiontype"
let kPaymentFirstName           = "paymentFirstName"
let kPaymentLastName            = "paymentLastName"
let kPaymentCompany             = "paymentCompany"
let kPaymentAddress1            = "paymentAddress1"
let kPaymentAddress2            = "paymentAddress2"
let kPaymentCity                = "paymentCity"
let kPaymentPostcode            = "paymentPostcode"
let kPaymentCountry             = "paymentCountry"
let kPaymentCountryId           = "paymentCountryId"
let kPaymentZone                = "paymentZone"
let kPaymentZoneId              = "paymentZoneId"
let kShippingFirstName          = "shippingFirstName"
let kShippingLastName           = "shippingLastName"
let kShippingCompany            = "shippingCompany"
let kShippingAddress1           = "shippingAddress1"
let kShippingAddress2           = "shippingAddress2"
let kShippingCity               = "shippingCity"
let kShippingPostcode           = "shippingPostcode"
let kShippingCountry            = "shippingCountry"
let kShippingCountryId          = "shippingCountryId"
let kShippingZone               = "shippingZone"
let kShippingZoneId             = "shippingZoneId"
let kOptionid                   = "optionid"
let kOptionvalueid              = "optionvalueid"
let kCouponCode                 = "couponCode"
let kApplyCoupon                = "applyCoupon"
let kGetCartData                = "getCartData"
let kMultipleDeleteInCart       = "multipleDeleteInCart"
let kGetCurrencyList            = "getCurrencyList"
let kGetCurrencyDetails         = "getCurrencyDetails"
let kGetTopSellingList          = "getTopSellingList"
let kGetTodayDealList           = "getTodayDealList"
let kGetBestOfProductList       = "getBestOfProductList"
let kGetRecentlyViewedList      = "getRecentlyViewedList"
let kGetRecommendedProductList  = "getRecommendedProductList"
let kProduct_id                 = "product_id"
let kQuantity                   = "quantity"
let kCartSessionId              = "cartSessionId"
let kDeviceType                 = "devicetype"
let kProductDetails             = "productDetails"
let kGetProductDetails          = "getProductDetails"
let kGetProductOtherDetails     = "getProductOtherDetails"
let kGetProductDataDetails      = "getProductDataDetails"
let kCheckOnlyPincode           = "checkOnlyPincode"
let kGetProductList             = "getProductList"
let kGetBrandProductList        = "getBrandProductList"
let kGetBrandList               = "getBrandList"
let kSetOrderReport             = "setOrderReport"
let kAskAQuestion               = "askAQuestion"
let kContactUs                  = "contactUs"
let kNotifyMe                   = "notifyMe"
let kTrackOrder                 = "trackOrder"
let kOrderHistory               = "orderHistory"
let kCancelOrder                = "cancelOrder"
let kCancelOrderAlert           = "Do you want to cancel this order"
let kSubcatgorylist             = "subcatgorylist"
let kSubCatId                   = "subCatId"  //
let kSuperSubCatId              = "superSubCatId"
let kSuperProfilePic            = "superProfilePic"
let kCoupenCode                 = "coupenCode"
let kHomeApi                    = "homeApi"
let kNickName                   = "address"
let kCity                       = "city"
let kPostcode                   = "postcode"
let kHouseNo                    = "housNo"
let kArea                       = "area"
let kPincode                    = "pincode"
let kStreetName                 = "streetName"
let kPermitType                 = "permitType"
let kVehiclePermitNumber        = "vehiclePermitNumber"
let kVehiclePermitExpiry        = "vehiclePermitExpiry"
let kVehicleNumber              = "vehicleNumber"
let kGetDriverVPBDetails        = "getDriverVPBDetails"
let kSetAvailable               = "setAvailable"
let kSetCancelCurrentRide       = "setCancelCurrentRide"
let kSetStartCurrentRide        = "setStartCurrentRide"
let kSetDriverReachedToPickup   = "setDriverReachedToPickup"
let kUpdateDriverInformation    = "updateDriverInformation"
let kVehicleId                  = "vehicleId"
let kModelId                    = "modelId"
let kModelName                  = "modelName"
let kMakeId                     = "makeId"
let kMakeName                   = "makeName"
let kTypeId                     = "typeId"
let kTypeName                   = "typeName"
let kCatId                      = "catid"
let kCategoryName               = "categoryName"
let kCapacityName               = "capacityName"
let kRegistExpiry               = "registExpiry"
let kRegistExpiryImage          = "registExpiryImage"
let kCabNumber                  = "cabNumber"
let kDriverPermitNumber         = "driverPermitNumber"
let kDriverPermitExpiry         = "driverPermitExpiry"
let kDriverClassification       = "driverClassification"
let kPermitIssuingAuthority     = "permitIssueAuthority"
let kFlagDropRate               = "flagDropRate"
let kPerMileKmRate              = "perMileKmRate"
let kNameOfFleet                = "nameOfFleet"
let kFleetPhone                 = "fleetPhone"
let kCommercialInsurance        = "commercialInsurance"
let kcreateUserAccout           = "userSignUp"
let kSupermarketSignup          = "supermarketSignup"
let kSupermarketSignIn          = "supermarketSignIn"
let kUserSignIn                 = "userSignIn"
let kRegistertionType           = "registertionType"
let kCountryCode                = "countryCode"
let kNationality                = "nationality"
let kSendMoney                  = "sendMoney"
let kConnectedUserId            = "connectedUserId"
let kPayToPost                  = "payToPost"
let kHome                       = "Home"
let kPayUserId                  = "payeeUserId"
let kPostTransactionHistory     = "postTransactionHistory"
let kWalletTransactionHistory   = "walletTransactionHistory"
let kShowWalletAmount           = "walletAmount"
let kAmount                     = "amount"
let kAppColor                   = "#3F4C75"
let kColor                      = "color"
let kTheme                      = "theme"
let kStripeAccessToken          = "token"
let kAddMoney                   = "addMoney"
let kConnection                 = "connectionList"
let kSocialLogin                = "user/socialLogin"
let kPostView                   = "view"
let kPostViewApi                = "PostViews"
let kPostLikes                  = "postLikes"
let kloginData                  = "loginData"//loginData
let kLogout                     = "logout"
let kUpdateAccount              = "user/updateAccount"
let kUpdateProfileImage        = "user/updateProfileImage"
let kGetProfile                 = "postList"
let kWeeklyPostList             = "weeklyPost"
let kPostDetails                = "postDetails"
let kPostId                     = "postId" 
let kPostLikesUserId            = "postUserId"
let kcreateAccout               = "register"
let kAddPost                    = "addPost"
let kGetHomePageData            = "getHomePageData"
let kGetProductWithReviewRating = "getProductWithReviewRating"
let kGetLogin                   = "getLogin"
let kGetWalletData              = "getWalletData"
let kGetProductOptionList       = "getProductOptionList"
let kGlobalSearch               = "globalSearch"
let kGetAddressList             = "getAddressList"
let kGetCategoryList            = "getCategoryList"
let kGetWishlist                = "getWishlist"
let kManageWishlist             = "manageWishlist"
let kGetSubCategoryList         = "getSubCategoryList"
let kGetProductListByCat        = "getProductListByCat"
let kAddToCartData              = "addToCartData"
let kGetCountryList             = "getCountryList"
let kGetZoneList                = "getZoneList"
let kSetConfirmOrder            = "setConfirmOrder"
let kSetPayment                 = "setPayment"
let kPayId                      = "payId"
let kRazorPayId                 = "generateOrderIdForRazarpay"
let kCheckPaymentCaptureOrNot   = "checkPaymentCaptureOrNot"
let kCaptureOrderAmount         = "captureOrderAmount"
let kGetCartInfo                = "getCartInfo"
let kSetProductReviewRating     = "setProductReviewRating"
let kGetNotificationList        = "getNotificationList"
let kGetCarBrand                = "product/getCarBrand"
let kGetProductSubCategory      = "product/getProductSubCategory"
let kGetCarBrandModel           = "product/getCarBrandModel"
let kGetProductCategory         = "product/getProductCategory"
let kSetCurrentLocation         = "setCurrentLocation"
let kOtpVerification            = "otpVerification"
let kSetDriverInformation       = "setDriverInformation"
let kSetVehicleCityPermit       = "setVehicleCityPermit"
let kGetMyRides                 = "getMyRides"
let kSetCompleteCurrentRide     = "setCompleteCurrentRide"
let kSetDriverBankDetails       = "setDriverBankDetails"
let kSetVehicleInformation      = "setVehicleInformation"
let kBrandList                  = "brandlist"
let kCategoryList               = "categoryList"
let kFilter                     = "filter"
let kMalls                      = "malls"
let kOffers                     = "offers"
let kRefundCancellationPolicy   = "refundCancellationPolicy"
let kPrivacyPolicy              = "privacyPolicy"
let kTermsConditions            = "termsConditions"
let kAboutUs                    = "aboutUs"
let kStore                      = "store"
let kMalloffers                 = "malloffers"
let kStoreoffer                 = "storeoffer"
let kBrandOffer                 = "brandoffer"
let kMap                        = "map"
let kCatloguetag                = "Catloguetag"
let kTag                        = "tag"
let kTagDetial                  = "tagDetial"
let kSerchRetailer              = "serchRetailer"
let kSignup                     = "user/signup"
let kGetRegistration            = "getRegistration"
let kVerifyOtp                  = "verifyOtp"
let kLike                       = "like"
let kNotificationhistory        = "notificationhistory"
let kNotification               = "notification"
let kFullName                   = "userName"
let kMobileNumber               = "mobileNumber"
let kTelephone                  = "telephone"
let kAuthorization              = "Authorization"


let kSocialCheck                = "socialCheck.php"
let kSalonDetails               = "salon_details.php"
let kUpdatePriceList            = "pricelist.php"
let kGetExpertiseList           = "getServicename.php"
let kAddClipaz                  = "add_clipaz.php"
let kGetAppointentDetails       = "appointment_details.php"
let kGetNextAvailableTime       = "getNextAvailableTime.php"
let kMoveAppointment            = "moveAppointment.php"
let kCancelAppointment          = "cancelAppointment.php"
let kInsightReport              = "insightReport.php"
let kTrimspirationImage         = "trimspirationImage.php"
let kUploadTrimspirationImage   = "uploadTrimspiration.php"
let kDeleteTrimspirationImage   = "deleteTrimspirationImage.php"
let kEditServices               = "editServices.php"
let kUpdateServices             = "updateServices.php"
let kProfileDetails             = "profile_details.php"
let kEditSalonProfile           = "editsalonProfile.php"
let kUpdateSalonProfile         = "updatesalonProfile.php"
let kGetClipaz                  = "getClipaz.php"
let kGetClipazDetails           = "getclipazDetails.php"
let kUpdateClipaz               = "updateClipaz.php"
let kRemoveClipaz               = "removeClipaz.php"
let kUpdatePin                  = "updatePin.php"
let kGetOffer                   = "getOffer.php"
let kUpdateOffer                = "updateOffer.php"
let kGetForgotPassword          = "getForgotPassword"
/** --------------------------------------------------------
*		API Request & Response Parameters Keys
*	--------------------------------------------------------
*/
//resest_password pageNo address


let kProductData                = "productData"
let kCurrencyValue              = "currencyValue"
let kPaymentTelephone           = "paymentTelephone"
let kCustomerPhone              = "customerPhone"
let kShippingTelephone          = "shippingTelephone"
let kTxnId                      = "txnId"
let kPaymentType                = "paymentType"
let kCurrencyCode               = "currencyCode"
let kSubcatgoryName             = "subcatgoryName"
let kLogo                       = "logo"
let kName                       = "name"
let kRank                       = "rank"
let kProName                    = "proName"
let kDescription                = "description"
let kSupermarketName            = "supermarketName"
let kDistance                   = "distance"
let kSuperMarketHome            = "SuperMarketHome"
let kSearchData                 = "searchData"
let kAdvanceSearchKeyWord       = "advanceSearch"
let kKeyword                    = "keyword"
let kUserForgotPassword         = "userForgotPassword"
let kSupermarketForgotPassword  = "supermarketForgotPassword"
let kOtpVerifications           = "otpVerifications"
let kSuperMarketAddress         = "Supermarket Address"
let kSuperMarketName            = "Supermarket Name"
let kLocalTime                  = "date_created"
let kUserAddress                = "userAddress"
let kLoginType                  = "loginType"
let kNetworkId                  = "networkId"
let kDeviceId                   = "deviceid"
let kUserPhone                  = "userPhone"
let kContactNo                  = "contactNo"
let kCarBrandId                 = "carBrandId"
let kMobile                     = "mobile"
let kMobileNo                   = "mobileNo"
let kMessage                    = "message"
let kPageNo                     = "pageNo"
let kPerpageData                = "perpageData"
let kPostType                   = "postType"
let kType                       = "type"
let kGetResetPassword           = "getResetPassword"
let kGetChangePassword          = "getChangePassword"
let kEditProfileData            = "editProfileData"
let kGetAddEditAddress          = "getAddEditAddress"
let kPostDescription            = "postDescriptions"
let kOtp                        = "otp"
let kUserNewPassword            = "userNewPassword"
let kResendOtp                  = "resendOtp"
let kFirstName                  = "firstname"
let kCustomer_id                = "customer_id"
let kLastName                   = "lastname"
let kSupermarket_name           = "supermarket_name"
let kEmail                      = "email"
let kContact                    = "contact"
let kProfile                    = "prefill"
let kImage                      = "image"
let kDriverLicenseNumber        = "driverLicenseNumber"
let kDriverLicenseImage         = "driverLicenseImage"
let kDriverImage                = "driverImage"
let kAddress1                   = "address1"
let kAddress2                   = "address2"
let kCityName                   =  "cityName"
let kState                      = "state"
let kDef_address                = "def_address"
let kCompany                    = "company"
let kZipCode                    = "zipCode"
let kUserName                   = "userName"
let kUsername                   = "username"
let kQuery                      = "query"
let kuserName                   = "userName"
let kSocialType                 = "socialType"
let kSocialId                   = "socialId"
let kPassword                   = "password"
let kOldPassword                = "oldpassword"
let kDelivery_time              = "delivery_time"
let kConPassword                = "conf_pass"
let kSubject                    = "subject"
let kAccountType                = "account_type"
//let kDeviceType                 = "devicetype"
let kToken                      = "access_token"
let kBusinessName               = "businessName"
let kRegistrationStatus         = "registrationStatus"
let kUserType                   = "userType"
let kOffer                      = "offer"
let kOfferBanner                = "offerBanner"
let kUserId                     = "userid"
let kComment                    = "comment"
let kGetOrderList               = "getOrderList"
let kGetOrderDetails            = "getOrderDetails"
let kBrandid                    = "brandid"
let kCountryid                  = "countryid"
let kDriverId                   = "driverId"
let kAvailableType              = "availableType"
let kAvailableDateTime          = "availableDateTime"
let kCurrentDateTime            = "currentDateTime"
let kCancelReson                = "cancelReson"
let kRideId                     = "rideId"
let kUserImage                  = "userImage"
let kAction                     = "action"
let kAddressId                  = "address_id"
let kOrderId                    = "orderId"
let kRPayOrderId                = "order_id"
let kOrderStatus                = "orderStatus"
let kOffset                     = "offset"
let kImgId                      = "imgId"
let kLandmark                   = "ladmark"
let kLicenseNumber              = "licenseNumber"
let kCountry                    = "country"
let kCountryName                = "countryName"
let kBusinessOpen               = "businesOpen"
let kBusinessClose              = "businessClose"
let kLunchStart                 = "lunchStart"
let kLunchClose                 = "lunchClose"
let kDaysOpen                   = "daysOpen"
let kPriceList                  = "priceList"
let kClipazName                 = "clipazName"
let kExpertise                  = "expertise"
let kStartTime                  = "startTime"
let kEndTime                    = "endTime"
let kSortBy                     = "sortBy"
let kAppointmentId              = "appointmentId"
let kClipazId                   = "clipazId"
let kSelectedTime               = "selectedTime"
let kCustomerId                 = "customerId"
let kServiceAmount              = "serviceAmount"
let kAppointmentTime            = "appointmentTime"
let kClipazImage                = "clipazImage"
let kCustomerName               = "customerName"
let kCustomerPic                = "customerPic"
let kServiceName                = "serviceName"
let kIsEditable                 = "isEditable"
let kGrowth                     = "growth"
let kPercentage                 = "percentage"
let kTotalAmount                = "totalAmount"
let kSupermarketLogo            = "supermarketLogo"
//let kLogo                       = "logo"
let kTotalBooking               = "totalBooking"
let kBookings                   = "bookings"
let kIstVisit                   = "istVisit"
let kTrimspirationImg           = "trimspirationImg"
let kCutTime                    = "cutTime"
let kPrice                      = "price"
let kWeight                     = "weight"
let kProductCount               = "productCount"//"productCount"
let kBool                       = "Bool"
let kProdImage                  = "prodImage"//"prodImage"
let kProfilePicture             = "profilePic"
let kOldPin                     = "oldPin"
let kCurrentPin                 = "currentPin"

let kPostTitle                  = "postTitle"
let kDateOfBirth                = "dob"
let kDate                       = "date"
let kGender                     = "gender"
let kWork                       = "work"
let kSchool                     = "school"
let kSkills                     = "skills"
let kCauses                     = "causes"
let kIntroduction               = "introduction"
let kAccount                    = "account"
let kParams                     = "params"
let kAccess_token               = "access_token"
let kDevice_type                = "device_type"
let kRegistrationId             = "registration_id"
let kOauth_token                = "oauth_token"
let kOauth_token_secret         = "oauth_token_secret"
let kMedia                      = "media"
let kMediaType                  = "media_type"
let kVideoThumbnail             = "video_thumbnail"
let kFrom_user                  = "from_user"
let kTo_user                    = "to_user"
let kIsEmailVerified            = "is_email_verified"
let kMediaFiles                 = "media_files"

let kIsInstagramConnected       = "is_instagram_connect"
let kIsSocialRegister           = "is_social_register"
let kInQueue                    = "in_queue"
let kIsReport                   = "is_report"
let kPushNotification           = "push_notification"
let kSound                      = "sound"
let kInterestedIn               = "interested_in"
let kIsFacebookConnected        = "is_facebook_connect"
let kId                         = "id"
let KCommentCount               = "comment_count"
let kPartyLocation              = "party_location"
let kMembers                    = "members"

let kAllFollowing               = "all_following"
let kTitle                      = "title"
let kRepetitionType             = "repetition_type"
let kPartyType                  = "party_type"
let kBeacon                     = "beacon"
let kMaximumDistance            = "max_distance"
let kPreferences                = "preferences"
let kMinimumAge                 = "min_age"
let kMaximumAge                 = "max_age"
let kLocation                   = "location"
let kLocality                   = "locality"
let kIsProfilePicture           = "is_profile_picture"
let kRadius                     = "radius"
let kRequestId                  = "request_id"

let kNext                       = "next"
let kResults                    = "results"
let kUrl                        = "url"
let kCreatedAt                  = "created_at"
let kCreatedBy                  = "created_by"
let kModifiedAt                 = "modified_at"
let kModifiedAtLt               = "modified_at_lt"
let kModifiedAtGt               = "modified_at_gt"
let kEmbedded                   = "_embedded"
let kOwner                      = "owner"
let kBackgroundImage            = "background_image"
let kPartyMember                = "party_member"
let kParty                      = "party"
let k_Id                        = "_id"
let kIsReported                 = "is_report"
let kMediafiles                 = "media_files"
let kMember                     = "member"

let kPartyOccurence             = "party_occurence"
let kSender                     = "sender"
let kReceiver                   = "receiver"
let kInvitedUsers               = "invited_users"
let kPartyMembers               = "party_members"
let kGuestUsers                 = "guest_users"
let kDateSocialImage            = "dateSocialImage"
let kFacebookArr                = "facebookArr"
let kInstagramArr               = "instagramArr"
let kSearch                     = "search"
let kAdminOfferData             = "adminOfferData"