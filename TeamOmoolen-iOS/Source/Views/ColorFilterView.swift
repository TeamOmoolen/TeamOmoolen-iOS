//
//  ColorFilterView.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/06.
//

import UIKit

class ColorFilterView: UIView {
    
    // MARK: - UI Components
    
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
    // MARK: - Local Variables
    
    private var lensColorList = [LensColorModel]()
    var lensColor = [String]()
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

extension ColorFilterView {
    func setUI() {
        filterLabel.text = "컬러"
        filterLabel.textColor = .omMainBlack
        filterLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 16)
        
        selectButton.setTitle("전체선택", for: .normal)
        selectButton.tintColor = .omFourthGray
        selectButton.titleLabel?.font = UIFont(name: "NotoSansCJKKR-Regular", size: 12)
    }
    
    func setList() {
        lensColorList.append(contentsOf: [
            LensColorModel(image: "btnNoncolor"),
            LensColorModel(image: "btnBlackcolor"),
            LensColorModel(image: "btnGreycolor"),
            LensColorModel(image: "btnChococolor"),
            LensColorModel(image: "btnGreencolor"),
            LensColorModel(image: "btnBrowncolor"),
            LensColorModel(image: "btnPurplecolor"),
            LensColorModel(image: "btnBluecolor"),
            LensColorModel(image: "btnGoldcolor"),
            LensColorModel(image: "btnPinkcolor"),
            LensColorModel(image: "btnGlittercolor"),
            LensColorModel(image: "btnEtccolor")
        ])
    }
    
    func registerXib() {
        let colorNib = UINib(nibName: "LensColorCVC", bundle: nil)
        colorCollectionView.register(colorNib, forCellWithReuseIdentifier: "LensColorCVC")
    }
    
    func setCollectionView() {
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        colorCollectionView.allowsMultipleSelection = true
    }
}

// MARK: - Action Methods

extension ColorFilterView {
    func setButton() {
        let allSelectAction = UIAction { _ in
            if !self.isAllSelected {
                self.isAllSelected = true
                self.selectButton.tintColor = .omMainOrange
                self.colorCollectionView.selectAll(animated: true)
            } else {
                self.isAllSelected = false
                self.selectButton.tintColor = .omFourthGray
                self.colorCollectionView.deselectAll(animated: true)
            }
        }
        selectButton.addAction(allSelectAction, for: .touchUpInside)
    }
}

// MARK: - UI CollectionViewDataSource

extension ColorFilterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lensColorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LensColorCVC", for: indexPath) as? LensColorCVC else {
            return UICollectionViewCell()
        }
        cell.initCell(image: lensColorList[indexPath.row].image)
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ColorFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        let cellWidth = (width - 7) / 2
        let cellHeight = (height - 100) / 6
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
}
