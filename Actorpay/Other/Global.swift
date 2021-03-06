//
//  Global.swift
//  Actorpay
//
//  Created by iMac on 01/12/21.
//

import Foundation
import UIKit
import MBProgressHUD

var progressHud = MBProgressHUD()
let obj_AppDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
let myApp = UIApplication.shared.delegate as! AppDelegate
let token = ""
var deviceFcmToken : String?
typealias typeAliasStringDictionary         = [String: String]
var selectedTabIndex = 0
var selectedTabTag = 1001
let VAL_TITLE                               = "Val_TITLE"
let VAL_IMAGE                               = "VAL_IMAGE"
var primaryColor = UIColor.init(hexFromString: "#183967")
var isNotificationEnabled: Bool?

func showLoading() {
    DispatchQueue.main.async {
        if progressHud.superview != nil {
            progressHud.hide(animated: false)
        }
        progressHud = MBProgressHUD.showAdded(to: (myApp.window?.rootViewController!.view)!, animated: true)
        if #available(iOS 9.0, *) {
            UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [MBProgressHUD.self]).color = UIColor.gray
        } else {
        }
        DispatchQueue.main.async {
            progressHud.show(animated: true)
        }
    }
}

func dissmissLoader() {
    DispatchQueue.main.async {
        progressHud.hide(animated: true)
    }
}

func deviceID() -> String{
    return UIDevice.current.identifierForVendor?.uuidString ?? ""
}

func appVersion() -> String {
    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
        return version
    }
    return ""
}

func attributedString(countryCode: String, arrow : String) -> NSMutableAttributedString {
    let countryCodeAttr = [ NSAttributedString.Key.foregroundColor: UIColor.black ]
    let countryCodeAttrString = NSAttributedString(string: countryCode, attributes: countryCodeAttr)
    
    let arrowAttr = [ NSAttributedString.Key.foregroundColor: UIColor.darkGray ]
    let arrowAttrString = NSAttributedString(string: arrow, attributes: arrowAttr)
    
    let mutableAttributedString = NSMutableAttributedString()
    mutableAttributedString.append(countryCodeAttrString)
    mutableAttributedString.append(arrowAttrString)
    return mutableAttributedString
}

func topCorner(bgView:UIView, maskToBounds: Bool, cornerRadius: CGFloat = 40) {
    bgView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
    bgView.layer.shadowOffset = CGSize(width: -1, height: -2)
    bgView.layer.shadowRadius = 2
    bgView.layer.shadowOpacity = 0.1
    bgView.layer.cornerRadius = cornerRadius
    bgView.layer.masksToBounds = maskToBounds
 }

func topCornerWithShadow(bgView:UIView, maskToBounds: Bool) {
      bgView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
      bgView.layer.shadowOffset = CGSize(width: 0, height: 0);
      bgView.layer.shadowOpacity = 0.5;
      bgView.layer.shadowColor = UIColor.darkGray.cgColor
      bgView.layer.cornerRadius =  25
      bgView.layer.masksToBounds = maskToBounds
  }

func topCorners(bgView:UIView, cornerRadius: CGFloat ,maskToBounds: Bool) {
    bgView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
//    bgView.layer.shadowOffset = CGSize(width: -1, height: -2)
//    bgView.layer.shadowRadius = 2
//    bgView.layer.shadowOpacity = 0.1
    bgView.layer.cornerRadius = cornerRadius
    bgView.layer.masksToBounds = maskToBounds
 }

func bottomCorner(bgView:UIView, cornerRadius: CGFloat ,maskToBounds: Bool) {
    bgView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
//    bgView.layer.shadowOffset = CGSize(width: -1, height: -2)
//    bgView.layer.shadowRadius = 2
//    bgView.layer.shadowOpacity = 0.1
    bgView.layer.cornerRadius = cornerRadius
    bgView.layer.masksToBounds = maskToBounds
 }

struct ScreenSize
{
   static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
   static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
   static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
   static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

func isValidPassword(mypassword : String) -> Bool
{
    let passwordreg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&*]).{8,}")
    let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
    return passwordtesting.evaluate(with: mypassword)
}

func isValidMobileNumber(mobileNumber: String) -> Bool {
    let mobileregex = ("^[0-9]{10}$")
    let mobilePred = NSPredicate(format: "SELF MATCHES %@", mobileregex)
    return mobilePred.evaluate(with: mobileNumber)
}

func isValidPanNumber(adhar:String) -> Bool {
    let adharRegex = ("[A-Z]{5}[0-9]{4}[A-Z]{1}")
    let mobilePred = NSPredicate(format: "SELF MATCHES %@", adharRegex)
    return mobilePred.evaluate(with: adhar)
}

func isValidAdharNumber(adhar:String) -> Bool {
    let adharRegex = ("^[0-9]{4}[0-9]{4}[0-9]{4}$")
    let mobilePred = NSPredicate(format: "SELF MATCHES %@", adharRegex)
    return mobilePred.evaluate(with: adhar)
}
//"[A-Z]{5}[0-9]{4}[A-Z]{1}"
extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        return result
    }
}

// Function For Get Status From Api
func getStatus(stausString: String) -> (UIColor) {
    switch stausString {
    case "SUCCESS":
        return UIColor.systemGreen
    case "READY":
        return UIColor.systemGreen
    case "CANCELLED":
        return UIColor.red
    case "PARTIALLY_CANCELLED":
        return UIColor.red
    case "DISPATCHED":
        return UIColor.systemGreen
    case "RETURNING":
        return UIColor.blue
    case "PARTIALLY_RETURNING":
        return UIColor.blue
    case "RETURNED":
        return UIColor.blue
    case "PARTIALLY_RETURNED":
        return UIColor.blue
    case "DELIVERED":
        return  UIColor.systemGreen
    case "PENDING":
        return  UIColor.blue
    case "FAILURE":
        return UIColor.red
    case "FAILED":
        return UIColor.red
    case "RETURNING_ACCEPTED":
        return UIColor.systemGreen
    default :
        break
    }
    return UIColor.black
}

// Transaction Type
func transactionType(transactionType: String) -> (UIColor) {
    switch transactionType {
    case "DEBIT":
        return UIColor.red
    case "CREDIT":
        return UIColor.systemGreen
    default:
        break
    }
    return UIColor.black
}

// Purchase Type
func purchaseType(purchaseType: String) -> String {
    switch purchaseType {
    case "TRANSFER":
        return "Money Transferred Successfully"
    case "SHOPPING":
        return "Online Shopping"
    case "ADDED_MONEY_TO_WALLET":
        return "Money Added Successfully"
    default:
        break
    }
    return ""
}
