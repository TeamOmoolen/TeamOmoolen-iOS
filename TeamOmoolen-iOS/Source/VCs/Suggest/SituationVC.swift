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
    @IBOutlet weak var situationCollectionView:
        UICollectionView!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var popUpButton: UIButton!
    @IBOutlet weak var popUpTopConstraint: NSLayoutConstraint!
    
    
    //MARK: - Local Variables
    private var recommendList: [RecommendLensDataModel] = []
    var suggestForSituation: [SuggestProduct]? = nil
    var suggestDetailSituation: SuggestDetailResponse?
    
    var list = [SuggestProduct]()
    var accesstoken = ""
    
    private var currPage: Int = 1
    private var totalPage: Int = -1
    private var canFetchData: Bool = true
    
    private var sort = ""
    private var order = ""
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setRecommendList()
        registerXib()
        setAccesstoken()
        getSuggestSituationWithAPI(accesstoken: accesstoken, page: currPage, sort: sort, order: order)
        setCollectionViewDelegate()
        setNotification()
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
    func setUI()  {
        popTopView.backgroundColor = .omFifthGray
        //서버에서 받아올 수도
        popLabel.text = "선택한 상황에 적절한 렌즈를 모아봤어요"
        popLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 10)
        popLabel.textColor = .omThirdGray
        
        
        popUpButton.setImage(UIImage(named: "btnQuestionmark"), for: .normal)
    }
    
    func setAccesstoken() {
        accesstoken = UserDefaults.standard.string(forKey: "Accesstoken") ?? ""
    }
    
    func registerXib() {
        let recommedNib = UINib(nibName: RecommendCVC.identifier, bundle: nil)
        situationCollectionView.register(recommedNib, forCellWithReuseIdentifier: RecommendCVC.identifier)
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
            RecommendLensDataModel(imageList: ["abc"], brandName: "오렌즈", lensName: "브라운 컬러렌즈", diameter: 11.9, minCycle: 1, maxCycle: 1, pieces: 10, price: 18000, colorList: ["green"]),
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
    
    func setPhoneResolution() {
        if UIDevice.current.isiPhoneSE2 {
            popUpTopConstraint.constant = 0
        } else if UIDevice.current.isiPhone12Pro {
            popUpTopConstraint.constant  = 46
        }
    }
    
    func getSuggestSituationWithAPI(accesstoken: String, page: Int, sort: String, order: String) {
        SuggestAPI.shared.getForyou(accesstoken: accesstoken, page: page, sort: sort, order: order) { response in
            self.suggestDetailSituation = response
            
            var appendList = [SuggestProduct]()
            for i in 0..<(self.suggestDetailSituation?.items.count)! {
                appendList.append(SuggestProduct(id: self.suggestDetailSituation!.items[i].id, imageList: self.suggestDetailSituation!.items[i].imageList, brand: self.suggestDetailSituation!.items[i].brand, name: self.suggestDetailSituation!.items[i].name, diameter: self.suggestDetailSituation!.items[i].diameter, minCycle: self.suggestDetailSituation!.items[i].changeCycleMinimum, maxCycle: self.suggestDetailSituation!.items[i].changeCycleMaximum, pieces: self.suggestDetailSituation!.items[i].pieces, price: self.suggestDetailSituation!.items[i].price, otherColorList: self.suggestDetailSituation!.items[i].otherColorList))
            }
        }
    }
    
    
    // MARK: - @objc Methods
    @objc
    func setPriceLowOrder() {
        print("setPriceLowOrder()")
//        suggestForSituation?.sort(by: {$0.price < $1.price})
//        situationCollectionView.reloadData()
    }
    
    @objc
    func setPriceHighOrder() {
        print("setPriceHighOrder")
        //        suggestForSituation?.sort(by: {$0.price > $1.price})
        //        situationCollectionView.reloadData()
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.size.height {
            print("끝에 닿음")
            if canFetchData, currPage < totalPage {
                currPage += 1
                canFetchData = false
                getSuggestSituationWithAPI(accesstoken: accesstoken, page: currPage, sort: sort, order: order)
            } else {
                getSuggestSituationWithAPI(accesstoken: accesstoken, page: currPage, sort: "", order: "")
            }
            //refresh
            situationCollectionView.reloadData()
        }
    }
}

extension SituationVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 40 - 15) / 2
        let height = (collectionView.frame.height - 40) / 2
        
        if (UIDevice.current.isiPhone12Pro) {
            return CGSize(width:(collectionView.frame.width - 100) / 2, height:(collectionView.frame.height - 40) / 2)
        }
        
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
extension SituationVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCVC.identifier, for: indexPath) as? RecommendCVC else {
            return UICollectionViewCell()
        }
        let data = suggestForSituation?[indexPath.row]
        cell.initCell(imageList: data?.imageList ?? ["", "", ""], brandName: data?.brand ?? "오렌즈", lensName: data?.name ?? "스페니쉬 그레이", diameter: data?.diameter ?? 15.3, minCycle: data?.minCycle ?? 1, maxCycle: data?.maxCycle ?? 1, pieces: data?.pieces ?? 10, price: data?.price ?? 18000, colorList: data?.otherColorList ?? [])
        return cell
    }
}
