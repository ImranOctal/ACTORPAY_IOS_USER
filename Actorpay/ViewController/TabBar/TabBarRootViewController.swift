//
//  TabBarRootViewController.swift
//  Actorpay
//
//  Created by iMac on 07/12/21.
//

import UIKit

class TabBarRootViewController: UIViewController {
    
    //MARK: - Properties -

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabelStackView: UIStackView!
    @IBOutlet weak var amountLabel: UILabel!
    
    var category:[Category] = [
        Category(title: "Add Money", icon: UIImage(named: "add_money")),
        Category(title: "Send Money", icon: UIImage(named: "send_money")),
        Category(title: "Mobile & DTH", icon: UIImage(named: "smartphone")),
        Category(title: "Utility Bill", icon: UIImage(named: "bill")),
        Category(title: "Online Payment", icon: UIImage(named: "qr-code2")),
        Category(title: "Product List", icon: UIImage(named: "bill"))
    ]
    let contactHeaderHeight: CGFloat = 32
    
    //MARK: - Life Cycles -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        setupMiddleButton()
        NotificationCenter.default.addObserver(self,selector: #selector(self.refreshRightButton),name:Notification.Name("refreshRightButton"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshRightButton()
    }
    
    //MARK: - Selectors -
    
    // Menu Button Action
    @IBAction func menuButtonAction(_ sender: UIButton){
        self.view.endEditing(true)
        self.sideMenuViewController?.presentLeftMenuViewController()
    }
    
    // Notification Button Action
    @IBAction func notificationButtonAction(_ sender: UIButton){
        self.view.endEditing(true)
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    // Cart Button Action
    @IBAction func cartButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    //MARK:- Helper Function -
    
    // Refresh Right Side Button Action
    @objc func refreshRightButton(){
        if selectedTabTag == 0 {
            titleLabel.isHidden = true
            titleLabelStackView.isHidden = false
        }else if selectedTabTag == 1 {
            titleLabel.isHidden = false
            titleLabelStackView.isHidden = true
            titleLabel.text = "Transaction History"
        }else if selectedTabTag == 3 {
            titleLabel.text = "Wallet"
            titleLabelStackView.isHidden = true
            titleLabel.isHidden = false
        }else if selectedTabTag == 4{
            titleLabel.text = "My Profile"
            titleLabelStackView.isHidden = true
            titleLabel.isHidden = false
        }
    }
    
    // Tab Bar Menu Button Action
    @objc private func menuButtonAction(sender: UIButton) {
        //        selectedIndex = 2
        self.view.endEditing(true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeViewController") as! QRCodeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // Set Up Tab Bar Middel Button
    func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = (self.view.bounds.height - menuButtonFrame.height) - ((ScreenSize.SCREEN_MAX_LENGTH >= 812.0) ? 50 : 20)
        menuButtonFrame.origin.x = self.view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        menuButton.layer.shadowColor = UIColor.black.cgColor
        menuButton.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        menuButton.layer.shadowOpacity = 0.5
        menuButton.layer.shadowRadius = 2.0
        menuButton.backgroundColor = UIColor.init(hexFromString: "#2878B6")
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        self.view.addSubview(menuButton)

        menuButton.setImage(UIImage(named: "qr-code"), for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)

        self.view.layoutIfNeeded()
    }
}

//MARK: - Extensions-

//MARK: - Collection View SetUp
extension TabBarRootViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        cell.iconImageView.image = category[indexPath.row].icon
        cell.titleLabel.text = category[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
        collectionView.deselectItem(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddMoneyInWalletViewController") as! AddMoneyInWalletViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeViewController") as! QRCodeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DTHRechageViewController") as! DTHRechageViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UtilityBillViewController") as! UtilityBillViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScanQRCodeViewController") as! ScanQRCodeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}
