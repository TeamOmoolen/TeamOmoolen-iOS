//
//  ForYouVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/09.
//

import UIKit

class ForYouVC: UIViewController {

    //MARK: - IB Outlets
    @IBOutlet weak var popUpTop: UIView!
    @IBOutlet weak var popUpMiddle: UIView!
    @IBOutlet weak var popUpLabel: UILabel!
    @IBOutlet weak var myFilterLabel: UILabel!
    @IBOutlet weak var forYouCollectionView: UICollectionView!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var popUpButton: UIButton!
    @IBOutlet weak var popUpTopConstraint: NSLayoutConstraint!
    
    //MARK: - Local Variables
    private var recommendList: [RecommendLensDataModel] = []
    var suggestForYou: [SuggestProduct]? = nil
    var suggestDetailForYou: SuggestDetailResponse?
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
        setAccesstoken()
        registerXib()
        setRecommendList()
        setCollectionViewDelegate()
        setNotification()
        setPhoneResolution()
    }
    
    //MARK: - Methods
    func setUI(){
        
        popUpTop.backgroundColor = .omFifthGray
        //서버에서 받아올 수도
        popUpLabel.text = "나에게 딱 맞는 오무렌의 추천 렌즈를 소개합니다"
        popUpLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 10)
        popUpLabel.textColor = .omThirdGray
        
        myFilterLabel.text = "my필터"
        myFilterLabel.font = UIFont(name: "NotoSansCJKKR-Medium", size: 12)
        myFilterLabel.textColor = .omSecondGray
                
        popUpButton.setImage(UIImage(named: "btnQuestionmark"), for: .normal)
    }
    
    func setAccesstoken() {
        accesstoken = UserDefaults.standard.string(forKey: "Accesstoken") ?? ""
    }
    
    func setRecommendList() {
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
    
    func registerXib(){
        let recommedNib = UINib(nibName: RecommendCVC.identifier, bundle: nil)
        forYouCollectionView.register(recommedNib, forCellWithReuseIdentifier: RecommendCVC.identifier)
    }
    
    func setCollectionViewDelegate(){
        forYouCollectionView.delegate = self
        forYouCollectionView.dataSource = self
    }
    
    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(setPriceLowOrder), name: Notification.Name("SetLowOrder"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setPriceHighOrder), name: Notification.Name("SetHighOrder"), object: nil)
    }
    
   func setPhoneResolution() {
        if UIDevice.current.isiPhoneSE2 {
            popUpTopConstraint.constant = 0
        } else if UIDevice.current.isiPhone12Pro {
            popUpTopConstraint.constant = 46
        }
   }
    
    func getSuggestForyouWithAPI(accesstoken: String, page: Int, sort: String, order: String) {
        SuggestAPI.shared.getForyou(accesstoken: accesstoken, page: page, sort: sort, order: order) { response in
            self.suggestDetailForYou = response
            
            var appendList = [SuggestProduct]()
            for i in 0..<(self.suggestDetailForYou?.items.count)! {
                appendList.append(SuggestProduct(id: self.suggestDetailForYou!.items[i].id, imageList: self.suggestDetailForYou!.items[i].imageList, brand: self.suggestDetailForYou!.items[i].brand, name: self.suggestDetailForYou!.items[i].name, diameter: self.suggestDetailForYou!.items[i].diameter, changeCycleMinimum: self.suggestDetailForYou!.items[i].changeCycleMinimum, changeCycleMaximum: self.suggestDetailForYou!.items[i].changeCycleMaximum, pieces: self.suggestDetailForYou!.items[i].pieces, price: self.suggestDetailForYou!.items[i].price, otherColorList: self.suggestDetailForYou!.items[i].otherColorList))
            }
        }
    }

    
    // MARK: - @objc Methods
    @objc
    func setPriceLowOrder() {
        print("setPriceLowOrder()")
//        resultList.sort(by: {$0.price < $1.price})
//        resultCollectionView.reloadData()
        sort = "price"
        order = "desc"
    }
    
    @objc
    func setPriceHighOrder() {
        print("setPriceHighOrder")
//        resultList.sort(by: {$0.price > $1.price})
//        resultCollectionView.reloadData()
        sort = "price"
        order = "asc"
    }
    
    // MARK: - @IBAction Properties
    @IBAction func presentToSortModal(_ sender: Any) {
        let vc = UIStoryboard(name: Const.Storyboard.Name.SortPanModal, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.SortPanModal) as! SortPanModalVC
        presentPanModal(vc)
    }
    
    @IBAction func presentToPopupModal(_ sender: Any) {
        guard let popup = UIStoryboard(name: Const.Storyboard.Name.PopupModal, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.PopupModal) as? PopupModalVC else {
            return
        }
        popup.titleText = "나에게 딱 맞는 렌즈 추천, For you"
        popup.subtitleText =
        """
        For you는 오무렌 사용자들이 나에게 딱 맞는 렌즈를
        찾는 데 도움을 드리고자 만들어진 개인형 맞춤 추천
        서비스입니다.

        국내 모든 렌즈에 대한 데이터를 바탕으로 회원가입시
        입력한 1) 기능 2)주기 3)컬러 등을 고려하여
        유저들에게 맞는 추천 제품을 제공합니다.
        """
        
        popup.modalPresentationStyle = .overFullScreen
        popup.modalTransitionStyle = . crossDissolve
        
        self.present(popup, animated: true, completion: nil)
    }
    
}
//MARK: - UICollectionView Delegate
extension ForYouVC: UICollectionViewDelegate {
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
                getSuggestForyouWithAPI(accesstoken: accesstoken, page: currPage, sort: sort, order: order)
            } else {
                getSuggestForyouWithAPI(accesstoken: accesstoken, page: currPage, sort: "", order: "")
            }
            //refresh
            forYouCollectionView.reloadData()
        }
    }
}

//MARK: - CollectionViewDelegateFlowLayout
extension ForYouVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width = CGFloat(0)
        var height = CGFloat(0)
        
        if (UIDevice.current.isiPhone12Pro) {
            width = (collectionView.frame.width - 100) / 2
            height = (collectionView.frame.height - 40) / 2
        } else {
            width = (collectionView.frame.width - 40 - 15) / 2
            height = (collectionView.frame.height - 40) / 2
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

extension ForYouVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCVC.identifier, for: indexPath) as? RecommendCVC else {
            return UICollectionViewCell()
        }
        let data = suggestForYou?[indexPath.row]
        cell.initCell(imageList: data?.imageList ?? [""], brandName: data?.brand ?? "오렌즈", lensName: data?.name ?? "스페니쉬 그레이", diameter: data?.diameter ?? 15.3, minCycle: data?.changeCycleMinimum ?? 1, maxCycle: data?.changeCycleMaximum ?? 1, pieces: data?.pieces ?? 10, price: data?.price ?? 18000, colorList: data?.otherColorList ?? [])
        return cell
    }
}

