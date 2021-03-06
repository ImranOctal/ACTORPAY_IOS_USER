//
//  OfferViewController.swift
//  Actorpay
//
//  Created by iMac on 04/01/22.
//

import UIKit
import Alamofire
import SVPullToRefresh
import Lottie

class OfferViewController: UIViewController {
    
    //MARK: - Properties -

    @IBOutlet weak var tblView: UITableView! {
        didSet {
            tblView.delegate = self
            tblView.dataSource = self
        }
    }
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var emptyMessageView: UIView!
    @IBOutlet weak var animationView: AnimationView!
    
    var page = 0
    var totalCount = 10
    var couponData: ProductList?
    var couponList: [Items] = []
    
    //MARK: - Life Cycles -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topCorner(bgView: bgView, maskToBounds: true)
        self.getCouponList()
        tblView.addPullToRefresh {
            self.page = 0
            self.getCouponList()
        }
        self.setEmptyCartLottieAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Selectors -
    
    // Menu Button Action
    @IBAction func menuButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        self.sideMenuViewController?.presentLeftMenuViewController()
    }
    
    // Cart Button Action
    @IBAction func cartButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    //MARK: - Helper Functions -
    
    // Set Empty Cart Lottie Animation
    func setEmptyCartLottieAnimation() {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
    }
    
}

//MARK: - Extensions -

//MARK: Api Call
extension OfferViewController {
    
    // Get Coupon List Api
    func getCouponList() {
        let params: Parameters = [
            "pageNo": page,
            "pageSize": 10,
            "sortBy": "createdAt",
            "asc": true
        ]
        print(params)
        showLoading()
        APIHelper.getAvailableOfferForCustomer(params: params) { (success, response) in
            self.tblView.pullToRefreshView?.stopAnimating()
            if !success {
                dissmissLoader()
                let message = response.message
                print(message)
                self.view.makeToast(message)
            }else {
                dissmissLoader()
                let data = response.response["data"]
                self.couponData = ProductList.init(json: data)
                if (self.page == 0) {
                    self.couponList = self.couponData?.items ?? []
                } else{
                    self.couponList.append(contentsOf: self.couponData?.items ?? [])
                }
                self.totalCount = self.couponData?.totalItems ?? 0
                if self.couponList.count == 0 {
                    self.emptyMessageView.isHidden = false
                } else {
                    self.emptyMessageView.isHidden = true
                }
                self.tblView.reloadData()
            }
        }
    }
    
}

//MARK: TableView SetUp
extension OfferViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if self.couponList.count == 0 {
//            tableView.setEmptyMessage("No Data Found.")
//        } else {
//            tableView.restore()
//        }
        return self.couponList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OfferTableViewCell", for: indexPath) as! OfferTableViewCell
        let offer = self.couponList[indexPath.row]
        cell.offer = offer
        cell.copyButtonHandler = { sender in
            sender.tag = indexPath.row
            UIPasteboard.general.string = cell.offerCodeLbl.text
            self.view.makeToast("Code has been copied.")
        }
        return cell
    }
}

// MARK: ScrollView Setup
extension OfferViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let totalRecords = self.couponList.count ?? 0
        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 10.0 && /*totalRecords >= 10*/totalRecords < totalCount {
            if page < ((self.couponData?.totalPages ?? 0)-1) {
                page += 1
                self.getCouponList()
            }
        }
    }
    
}
