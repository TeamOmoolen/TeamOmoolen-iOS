//
//  SituationVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/09.
//

import UIKit

class SituationVC: UIViewController {

    //MARK: - IB Outlets
    @IBOutlet weak var popTopView: UIView!
    @IBOutlet weak var popMiddleView: UIView!
    @IBOutlet weak var popLabel: UILabel!
    @IBOutlet weak var popBottomView: UIView!
    @IBOutlet weak var sectionDivider: UIView!
    @IBOutlet weak var situationCollectionView:
        UICollectionView!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var popUpButton: UIButton!
    
    //MARK: - Local Variables
    private var recommendList: [RecommendLensDataModel] = []
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setRecommendList()
        registerXib()
        setCollectionViewDelegate()
        setNotification()
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
        
        popup.modalPresentationStyle = .overCurrentContext
        popup.modalTransitionStyle = . crossDissolve
        
        self.present(popup, animated: true, completion: nil)
    }
    @IBAction func presentSortModal(_ sender: Any) {
        let vc = UIStoryboard(name: Const.Storyboard.Name.SortPanModal, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.SortPanModal) as! SortPanModalVC
        presentPanModal(vc)
    }
    
    //MARK: - functions
    func setUI()  {
        popTopView.backgroundColor = .omFifthGray
        //서버에서 받아올 수도
        popLabel.text = "선택한 상황에 적절한 렌즈를 모아봤어요"
        popLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 10)
        popLabel.textColor = .omThirdGray
        
        popBottomView.backgroundColor = .omFifthGray
        sectionDivider.backgroundColor = .omAlmostwhite
        
        popUpButton.setImage(UIImage(named: "btnQuestionmark"), for: .normal)
    }
    
    func registerXib() {
        let recommedNib = UINib(nibName: RecommendCVC.identifier, bundle: nil)
        situationCollectionView.register(recommedNib, forCellWithReuseIdentifier: RecommendCVC.identifier)
    }
    
    func setRecommendList(){
        recommendList.append(contentsOf: [
            RecommendLensDataModel(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
            RecommendLensDataModel(brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, cycle: 1, pieces: 10, price: 18000, colorList: ["green"])
        ])
    }
    
    func setCollectionViewDelegate(){
        situationCollectionView.delegate = self
        situationCollectionView.dataSource = self
    }
    
    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(setPriceLowOrder), name: Notification.Name("SetLowOrder"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setPriceHighOrder), name: Notification.Name("SetHighOrder"), object: nil)
    }
    
    // MARK: - @objc Methods
    @objc
    func setPriceLowOrder() {
        print("setPriceLowOrder()")
//        resultList.sort(by: {$0.price < $1.price})
//        resultCollectionView.reloadData()
    }
    
    @objc
    func setPriceHighOrder() {
        print("setPriceHighOrder")
//        resultList.sort(by: {$0.price > $1.price})
//        resultCollectionView.reloadData()
    }
    
}

//MARK: - UICollectionView Delegate
extension SituationVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = UIStoryboard(name: Const.Storyboard.Name.Detail, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Detail) as? DetailVC else {
            return
        }
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SituationVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 40 - 15) / 2
        let height = (collectionView.frame.height - 120) / 2
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

extension SituationVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendList.count
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
