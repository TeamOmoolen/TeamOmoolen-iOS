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
    var popularList = [PopularList]()
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
    
    func registerXib() {
        let recommendNib = UINib(nibName: PopularCVC.identifier, bundle: nil)
        collectionView.register(recommendNib, forCellWithReuseIdentifier: PopularCVC.identifier)
    }
    
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func initCell(data: [PopularList]) {
        popularList = data
        collectionView.reloadData()
    }
}

// MARK: - Action Methods

extension DetailNewTVC {
    @objc
    func touchUpMore(_ sender: UITapGestureRecognizer) {
        
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
//        detailVC.id = popularList[indexPath.row].id
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
        return popularList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCVC.identifier, for: indexPath) as? PopularCVC else {
            return UICollectionViewCell()
        }
        let data = popularList[indexPath.row]
        cell.initCell(imageList: data.imageList, brandName: data.brand, lensName: data.name, diameter: data.diameter, minCycle: data.changeCycleMinimum, maxCycle: data.changeCycleMaximum, pieces: data.pieces)
        return cell
    }
}
