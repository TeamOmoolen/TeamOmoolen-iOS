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
    var suggestForNew: [SuggestProduct]? = nil
    var suggestDetailNew: SuggestDetailResponse?
    var accesstoken = ""
    
    private var currPage: Int = 1
    private var totalPage: Int = -1
    private var canFetchData: Bool = true
    
    private var sort = "price"
    private var order = ""
    
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
        popup.titleText = """
        신제품 추천 기준
        """
        
        popup.subtitleText = """
        신제품 추천은 3개월 이내에 등록된
        제품을 추천해드립니다.
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
        newProductCollectionView.delegate = self
        newProductCollectionView.dataSource = self
    }
    
    func setPhoneResolution() {
        if UIDevice.current.isiPhoneSE2 {
            popUpTopConstraint.constant = 0
        } else if UIDevice.current.isiPhone12Pro {
            popUpTopConstraint.constant = 46
        }
    }
    
    
    func getSuggestNewWithAPI(accesstoken: String, page: Int, sort: String, order: String) {
        SuggestAPI.shared.getNew(page: page, sort: sort, order: order) {
            response in
            self.suggestDetailNew = response
            
            var appendList = [SuggestProduct]()
            for i in 0..<(self.suggestDetailNew?.items.count)! {
                appendList.append(SuggestProduct(id: self.suggestDetailNew!.items[i].id, imageList: self.suggestDetailNew!.items[i].imageList, brand: self.suggestDetailNew!.items[i].brand, name: self.suggestDetailNew!.items[i].name, diameter: self.suggestDetailNew!.items[i].diameter, minCycle: self.suggestDetailNew!.items[i].changeCycleMinimum, maxCycle: self.suggestDetailNew!.items[i].changeCycleMaximum, pieces: self.suggestDetailNew!.items[i].pieces, price: self.suggestDetailNew!.items[i].price, otherColorList: self.suggestDetailNew!.items[i].otherColorList))
            }
        }
    }
    
}

//MARK: - UICollectionView Delegate
extension NewProductVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = UIStoryboard(name: Const.Storyboard.Name.Detail, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Detail) as?
                DetailVC else {
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
                //서버통신
                getSuggestNewWithAPI(accesstoken: accesstoken, page: currPage, sort: sort, order: order)
            }
            //refresh
            newProductCollectionView.reloadData()
        }
    }
}

//MARK: - CollectionViewDelegateFlowLayout
extension NewProductVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (UIDevice.current.isiPhone12Pro) {
            return CGSize(width:(collectionView.frame.width - 100) / 2, height:(collectionView.frame.height - 40) / 2)
        }
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
        return UIEdgeInsets(top: 0, left: 20, bottom: 200, right: 20)
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
        let data = suggestForNew?[indexPath.row]
        cell.initCell(imageList: data?.imageList ?? [""], brandName: data?.brand ?? "오렌즈", lensName: data?.name ?? "스페니쉬 그레이", diameter: data?.diameter ?? 15.3, minCycle: data?.minCycle ?? 1, maxCycle: data?.maxCycle ?? 1, pieces: data?.pieces ?? 10, price: data?.price ?? 18000, colorList: data?.otherColorList ?? [])
        return cell
    }
}
