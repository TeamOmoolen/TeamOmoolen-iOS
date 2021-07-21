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
    
    var suggestForSeason: [SuggestProduct]? = nil
    var suggestDetailForSeason: SuggestDetailResponse?
    var accesstoken = ""
    var list = [SuggestProduct]()

    
    private var currPage: Int = 1
    var totalPage: Int = -1
    private var canFetchData: Bool = true
    
    private var sort = ""
    private var order = ""
   
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        registerXib()
        setRecommendList()
        setAccesstoken()
        setCollectionViewDelegate()
        setPhoneResolution()
        setAccesstoken()
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
        popUpLabel.text = "여름과 잘 어울리는 렌즈를 추천해드릴게요"
        popUpLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 10)
        popUpLabel.textColor = .omThirdGray
        popUpButton.setImage(UIImage(named: "btnQuestionmark"), for: .normal)
        
    }
    func setAccesstoken() {
        accesstoken = UserDefaults.standard.string(forKey: "Accesstoken") ?? ""
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

    func getSuggestSeasonWithAPI(page: Int, sort: String, order: String) {
        SuggestAPI.shared.getSeason(page: page, sort: sort, order: order) { response in
            self.suggestDetailForSeason = response
            
            for i in 0..<(self.suggestDetailForSeason?.items.count)! {
                self.list.append(SuggestProduct(id: self.suggestDetailForSeason!.items[i].id, imageList: self.suggestDetailForSeason!.items[i].imageList, brand: self.suggestDetailForSeason!.items[i].brand, name: self.suggestDetailForSeason!.items[i].name, diameter: self.suggestDetailForSeason!.items[i].diameter, changeCycleMinimum: self.suggestDetailForSeason!.items[i].changeCycleMinimum, changeCycleMaximum: self.suggestDetailForSeason!.items[i].changeCycleMaximum, pieces: self.suggestDetailForSeason!.items[i].pieces, price: self.suggestDetailForSeason!.items[i].price, otherColorList: self.suggestDetailForSeason!.items[i].otherColorList))
                self.seasonCollectionView.reloadData()
            }
        }
    }
}

//MARK: - UICollectionView Delegate
extension SeasonVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = UIStoryboard(name: Const.Storyboard.Name.Detail, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Detail) as? DetailVC else {
            return
        }
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.modalTransitionStyle = .crossDissolve
        detailVC.id = list[indexPath.row].id
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.size.height {
            if currPage < totalPage {
                let sortParam = self.sort
                let orderParam = self.order
                currPage += 1
                getSuggestSeasonWithAPI(page: currPage, sort: sortParam, order: orderParam)
            }
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
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCVC.identifier, for: indexPath) as? RecommendCVC else {
            return UICollectionViewCell()
        }
        let data = list[indexPath.row]
        cell.initCell(imageList: data.imageList, brandName: data.brand, lensName: data.name, diameter: data.diameter, minCycle: data.changeCycleMinimum, maxCycle: data.changeCycleMaximum, pieces: data.pieces, price: data.price, colorList: data.otherColorList)
        return cell
    }
}
