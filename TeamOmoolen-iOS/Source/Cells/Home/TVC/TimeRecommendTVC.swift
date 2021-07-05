//
//  TimeRecommend.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/05.
//

import UIKit

class TimeRecommendTVC: UITableViewCell {
    static let identifier = "TimeRecommendTVC"
    
    // MARK: - UI Components
    
    @IBOutlet weak var dividerView: UIView!
    
    @IBOutlet weak var timeRecommendLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var moreImageView: UIImageView!
    
    @IBOutlet weak var timeRecommendCollectionView: UICollectionView!
    
    // MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
        registerXib()
        setCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension TimeRecommendTVC {
    func setUI() {
        contentView.backgroundColor = .white
        
        dividerView.backgroundColor = .omAlmostwhite
        
        timeRecommendLabel.text = "운동할 때 끼기 좋은 렌즈"
        timeRecommendLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)
        
        moreButton.setTitle("더보기", for: .normal)
        moreButton.tintColor = .omFourthGray
        
        moreImageView.image = UIImage(named: "abc")
    }
    
    func initCell() {
        
    }
    
    func registerXib() {
        let timeRecommendNib = UINib(nibName: SeasonCVC.identifier, bundle: nil)
        timeRecommendCollectionView.register(timeRecommendNib, forCellWithReuseIdentifier: SeasonCVC.identifier)
    }
    
    func setCollectionView() {
        timeRecommendCollectionView.delegate = self
        timeRecommendCollectionView.dataSource = self
        
        timeRecommendCollectionView.isScrollEnabled = false
    }
}

extension TimeRecommendTVC: UICollectionViewDelegateFlowLayout {
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

extension TimeRecommendTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeasonCVC.identifier, for: indexPath) as? SeasonCVC else {
            return UICollectionViewCell()
        }
        return cell
    }
}

