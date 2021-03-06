//
//  OneMinTVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/04.
//

import UIKit

class OneMinTVC: UITableViewCell {
    static let identifier = "OneMinTVC"

    // MARK: - UI Components
    
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var moreImageView: UIImageView!
    
    @IBOutlet weak var oneMinCollectionView: UICollectionView!
    
    // MARK: - Local Variables
    var guides = [GuideList]()
    var oneMinDataList = [OneMinDataModel]()
    var oneMinDetailList = [OneMinDetailDataModel]()
    
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

extension OneMinTVC {
    func setUI() {
        contentView.backgroundColor = .white
        
        guideLabel.text = "오무렌과 함께하는 1분 렌즈 상식"
        guideLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpMore(_:)))
        
        moreButton.setTitle("더보기", for: .normal)
        moreButton.tintColor = .omFourthGray
        moreButton.addTarget(self, action: #selector(touchUpMore(_:)), for: .touchUpInside)
        
        moreImageView.image = UIImage(named: "icFront")
        moreImageView.addGestureRecognizer(tapGesture)
        moreImageView.isUserInteractionEnabled = true
    }
    
    func registerXib() {
        let oneMinNib = UINib(nibName: OneMinCVC.identifier, bundle: nil)
        oneMinCollectionView.register(oneMinNib, forCellWithReuseIdentifier: OneMinCVC.identifier)
    }
    
    func setCollectionView() {
        oneMinCollectionView.delegate = self
        oneMinCollectionView.dataSource = self
        
        oneMinCollectionView.showsHorizontalScrollIndicator = false
    }
    
    func initCell(data : [GuideList]){
        self.guides = data
        oneMinCollectionView.reloadData()
    }
}

// MARK: - Action Methods

extension OneMinTVC {
    @objc
    func touchUpMore(_ sender: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: NSNotification.Name("PushToPopUp"), object: nil)
    }
}

// MARK: - UICollectionView DelegateFlowLayout

extension OneMinTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 310, height: 420)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

// MARK: - UICollectionView DataSource

extension OneMinTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OneMinCVC.identifier, for: indexPath) as? OneMinCVC else {
            return UICollectionViewCell()
        }
        let data = guides[indexPath.row]
        cell.initCell(subTitle: data.category, oneMinDetail: data.guides)
        cell.initImage(idx: indexPath.row, imageName: "img1MinHome\(indexPath.row+1)")
        return cell
    }
}
