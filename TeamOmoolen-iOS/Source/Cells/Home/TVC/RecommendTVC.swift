//
//  RecommendTVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/04.
//

import UIKit

class RecommendTVC: UITableViewCell {
    static let identifier = "RecommendTVC"
    
    // MARK: - UI Components
    
    @IBOutlet weak var recommendLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var moreImageView: UIImageView!
    
    @IBOutlet weak var recommendCollectionView: UICollectionView!
    
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

extension RecommendTVC {
    func setUI() {
        contentView.backgroundColor = .white
        
        recommendLabel.text = "오무렌2님! 이 렌즈 어때요?"
        recommendLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)
        
        moreButton.setTitle("더보기", for: .normal)
        moreButton.tintColor = .omFourthGray
        
        moreImageView.image = UIImage(named: "abc")
    }
    
    func initCell() {
        
    }
    
    func registerXib() {
        let recommendNib = UINib(nibName: RecommendCVC.identifier, bundle: nil)
        recommendCollectionView.register(recommendNib, forCellWithReuseIdentifier: RecommendCVC.identifier)
    }
    
    func setCollectionView() {
        recommendCollectionView.delegate = self
        recommendCollectionView.dataSource = self
    }
}

extension RecommendTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (UIScreen.main.bounds.size.width - 80) / 3
        return CGSize(width: 138, height: 249)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

extension RecommendTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCVC.identifier, for: indexPath) as? RecommendCVC else {
            return UICollectionViewCell()
        }
        return cell
    }
}
