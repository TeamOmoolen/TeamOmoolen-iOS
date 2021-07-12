//
//  RecommendCVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/05.
//

import UIKit

class RecommendCVC: UICollectionViewCell {
    static let identifier = "RecommendCVC"
    
    // MARK: - UI Components
    
    @IBOutlet weak var modelImageView: UIImageView!
    @IBOutlet weak var lensImageView: UIImageView!
    
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var lensNameLabel: UILabel!
    @IBOutlet weak var lensInfoLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var colorListCollectionView: UICollectionView!
    
    // MARK: - Local Variables
    
    private var colorList = [String]()
    
    // MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
        registerXib()
        setCollectionView()
    }

}

extension RecommendCVC {
    func setUI() {
        contentView.backgroundColor = .white
        modelImageView.image = UIImage(named: "abc")
        lensImageView.image = UIImage(named: "abc")
        
        brandNameLabel.text
         = "브랜드명"
        brandNameLabel.textColor = .omThirdGray
        brandNameLabel.font = UIFont(name: "NotoSansCJKKR-Medium", size: 11)
        
        lensNameLabel.text = "렌즈명"
        lensNameLabel.textColor = .omMainBlack
        lensNameLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 14)
        
        lensInfoLabel.text = "직경 / 교체시기"
        lensInfoLabel.textColor = .omThirdGray
        lensInfoLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 12)
        
        priceLabel.text = "가격"
        priceLabel.textColor = .omMainBlack
        priceLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 16)
        
    }
    
    func initCell(brandName: String, lensName: String, diameter: Double, cycle: Int, pieces: Int, price: Int, colorList: [String]) {
        brandNameLabel.text = brandName
        lensNameLabel.text = lensName
        
        // MARK: - FIX ME : 주기 분기 처리
        var cycleData = ""
        if cycle == 0 {
            cycleData = "1Day"
        } else if cycle == 1 {
            cycleData = "1Week"
        } else if cycle == 2 {
            cycleData = "2Week"
        } else if cycle == 3 {
            cycleData = "1Month"
        } else if cycle == 4 {
            cycleData = "2~3Month"
        }
        lensInfoLabel.text = "\(diameter)mm / \(cycleData)(\(pieces)p)"
                         
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        priceLabel.text = "\(formatter.string(from: NSNumber(value: price))!)원"
        
        self.colorList = colorList
    }
    
    func registerXib() {
        let nib = UINib(nibName: ColorListCVC.identifier, bundle: nil)
        colorListCollectionView.register(nib, forCellWithReuseIdentifier: ColorListCVC.identifier)
    }
    
    func setCollectionView() {
        colorListCollectionView.delegate = self
        colorListCollectionView.dataSource = self
    }
}

extension RecommendCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 12, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

extension RecommendCVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorListCVC.identifier, for: indexPath) as? ColorListCVC else {
            return UICollectionViewCell()
        }
        cell.initCell(color: colorList[indexPath.row])
        return cell
    }
}
