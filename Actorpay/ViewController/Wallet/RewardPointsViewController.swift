//
//  RewardPointsViewController.swift
//  Actorpay
//
//  Created by iMac on 06/12/21.
//

import UIKit

class RewardPointsViewController: UIViewController {

    //MARK: - Properties -
   
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Life Cycle Functions -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        topCorner(bgView: mainView, maskToBounds: true)
        tableView.delegate = self
        tableView.dataSource = self
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
    
    //Filter Button Action
    @IBAction func filterButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        self.addChild(popOverConfirmVC)
        popOverConfirmVC.view.frame = self.view.frame
        self.view.center = popOverConfirmVC.view.center
        self.view.addSubview(popOverConfirmVC.view)
        popOverConfirmVC.didMove(toParent: self)
    }
    
    //MARK: - Helper Functions -
    
}

//MARK: - Extension -

//MARK: Table View SetUp
extension RewardPointsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardPointsTableViewCell", for: indexPath) as! RewardPointsTableViewCell
        cell.redeemButtonHandler = {
            self.view.makeToast("Successfully Redeem")
        }
        return cell
    }
    
}
