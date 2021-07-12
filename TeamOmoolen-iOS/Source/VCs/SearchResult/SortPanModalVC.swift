//
//  SortPanModalVC.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/11.
//

import UIKit
import PanModal

class SortPanModalVC: UIViewController {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var sortTitleLabel: UILabel!
    @IBOutlet weak var firstSortLabel: UILabel!
    @IBOutlet weak var secondSortLabel: UILabel!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTapAction()
    }
    
    // MARK: - Methods
    private func setUI() {
        sortTitleLabel.text = "정렬"
        sortTitleLabel.font = UIFont(name: "NotoSansCJKKR-Medium", size: 18)
        sortTitleLabel.textColor = .omMainBlack
        
        firstSortLabel.text = "가격낮은순"
        firstSortLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 16)
        firstSortLabel.textColor = .omThirdGray
        
        secondSortLabel.text = "가격높은순"
        secondSortLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 16)
        secondSortLabel.textColor = .omThirdGray
    }
    
    func setTapAction() {
        let sortPriceLowOrder = UITapGestureRecognizer(target: self, action: #selector(setLowOrder))
        firstSortLabel.isUserInteractionEnabled = true
        firstSortLabel.addGestureRecognizer(sortPriceLowOrder)
        
        let sortPriceHighOrder = UITapGestureRecognizer(target: self, action: #selector(setHighOrder))
        secondSortLabel.isUserInteractionEnabled = true
        secondSortLabel.addGestureRecognizer(sortPriceHighOrder)
    }

    // MARK: - @objc Methods
    @objc
    func setLowOrder() {
        NotificationCenter.default.post(name: Notification.Name("SetLowOrder"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func setHighOrder() {
        NotificationCenter.default.post(name: Notification.Name("SetHighOrder"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - PanModalPresentable
extension SortPanModalVC: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(246)
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(100)
    }
}
