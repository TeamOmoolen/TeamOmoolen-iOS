//
//  SeasonTVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/04.
//

import UIKit

class SeasonTVC: UITableViewCell {
    static let identifier = "SeasonTVC"
    
    // MARK: - UI Components
    
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var moreImageView: UIImageView!
    
    @IBOutlet weak var seasonCollectionView: UICollectionView!
    
    // MARK: - Local Variables
    
    private var seasonList: [RecommendLens] = []
    
    // MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
        setList()
        registerXib()
        setCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension SeasonTVC {
    func setUI() {
        contentView.backgroundColor = .white
        
        dividerView.backgroundColor = .omAlmostwhite
        
        seasonLabel.text = "여름에 끼기 좋은 렌즈"
        seasonLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)
        
        moreButton.setTitle("더보기", for: .normal)
        moreButton.tintColor = .omFourthGray
        
        moreImageView.image = UIImage(named: "abc")
    }
    
    func setList() {
        seasonList.append(contentsOf: [
            RecommendLens(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: "1Day(10p)", price: 18000),
            RecommendLens(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: "1Day(10p)", price: 18000),
            RecommendLens(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: "1Day(10p)", price: 18000),
            RecommendLens(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: "1Day(10p)", price: 18000),
            RecommendLens(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: "1Day(10p)", price: 18000),
            RecommendLens(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: "1Day(10p)", price: 18000)
        ])
    }
    
    func initCell() {
        
    }
    
    func registerXib() {
        let seasonNib = UINib(nibName: SeasonCVC.identifier, bundle: nil)
        seasonCollectionView.register(seasonNib, forCellWithReuseIdentifier: SeasonCVC.identifier)
    }
    
    func setCollectionView() {
        seasonCollectionView.delegate = self
        seasonCollectionView.dataSource = self
        
        seasonCollectionView.isScrollEnabled = false
    }
}

extension SeasonTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 40 - 15) / 2
        return CGSize(width: width, height: 275)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 20, bottom: 0, right: 20)
    }
}

extension SeasonTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeasonCVC.identifier, for: indexPath) as? SeasonCVC else {
            return UICollectionViewCell()
        }
        let data = seasonList[indexPath.row]
        cell.initCell(brandName: data.brandName, lensName: data.lensName, diameter: data.diameter, cycle: data.cycle, price: data.price)
        return cell
    }
}

