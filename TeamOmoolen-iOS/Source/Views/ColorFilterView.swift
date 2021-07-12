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
    @IBOutlet weak var selectImage: UIImageView!
    
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
    // MARK: - Local Variables
    
    private var lensColorList = [LensColorDataModel]()
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
        setList()
        registerXib()
        setCollectionView()
        
        setNotification()
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
        selectButton.addTarget(self, action: #selector(touchUpAllSelect(_:)), for: .touchUpInside)
        
        selectImage.image = UIImage(named: "icFilterNormal")
        selectImage.isUserInteractionEnabled = true
        let selectGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpAllSelect(_:)))
        selectImage.addGestureRecognizer(selectGesture)
    }
    
    func setList() {
        lensColorList.append(contentsOf: [
            LensColorDataModel(image: "btnNoncolor"),
            LensColorDataModel(image: "btnBlackcolor"),
            LensColorDataModel(image: "btnGreycolor"),
            LensColorDataModel(image: "btnChococolor"),
            LensColorDataModel(image: "btnGreencolor"),
            LensColorDataModel(image: "btnBrowncolor"),
            LensColorDataModel(image: "btnPurplecolor"),
            LensColorDataModel(image: "btnBluecolor"),
            LensColorDataModel(image: "btnGoldcolor"),
            LensColorDataModel(image: "btnPinkcolor"),
            LensColorDataModel(image: "btnEtccolor")
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
    @objc
    func touchUpAllSelect(_ sender: UITapGestureRecognizer) {
        if !self.isAllSelected {
            self.isAllSelected = true
            self.selectButton.tintColor = .omMainOrange
            self.selectImage.image = UIImage(named: "icFilterPressed")
            self.colorCollectionView.selectAll(animated: true)
        } else {
            self.isAllSelected = false
            self.selectButton.tintColor = .omFourthGray
            self.selectImage.image = UIImage(named: "icFilterNormal")
            self.colorCollectionView.deselectAll(animated: true)
        }
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
        cell.layer.applyShadow(color: .black, alpha: 0.14, x: 2, y: 2, blur: 7, spread: 0)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ColorFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        let cellWidth = (width - 47) / 2
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
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}

// MARK: - Notification

extension ColorFilterView {
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(postData), name: NSNotification.Name("touchUpSearchButton"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetData), name: NSNotification.Name("touchUpColorReset"), object: nil)
    }
    
    @objc
    func postData(_ notification: Notification) {
        lensColor = []
        
        guard let lensColorList = colorCollectionView.indexPathsForSelectedItems else {
            return
        }
        if lensColorList.contains([0,0]) {
            lensColor.append("clear")
        }
        if lensColorList.contains([0,1]) {
            lensColor.append("black")
        }
        if lensColorList.contains([0,2]) {
            lensColor.append("gray")
        }
        if lensColorList.contains([0,3]) {
            lensColor.append("choco")
        }
        if lensColorList.contains([0,4]) {
            lensColor.append("green")
        }
        if lensColorList.contains([0,5]) {
            lensColor.append("brown")
        }
        if lensColorList.contains([0,6]) {
            lensColor.append("purple")
        }
        if lensColorList.contains([0,7]) {
            lensColor.append("blue")
        }
        if lensColorList.contains([0,8]) {
            lensColor.append("gold")
        }
        if lensColorList.contains([0,9]) {
            lensColor.append("pink")
        }
        if lensColorList.contains([0,10]) {
            lensColor.append("glitter")
        }
        if lensColorList.contains([0,11]) {
            lensColor = ["clear", "black", "gray", "choco", "green",
                         "brown", "purple", "blue", "gold", "pink" ]
        }
        
        if lensColor == [] || lensColor == ["clear", "black", "gray", "choco", "green", "brown", "purple", "blue", "gold", "pink"] {
            lensColor = ["clear", "black", "gray", "choco", "green", "brown", "purple", "blue", "gold", "pink" ]
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("postColorList"), object: lensColor)
    }
    
    @objc
    func resetData(_ notification: Notification) {
        selectButton.tintColor = .omFourthGray
        selectImage.image = UIImage(named: "icFilterNormal")
        
        lensColor = []
        
        colorCollectionView.deselectAll(animated: true)
        
        NotificationCenter.default.post(name: NSNotification.Name("resetColorList"), object: lensColor)
    }
    
}
