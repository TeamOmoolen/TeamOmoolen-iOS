//
//  DetailRecommendTVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/08.
//

import UIKit

class DetailSimilarTVC: UITableViewCell {
    static let identifier = "DetailSimilarTVC"

    // MARK: - UI Components
    
    @IBOutlet weak var dividerView: UIView!
    
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Local Variables
    var suggestList: [SuggestList]?
    var delegate: ViewModalProtocol?
    
    // MARK: - Life Cycle Methdos
    
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

extension DetailSimilarTVC {
    func setUI() {
        dividerView.backgroundColor = .omAlmostwhite
        
        guideLabel.numberOfLines = 2
        guideLabel.text = "위 상품과 비슷한 \n추천 상품을 준비했어요."
        guideLabel.textColor = .omMainBlack
        guideLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)
    }
    
    
    func registerXib() {
        let nib = UINib(nibName: SeasonCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: SeasonCVC.identifier)
    }
    
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.isScrollEnabled = false
    }
}

// MARK: - UICollectionView Delegate

extension DetailSimilarTVC: UICollectionViewDelegate {
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

extension DetailSimilarTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 40 - 15) / 2
        let height = (collectionView.frame.height - 44) / 2
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

// MARK: - UICollectionView DataSource

extension DetailSimilarTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeasonCVC.identifier, for: indexPath) as? SeasonCVC else {
            return UICollectionViewCell()
        }
        let data = suggestList?[indexPath.row]
        
        return cell
    }
}
