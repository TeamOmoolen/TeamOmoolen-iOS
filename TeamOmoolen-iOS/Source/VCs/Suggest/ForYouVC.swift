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
    @IBOutlet weak var popUpBottom: UIView!
    @IBOutlet weak var myFilterLabel: UILabel!
    @IBOutlet weak var sectionDivider: UIView!
    @IBOutlet weak var forYouCollectionView: UICollectionView!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var popUpButton: UIButton!
    
    //MARK: - Local Variables
    private var recommendList: [RecommendLensDataModel] = []
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        registerXib()
        setRecommendList()
        setCollectionViewDelegate()

    }
    
    //MARK: - Methods
    func setUI(){
        
        popUpTop.backgroundColor = .omFifthGray
        //서버에서 받아올 수도
        popUpLabel.text = "나에게 딱 맞는 오무렌의 추천 렌즈를 소개합니다"
        popUpLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 10)
        popUpLabel.textColor = .omThirdGray
                
        popUpBottom.backgroundColor = .omFifthGray
        
        myFilterLabel.text = "my필터"
        myFilterLabel.font = UIFont(name: "NotoSansCJKKR-Medium", size: 12)
        myFilterLabel.textColor = .omSecondGray
        
        sectionDivider.backgroundColor = .omAlmostwhite
        
        popUpButton.setImage(UIImage(named: "btnQuestionmark"), for: .normal)
    }
    
    func setRecommendList() {
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
    
    func registerXib(){
        let recommedNib = UINib(nibName: RecommendCVC.identifier, bundle: nil)
        forYouCollectionView.register(recommedNib, forCellWithReuseIdentifier: RecommendCVC.identifier)
    }
    
    func setCollectionViewDelegate(){
        forYouCollectionView.delegate = self
        forYouCollectionView.dataSource = self
    }
    
    // MARK: - @IBAction Properties
    @IBAction func presentToPopupModal(_ sender: Any) {
        guard let popup = UIStoryboard(name: Const.Storyboard.Name.PopupModal, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.PopupModal) as? PopupModalVC else {
            return
        }
        popup.titleText = "나에게 딱 맞는 렌즈 추천, For you"
        popup.subtitleText = """
            For you는 오무렌 사용자들이 나에게 딱 맞는 렌즈를
            찾는 데 도움을 드리고자 만들어진 개인형 맞춤 추천
            서비스입니다.

            국내 모든 렌즈에 대한 데이터를 바탕으로 회원가입시
            입력한 1) 기능 2)주기 3)컬러 등을 고려하여
            유저들에게 맞는 추천 제품을 제공합니다.
            """
        
        popup.modalPresentationStyle = .overCurrentContext
        popup.modalTransitionStyle = . crossDissolve
        
        self.present(popup, animated: true, completion: nil)
    }
    
}
//MARK: - UICollectionView Delegate
extension ForYouVC: UICollectionViewDelegate {
    
}

extension ForYouVC: UICollectionViewDelegateFlowLayout {
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

extension ForYouVC: UICollectionViewDataSource {
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
