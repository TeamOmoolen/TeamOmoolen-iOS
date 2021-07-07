//
//  DetailTopTVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/08.
//

import UIKit

class DetailTopTVC: UITableViewCell {
    static let identifier = "DetailTopTVC"

    // MARK: - UI Components
    @IBOutlet weak var modelImageView: UIImageView!
    @IBOutlet weak var lensImageView: UIImageView!
    
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var lensLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var dividerView: UIView!
    
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var lensDiameterLabel: UILabel!
    
    @IBOutlet weak var cycleLabel: UILabel!
    @IBOutlet weak var lensCycleLabel: UILabel!
    
    @IBOutlet weak var textureLabel: UILabel!
    @IBOutlet weak var lensTextureLabel: UILabel!
    
    @IBOutlet weak var functionLabel: UILabel!
    @IBOutlet weak var lensFunctionLabel: UILabel!
    
    @IBOutlet weak var colorLabel: UILabel!
    
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var compareButton: UIButton!
    
    
    // MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension DetailTopTVC {
    func setUI() {
        // MARK: - Label UI
        
        // 동적 라벨
        brandLabel.text = "오렌즈"
        brandLabel.textColor = .omThirdGray
        brandLabel.font = UIFont(name: "NotoSansCJKKR-Medium", size: 14)
        
        lensLabel.text = "브라운 컬러렌즈"
        lensLabel.textColor = .omMainBlack
        lensLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 20)
        
        priceLabel.text = "18,000원"
        priceLabel.textColor = .omMainBlack
        priceLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)
        
        dividerView.backgroundColor = .omFifthGray
        
        lensDiameterLabel.text = "13.5mm"
        lensDiameterLabel.textColor = .omThirdGray
        lensDiameterLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        
        lensCycleLabel.text = "1Month"
        lensCycleLabel.textColor = .omThirdGray
        lensCycleLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        
        lensTextureLabel.text = "실리콘 하이드로젤"
        lensTextureLabel.textColor = .omThirdGray
        lensTextureLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        
        lensFunctionLabel.text = "난시"
        lensFunctionLabel.textColor = .omThirdGray
        lensFunctionLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        
        // 정적 라벨
        diameterLabel.text = "직경"
        diameterLabel.textColor = .omMainBlack
        diameterLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 14)
        
        cycleLabel.text = "주기"
        cycleLabel.textColor = .omMainBlack
        cycleLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 14)
        
        textureLabel.text = "재질"
        textureLabel.textColor = .omMainBlack
        textureLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 14)
        
        functionLabel.text = "기능"
        functionLabel.textColor = .omMainBlack
        functionLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 14)
        
        colorLabel.text = "컬러"
        colorLabel.textColor = .omMainBlack
        colorLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 14)
        
        
        // MARK: - Button UI
        
        myButton.backgroundColor = .omFifthGray
        myButton.tintColor = .omThirdGray
        myButton.setTitle("찜하기", for: .normal)
        myButton.layer.cornerRadius = 10
        myButton.layer.masksToBounds = true
        
        compareButton.backgroundColor = .omFifthGray
        compareButton.tintColor = .omThirdGray
        compareButton.setTitle("보관함 비교", for: .normal)
        compareButton.layer.cornerRadius = 10
        compareButton.layer.masksToBounds = true
    }
    
    func initCell() {
        
    }
}
