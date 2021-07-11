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
    
    // MARK: - Local Variables
    
    var delegate: ViewModalProtocol?

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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpMore(_:)))
        
        moreButton.setTitle("더보기", for: .normal)
        moreButton.tintColor = .omFourthGray
        moreButton.addTarget(self, action: #selector(touchUpMore(_:)), for: .touchUpInside)
        
        moreImageView.image = UIImage(named: "icFront")
        moreImageView.addGestureRecognizer(tapGesture)
        moreImageView.isUserInteractionEnabled = true
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

// MARK: - Action Methods

extension NewLensTVC {
    @objc
    func touchUpMore(_ sender: UITapGestureRecognizer) {
        guard let suggestVC = UIStoryboard(name: Const.Storyboard.Name.Suggest, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Suggest) as? SuggestVC else {
            return
        }
        suggestVC.modalPresentationStyle = .fullScreen
        suggestVC.modalTransitionStyle = .crossDissolve
        suggestVC.passTag(tag: 3)
        self.delegate?.suggestViewModalDelegate(dvc: suggestVC)
    }
}

// MARK: - UICollectionView DelegateFlowLayout

extension NewLensTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20 - 31)
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
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

// MARK: - UICollectionView DataSource

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


