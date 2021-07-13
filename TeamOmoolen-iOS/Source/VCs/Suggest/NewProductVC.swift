//
//  NewProductVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/09.
//

import UIKit

class NewProductVC: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var popUpLabel: UILabel!
    @IBOutlet weak var popUpTopView: UIView!
    @IBOutlet weak var popUpMiddleView: UIView!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var newProductCollectionView: UICollectionView!
    @IBOutlet weak var popUpButton: UIButton!
    @IBOutlet weak var popUpTopConstraint: NSLayoutConstraint!
    
    //MARK: - Local Variables
    private var recommendList: [RecommendLensDataModel] = []
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        registerXib()
        setRecommendList()
        setCollectionViewDelegate()
        setPhoneResolution()

    }
    
    // MARK: - @IBAction Properties
    @IBAction func presentToPopupModal(_ sender: Any) {
        guard let popup = UIStoryboard(name: Const.Storyboard.Name.PopupModal, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.PopupModal) as? PopupModalVC else {
            return
        }
        popup.titleText = "상황에 어울리는 렌즈 추천"
        
        popup.subtitleText = """
        상황에 어울리는 렌즈 추천은 실제 렌즈 사용자들의
        데이터를 기반으로 상황별 맞춤 렌즈를 제공합니다.
        """
        
        popup.modalPresentationStyle = .overFullScreen
        popup.modalTransitionStyle = .crossDissolve
        
        self.present(popup, animated: true, completion: nil)
    }
    
    @IBAction func presentSortModal(_ sender: Any) {
        let vc = UIStoryboard(name: Const.Storyboard.Name.SortPanModal, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.SortPanModal) as! SortPanModalVC
        presentPanModal(vc)
    }
    
    //MARK: - Methods
    func setUI(){
        popUpTopView.backgroundColor = .omFifthGray
        //서버에서 받아올 수도
        popUpLabel.text = "요즘 핫한 신제품을 만나보세요"
        popUpLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 10)
        popUpLabel.textColor = .omThirdGray
                
        //popUpButtomView.backgroundColor = .omFifthGray
        popUpButton.setImage(UIImage(named: "btnQuestionmark"), for: .normal)
        
    }
    
    func registerXib(){
        let recommedNib = UINib(nibName: RecommendCVC.identifier, bundle: nil)
        newProductCollectionView.register(recommedNib, forCellWithReuseIdentifier: RecommendCVC.identifier)
    }
    
    func setRecommendList(){
        recommendList.append(contentsOf: [
            RecommendLensDataModel(imageList: ["abc"], brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(imageList: ["abc"], brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(imageList: ["abc"], brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(imageList: ["abc"], brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(imageList: ["abc"], brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(imageList: ["abc"], brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(imageList: ["abc"], brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(imageList: ["abc"], brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"])
        ])
    }
    
    func setCollectionViewDelegate(){
        newProductCollectionView.delegate = self
        newProductCollectionView.dataSource = self
    }
    
    func setPhoneResolution() {
        if UIDevice.current.isiPhoneSE2 {
            popUpTopConstraint.constant = 0
        }
    }
    
}

extension NewProductVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 40 - 15) / 2
        let height = (collectionView.frame.height - 40) / 2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

// MARK: - UICollectionView DataSource

extension NewProductVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCVC.identifier, for: indexPath) as? RecommendCVC else {
                return UICollectionViewCell()
        }
        let data = recommendList[indexPath.row]
            return cell
        }
}
