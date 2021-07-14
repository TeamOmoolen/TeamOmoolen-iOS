//
//  SeasonVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/09.
//

import UIKit

class SeasonVC: UIViewController {

    
    //MARK: - IB Outlets
    @IBOutlet weak var popUpTopView: UIView!
    @IBOutlet weak var popUpMiddleView: UIView!
    @IBOutlet weak var popUpLabel: UILabel!
    @IBOutlet weak var popUpButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var seasonCollectionView: UICollectionView!
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
        if (UIDevice.current.isiPhone12Pro) {
            print("this is iphone 12")
        }
    }
    // MARK: - @IBAction Properties
    @IBAction func presentToPopupModal(_ sender: Any) {
        guard let popup = UIStoryboard(name: Const.Storyboard.Name.PopupModal, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.PopupModal) as? PopupModalVC else {
            return
        }
        popup.titleText = "여름과 잘 어울리는 렌즈"
        
        popup.subtitleText = """
                여름과 잘 어울리는 렌즈 추천은 계절별 많이
                구매한 제품에 대한 데이터를 기반으로
                추천해드리는 제품입니다.
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
    func setUI() {
        popUpTopView.backgroundColor = .omFifthGray
        //서버에서 받아올 수도
        popUpLabel.text = "여름과 잘 어울리는 렌즈를 추천해드릴게요"
        popUpLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 10)
        popUpLabel.textColor = .omThirdGray
        popUpButton.setImage(UIImage(named: "btnQuestionmark"), for: .normal)
        
    }
    
    func registerXib(){
        let recommedNib = UINib(nibName: RecommendCVC.identifier, bundle: nil)
        seasonCollectionView.register(recommedNib, forCellWithReuseIdentifier: RecommendCVC.identifier)
    }
    
    func setRecommendList(){
        recommendList.append(contentsOf: [
            RecommendLensDataModel(imageList: ["abc"], brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, minCycle: 1, maxCycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(imageList: ["abc"], brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, minCycle: 1, maxCycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(imageList: ["abc"], brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, minCycle: 1, maxCycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(imageList: ["abc"], brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, minCycle: 1, maxCycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(imageList: ["abc"], brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, minCycle: 1, maxCycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(imageList: ["abc"], brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, minCycle: 1, maxCycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(imageList: ["abc"], brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, minCycle: 1, maxCycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(imageList: ["abc"], brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, minCycle: 1, maxCycle: 1, pieces: 10, price: 18000, colorList: ["green"])
        ])
    }
    
    func setCollectionViewDelegate(){
        seasonCollectionView.delegate = self
        seasonCollectionView.dataSource = self
    }
    
    func setPhoneResolution() {
        if UIDevice.current.isiPhoneSE2 {
            popUpTopConstraint.constant = 0
        } else if UIDevice.current.isiPhone12Pro {
            popUpTopConstraint.constant = 46
        }
    }
    
}

//MARK: - CollectionViewDelegateFlowLayout
extension SeasonVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (UIDevice.current.isiPhone12Pro) {
            return CGSize(width:(collectionView.frame.width - 100) / 2, height:(collectionView.frame.height - 40) / 2)
        }
        let width = (collectionView.frame.width - 40 - 15) / 2
        let height = (collectionView.frame.height-40)/2
    
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 200, right: 20)
    }
}

// MARK: - UICollectionView DataSource
extension SeasonVC: UICollectionViewDataSource {
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
