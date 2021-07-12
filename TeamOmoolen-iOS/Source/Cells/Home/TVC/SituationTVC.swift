//
//  TimeRecommend.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/05.
//

import UIKit

class SituationTVC: UITableViewCell {
    static let identifier = "SituationTVC"
    
    // MARK: - UI Components
    
    @IBOutlet weak var dividerView: UIView!
    
    @IBOutlet weak var timeRecommendLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var moreImageView: UIImageView!
    
    @IBOutlet weak var timeRecommendCollectionView: UICollectionView!
    
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

extension SituationTVC {
    func setUI() {
        contentView.backgroundColor = .white
        
        dividerView.backgroundColor = .omAlmostwhite
        
        timeRecommendLabel.text = "운동할 때 끼기 좋은 렌즈"
        timeRecommendLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpMore(_:)))
        
        moreButton.setTitle("더보기", for: .normal)
        moreButton.tintColor = .omFourthGray
        moreButton.addTarget(self, action: #selector(touchUpMore(_:)), for: .touchUpInside)
        
        moreImageView.image = UIImage(named: "icFront")
        moreImageView.addGestureRecognizer(tapGesture)
        moreImageView.isUserInteractionEnabled = true
    }
    
    func setList() {
        recommendList.append(contentsOf: [
            RecommendLensDataModel(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"])
        ])
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

// MARK: - Action Methods

extension SituationTVC {
    @objc
    func touchUpMore(_ sender: UITapGestureRecognizer) {
        guard let suggestVC = UIStoryboard(name: Const.Storyboard.Name.Suggest, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Suggest) as? SuggestVC else {
            return
        }
        suggestVC.modalPresentationStyle = .fullScreen
        suggestVC.modalTransitionStyle = .crossDissolve
        suggestVC.passTag(tag: 2)
        self.delegate?.suggestViewModalDelegate(dvc: suggestVC)
    }
}

// MARK: - UICollectionView Delegate

extension SituationTVC: UICollectionViewDelegate {
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

extension SituationTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 40 - 15) / 2
        let height = (collectionView.frame.height - 40 - 80) / 3
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

extension SituationTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeasonCVC.identifier, for: indexPath) as? SeasonCVC else {
            return UICollectionViewCell()
        }
        let data = recommendList[indexPath.row]
        cell.initCell(brandName: data.brandName, lensName: data.lensName, diameter: data.diameter, cycle: data.cycle, pieces: data.pieces, price: data.price, colorList: data.colorList)
        return cell
    }
}

