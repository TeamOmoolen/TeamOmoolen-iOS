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
    
    // MARK: - Local Variables
    
    private var username: String? = nil
    private var list = [RecommendationBy]()
    
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

extension RecommendTVC {
    func setUI() {
        contentView.backgroundColor = .white
        
        recommendLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpMore(_:)))
        
        moreButton.setTitle("더보기", for: .normal)
        moreButton.tintColor = .omFourthGray
        moreButton.addTarget(self, action: #selector(touchUpMore(_:)), for: .touchUpInside)
        
        moreImageView.image = UIImage(named: "icFront")
        moreImageView.addGestureRecognizer(tapGesture)
        moreImageView.isUserInteractionEnabled = true
    }
    
    
    func registerXib() {
        let recommendNib = UINib(nibName: RecommendCVC.identifier, bundle: nil)
        recommendCollectionView.register(recommendNib, forCellWithReuseIdentifier: RecommendCVC.identifier)
    }
    
    func setCollectionView() {
        recommendCollectionView.delegate = self
        recommendCollectionView.dataSource = self
        
        recommendCollectionView.showsHorizontalScrollIndicator = false
    }
    
    func initCell(name: String, data : [RecommendationBy]){
        username = name
        recommendLabel.text = "\(username!)님! 이 렌즈 어때요?"

        list = data
        recommendCollectionView.reloadData()
    }
}

// MARK: - Action Methods

extension RecommendTVC {
    @objc
    func touchUpMore(_ sender: UITapGestureRecognizer) {
        guard let suggestVC = UIStoryboard(name: Const.Storyboard.Name.Suggest, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Suggest) as? SuggestVC else {
            return
        }
        suggestVC.modalPresentationStyle = .fullScreen
        suggestVC.modalTransitionStyle = .crossDissolve
        let position = 0
        NotificationCenter.default.post(name: NSNotification.Name("ChangeIndex"), object: position)
    }
}

// MARK: - UICollectionView Delegate

extension RecommendTVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = UIStoryboard(name: Const.Storyboard.Name.Detail, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Detail) as? DetailVC else {
            return
        }
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.modalTransitionStyle = .crossDissolve
        detailVC.id = list[indexPath.row].id
        delegate?.detailViewModalDelegate(dvc: detailVC)
    }
}

// MARK: - UICollectionView DelegateFlowLayout

extension RecommendTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 100) / 2
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
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

extension RecommendTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCVC.identifier, for: indexPath) as? RecommendCVC else {
            return UICollectionViewCell()
        }
        let data = list[indexPath.row]
        cell.initCell(imageList: data.imageList, brandName: data.brand, lensName: data.name, diameter: data.diameter, minCycle: data.changeCycleMinimum, maxCycle: data.changeCycleMaximum, pieces: data.pieces, price: data.price, colorList: data.otherColorList)
        return cell
    }
}
