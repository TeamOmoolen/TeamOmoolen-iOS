//
//  RecommendCVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/05.
//

import UIKit
import Kingfisher

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
        
        modelImageView.contentMode = .scaleAspectFit
        
        lensImageView.contentMode = .scaleAspectFill
        lensImageView.layer.applyShadow(color: .omMainBlack, alpha: 0.4, x: 0, y: 1, blur: 5, spread: 0)
        
        brandNameLabel.text
         = "오렌즈"
        brandNameLabel.textColor = .omThirdGray
        brandNameLabel.font = UIFont(name: "NotoSansCJKKR-Medium", size: 11)
        
        lensNameLabel.text = "브라운 컬러렌즈"
        lensNameLabel.textColor = .omMainBlack
        lensNameLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 14)
        
        lensInfoLabel.text = "11.9 mm / 1Day(10p)"
        lensInfoLabel.textColor = .omThirdGray
        lensInfoLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 11)
        
        priceLabel.text = "18,000원"
        priceLabel.textColor = .omMainBlack
        priceLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 14)
        
    }
    
    func initCell(imageList: [String], brandName: String, lensName: String, diameter: Double, minCycle: Int, maxCycle: Int, pieces: Int, price: Int, colorList: [String]) {
        let lensURL = URL(string: imageList[0])
        lensImageView.kf.setImage(with: lensURL)
        
        self.lensImageView.layer.cornerRadius = lensImageView.frame.width / 2
        self.lensImageView.layer.masksToBounds = true
        
        let modelURL = URL(string: imageList[1])
        modelImageView.kf.setImage(with: modelURL)
        
        brandNameLabel.text = brandName
        lensNameLabel.text = lensName
        lensNameLabel.lineBreakMode = .byTruncatingTail
        
        var cycleData = ""
        if minCycle == maxCycle {
            if minCycle < 7 { cycleData = "\(minCycle)Day" }
            else if minCycle < 30 { cycleData = "\(minCycle/7)Week" }
            else { cycleData = "\(minCycle/30)Month" }
        } else if maxCycle < 7 {
            cycleData = "\(minCycle)~\(maxCycle)Days"
        } else if maxCycle < 30 {
            cycleData = "\(minCycle/7)~\(maxCycle/7)Weeks"
        } else if maxCycle > 30 {
            if minCycle/30 >= 6 { cycleData = "6months+" }
            else {cycleData = "\(minCycle/30)~\(maxCycle/30)Months"}
        }
        lensInfoLabel.text = "\(diameter)mm / \(cycleData)(\(pieces)p)"
                         
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        priceLabel.text = "\(formatter.string(from: NSNumber(value: price))!)원"
        
        self.colorList = colorList
        colorListCollectionView.reloadData()
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
