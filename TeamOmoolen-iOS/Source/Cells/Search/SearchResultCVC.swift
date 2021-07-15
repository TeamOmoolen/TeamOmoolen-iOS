//
//  SearchResultCVC.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/15.
//

import UIKit

class SearchResultCVC: UICollectionViewCell {
    static let identifier = "SearchResultCVC"
    
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
    extension SearchResultCVC {
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
            lensNameLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 12)
            
            lensNameLabel.numberOfLines = 2
            lensNameLabel.lineBreakMode = .byTruncatingTail
            lensInfoLabel.text = "직경 / 교체시기"
            lensInfoLabel.textColor = .omThirdGray
            lensInfoLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 10)
            
            priceLabel.text = "가격"
            priceLabel.textColor = .omMainBlack
            priceLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 12)
            
            modelImageView.contentMode = .scaleAspectFill
            modelImageView.layer.cornerRadius = 10
            lensImageView.contentMode = .scaleAspectFill
            lensImageView.layer.cornerRadius = lensImageView.frame.height / 2
        }
        
    
    func initCell(imageList: [String], brandName: String, lensName: String, diameter: Double, minCycle: Int, maxCycle: Int, pieces: Int, price: Int, colorList: [String]) {
        let lensString = imageList[0]
        let lensUrl = URL(string: lensString)
        self.lensImageView.kf.setImage(with: lensUrl)
        
        let modelString = imageList[0]
        let modelUrl = URL(string: modelString)
        self.modelImageView.kf.setImage(with: modelUrl)
        
        brandNameLabel.text = brandName
        lensNameLabel.text = lensName
        
        // MARK: - FIX ME : 주기 분기 처리
        
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

extension SearchResultCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 10, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

extension SearchResultCVC: UICollectionViewDataSource {
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

