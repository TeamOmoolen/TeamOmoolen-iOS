//
//  NewLensTVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/05.
//

import UIKit

class NewLensTVC: UITableViewCell {
    static let identifier = "NewLensTVC"
    
    // MARK: - UI Components
    
    @IBOutlet weak var newLensLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var moreImageView: UIImageView!
    
    @IBOutlet weak var newLensCollectionView: UICollectionView!
    

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

extension NewLensTVC {
    func setUI() {
        contentView.backgroundColor = .white
        
        newLensLabel.text = "요즘 뜨는 신상 렌즈"
        newLensLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)
        
        moreButton.setTitle("더보기", for: .normal)
        moreButton.tintColor = .omFourthGray
        
        moreImageView.image = UIImage(named: "icFront")
    }
    
    func initCell() {
        
    }
    
    func registerXib() {
        let recommendNib = UINib(nibName: NewLensCVC.identifier, bundle: nil)
        newLensCollectionView.register(recommendNib, forCellWithReuseIdentifier: NewLensCVC.identifier)
    }
    
    func setCollectionView() {
        newLensCollectionView.delegate = self
        newLensCollectionView.dataSource = self
        
        newLensCollectionView.showsHorizontalScrollIndicator = false
    }
}

extension NewLensTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (UIScreen.main.bounds.size.width - 80) / 3
        return CGSize(width: 324, height: 640)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 31
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 31
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
}

extension NewLensTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewLensCVC.identifier, for: indexPath) as? NewLensCVC else {
            return UICollectionViewCell()
        }
        return cell
    }
}




