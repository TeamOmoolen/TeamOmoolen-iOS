//
//  BrandFilterView.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/06.
//

import UIKit

class BrandFilterView: UIView {

    // MARK: - UI Components
    
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    @IBOutlet weak var brandListCollectionView: UICollectionView!
    
    // MARK: - Local Variables
    
    private var brandList: [LensBrandDataModel] = []
    private var lensBrand = [String]()
    var isAllSelected = false
    
    // MARK: - init Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadXib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadXib()
    }
    
    private func loadXib() {
        let identifier = String(describing: type(of: self))
        let nibs = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)
        
        guard let customView = nibs?.first as? UIView else { return }
        customView.frame = self.bounds
        self.addSubview(customView)
        
        setUI()
        setButton()
        setList()
        registerXib()
        setCollectionView()
        
        setNotification()
    }
}

extension BrandFilterView {
    func setUI() {
        filterLabel.text = "브랜드"
        filterLabel.textColor = .omMainBlack
        filterLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 16)
        
        selectButton.setTitle("전체선택", for: .normal)
        selectButton.tintColor = .omFourthGray
        selectButton.titleLabel?.font = UIFont(name: "NotoSansCJKKR-Regular", size: 12)
    }
    
    func setList() {
        brandList.append(contentsOf: [
            LensBrandDataModel(brandLogoImage: "imgOlensLogoOnboardingNormal", brandName: "오렌즈"),
            LensBrandDataModel(brandLogoImage: "imgLensmeLogoOnboardingNormal", brandName: "렌즈미"),
            LensBrandDataModel(brandLogoImage: "imgLensveryLogoOnboardingNormal", brandName: "렌즈베리"),
            LensBrandDataModel(brandLogoImage: "imgAnnLogoOnboardingNormal", brandName: "앤365"),
            LensBrandDataModel(brandLogoImage: "imgLenstownLogoOnboardingNormal", brandName: "렌즈타운"),
            LensBrandDataModel(brandLogoImage: "imgDaviLogoOnboardingNormal", brandName: "다비치"),
            LensBrandDataModel(brandLogoImage: "imgIdolLogoOnboardingNormal", brandName: "아이돌렌즈"),
            LensBrandDataModel(brandLogoImage: "imgLensnineLogoOnboardingNormal", brandName: "렌즈나인"),
            LensBrandDataModel(brandLogoImage: "imgLensdivaLogoOnboardingNormal", brandName: "렌즈디바"),
            LensBrandDataModel(brandLogoImage: "imgAcuvueLogoOnboardingNormal", brandName: "아큐브"),
            LensBrandDataModel(brandLogoImage: "imgBaLogoOnboardingNormal", brandName: "바슈롬"),
            LensBrandDataModel(brandLogoImage: "imgClLogoOnboardingNormal", brandName: "클라렌"),
            LensBrandDataModel(brandLogoImage: "imgIlconLogoOnboardingNormal", brandName: "알콘"),
            LensBrandDataModel(brandLogoImage: "imgIdolLogoOnboardingNormal", brandName: "뉴바이오"),
            LensBrandDataModel(brandLogoImage: "imgFreshkonLogoOnboardingNormal", brandName: "프레쉬콘"),
            LensBrandDataModel(brandLogoImage: "imgCoupervisionLogoOnboardingNormal", brandName: "쿠퍼비전"),
            LensBrandDataModel(brandLogoImage: "imgEtcLogoOnboardingNormal", brandName: "그외")
        ])
    }
    
    func registerXib() {
        let brandNib = UINib(nibName: LensBrandCVC.identifier, bundle: nil)
        brandListCollectionView.register(brandNib, forCellWithReuseIdentifier: LensBrandCVC.identifier)
    }
    
    func setCollectionView() {
        brandListCollectionView.delegate = self
        brandListCollectionView.dataSource = self
        brandListCollectionView.allowsMultipleSelection = true
    }
}

// MARK: - Action Methods

extension BrandFilterView {
    func setButton() {
        let allSelectAction = UIAction { _ in
            if !self.isAllSelected {
                self.isAllSelected = true
                self.selectButton.tintColor = .omMainOrange
                self.brandListCollectionView.selectAll(animated: true)
            } else {
                self.isAllSelected = false
                self.selectButton.tintColor = .omFourthGray
                self.brandListCollectionView.deselectAll(animated: true)
            }
        }
        selectButton.addAction(allSelectAction, for: .touchUpInside)
    }
}


// MARK: - UICollectionViewDataSource

extension BrandFilterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LensBrandCVC.identifier, for: indexPath) as? LensBrandCVC else {
            return UICollectionViewCell()
        }
        cell.initCell(brandLogoImage: brandList[indexPath.row].brandLogoImage, brandName: brandList[indexPath.row].brandName)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BrandFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let cellWidth = (width - 50) / 3
        return CGSize(width: cellWidth, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}


// MARK: - Notification

extension BrandFilterView {
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(postData), name: NSNotification.Name("touchUpSearchButton"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetData), name: NSNotification.Name("touchUpBrandReset"), object: nil)
    }
    
    @objc
    func postData(_ notification: Notification) {
        lensBrand = []
        
        guard let lensBrandList = brandListCollectionView.indexPathsForSelectedItems else {
            return
        }
        if lensBrandList.contains([0,0]) {
            lensBrand.append("오렌즈")
        }
        if lensBrandList.contains([0,1]) {
            lensBrand.append("렌즈미")
        }
        if lensBrandList.contains([0,2]) {
            lensBrand.append("렌즈베리")
        }
        if lensBrandList.contains([0,3]) {
            lensBrand.append("앤365")
        }
        if lensBrandList.contains([0,4]) {
            lensBrand.append("렌즈타운")
        }
        if lensBrandList.contains([0,5]) {
            lensBrand.append("다비치")
        }
        if lensBrandList.contains([0,6]) {
            lensBrand.append("아이돌렌즈")
        }
        if lensBrandList.contains([0,7]) {
            lensBrand.append("렌즈나인")
        }
        if lensBrandList.contains([0,8]) {
            lensBrand.append("렌즈디바")
        }
        if lensBrandList.contains([0,9]) {
            lensBrand.append("아큐브")
        }
        if lensBrandList.contains([0,10]) {
            lensBrand.append("바슈롬")
        }
        if lensBrandList.contains([0,11]) {
            lensBrand.append("클라렌")
        }
        if lensBrandList.contains([0,12]) {
            lensBrand.append("알콘")
        }
        if lensBrandList.contains([0,13]) {
            lensBrand.append("뉴바이오")
        }
        if lensBrandList.contains([0,14]) {
            lensBrand.append("프레쉬콘")
        }
        if lensBrandList.contains([0,15]) {
            lensBrand.append("쿠퍼비전")
        }
        if lensBrandList.contains([0,16]) {
            lensBrand.append("그 외")
        }
        NotificationCenter.default.post(name: NSNotification.Name("postBrandList"), object: lensBrand)
    }
    
    @objc
    func resetData(_ notification: Notification) {
        lensBrand = []
        
        brandListCollectionView.deselectAll(animated: true)
        
        NotificationCenter.default.post(name: NSNotification.Name("resetBrandList"), object: lensBrand)
    }
}

