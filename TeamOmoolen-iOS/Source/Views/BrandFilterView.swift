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
    var lensBrand = [String]()
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
    }
}

extension BrandFilterView {
    func setUI() {
        filterLabel.text = "컬러"
        filterLabel.textColor = .omMainBlack
        filterLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 16)
        
        selectButton.setTitle("전체선택", for: .normal)
        selectButton.tintColor = .omFourthGray
        selectButton.titleLabel?.font = UIFont(name: "NotoSansCJKKR-Regular", size: 12)
    }
    
    func setList() {
        brandList.append(contentsOf: [
            LensBrandDataModel(brandLogoImage: "abc", brandName: "오렌즈"),
            LensBrandDataModel(brandLogoImage: "abc", brandName: "렌즈미"),
            LensBrandDataModel(brandLogoImage: "abc", brandName: "렌즈베리"),
            LensBrandDataModel(brandLogoImage: "abc", brandName: "앤365"),
            LensBrandDataModel(brandLogoImage: "abc", brandName: "렌즈타운"),
            LensBrandDataModel(brandLogoImage: "abc", brandName: "다비치"),
            LensBrandDataModel(brandLogoImage: "abc", brandName: "아이돌렌즈"),
            LensBrandDataModel(brandLogoImage: "abc", brandName: "렌즈나인"),
            LensBrandDataModel(brandLogoImage: "abc", brandName: "렌즈디바"),
            LensBrandDataModel(brandLogoImage: "abc", brandName: "아큐브"),
            LensBrandDataModel(brandLogoImage: "abc", brandName: "바슈롬"),
            LensBrandDataModel(brandLogoImage: "abc", brandName: "클라렌"),
            LensBrandDataModel(brandLogoImage: "abc", brandName: "알콘"),
            LensBrandDataModel(brandLogoImage: "abc", brandName: "뉴바이오"),
            LensBrandDataModel(brandLogoImage: "abc", brandName: "프레쉬콘"),
            LensBrandDataModel(brandLogoImage: "abc", brandName: "쿠퍼비전"),
            LensBrandDataModel(brandLogoImage: "abc", brandName: "그외")
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
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
}
