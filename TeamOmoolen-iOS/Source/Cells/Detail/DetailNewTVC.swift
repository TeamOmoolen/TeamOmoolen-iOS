//
//  DetailNewTVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/08.
//

import UIKit

class DetailNewTVC: UITableViewCell {
    static let identifier = "DetailNewTVC"
    
    // MARK:- UI Components
    
    @IBOutlet weak var dividerView: UIView!
    
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var moreImageView: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Local Variables
    
    private var recommendList: [RecommendLensDataModel] = []
    var delegate: ViewModalProtocol?
    
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

// MARK: - Custom Methods

extension DetailNewTVC {
    func setUI() {
        dividerView.backgroundColor = .omAlmostwhite
        
        guideLabel.numberOfLines = 2
        guideLabel.text = "인기 신제품을 \n추천해드릴게요."
        guideLabel.textColor = .omMainBlack
        guideLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)
        
        moreImageView.image = UIImage(named: "icFrontBlack")
        
        let moreTapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpMore(_:)))
        moreImageView.addGestureRecognizer(moreTapGesture)
    }
    
    func setList() {
        recommendList.append(contentsOf: [
            RecommendLensDataModel(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: [111111]),
            RecommendLensDataModel(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: [111111]),
            RecommendLensDataModel(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: [111111]),
            RecommendLensDataModel(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: [111111]),
            RecommendLensDataModel(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: [111111]),
            RecommendLensDataModel(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: [111111])
        ])
    }
    
    func registerXib() {
        let recommendNib = UINib(nibName: RecommendCVC.identifier, bundle: nil)
        collectionView.register(recommendNib, forCellWithReuseIdentifier: RecommendCVC.identifier)
    }
    
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.showsHorizontalScrollIndicator = false
    }
}

// MARK: - Action Methods

extension DetailNewTVC {
    @objc
    func touchUpMore(_ sender: UITapGestureRecognizer) {
        print("clicked")
        guard let suggestVC = UIStoryboard(name: Const.Storyboard.Name.Suggest, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Suggest) as? SuggestVC else {
            return
        }
        suggestVC.modalPresentationStyle = .fullScreen
        suggestVC.modalTransitionStyle = .crossDissolve
        self.delegate?.suggestViewModalDelegate(dvc: suggestVC)
    }
}

// MARK: - UICollectionView Delegate

extension DetailNewTVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = UIStoryboard(name: Const.Storyboard.Name.Detail, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Detail) as? DetailVC else {
            return
        }
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.modalTransitionStyle = .crossDissolve
        delegate?.detailViewModalDelegate(dvc: detailVC)
    }
}

// MARK: - UICollectionView DelegateFlowLayout

extension DetailNewTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 138, height: 249)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
}

// MARK: - UICollectionView DataSource

extension DetailNewTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCVC.identifier, for: indexPath) as? RecommendCVC else {
            return UICollectionViewCell()
        }
        let data = recommendList[indexPath.row]
        cell.initCell(brandName: data.brandName, lensName: data.lensName, diameter: data.diameter, cycle: data.cycle, pieces: data.pieces, price: data.price, colorList: data.colorList)
        return cell
    }
}
