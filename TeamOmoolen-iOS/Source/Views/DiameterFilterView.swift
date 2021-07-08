//
//  DiameterFilterView.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/08.
//

import UIKit

class DiameterFilterView: UIView {
    
    // MARK: - UI Components
    
    @IBOutlet weak var filterLabel: UILabel!
    
    @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var selectButton: UIButton!
    
    @IBOutlet weak var diameterCollectionView: UICollectionView!
    
    // MARK: - Local Variables
    
    private var lensDiameterList = [FilterDataModel]()
    var lensDiameter = [String]()
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
        setButton()
        
        registerXib()
        setCollectionView()
        
        setNotification()
    }

}

extension DiameterFilterView {
    func setUI() {
        filterLabel.text = "직경"
        filterLabel.textColor = .omMainBlack
        filterLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 16)
        
        selectButton.setTitle("전체선택", for: .normal)
        selectButton.tintColor = .omFourthGray
        selectButton.titleLabel?.font = UIFont(name: "NotoSansCJKKR-Regular", size: 12)
    }
    
    func setList() {
        lensDiameterList.append(contentsOf:[
            FilterDataModel(filter: "12.6 이하"),
            FilterDataModel(filter: "12.7 ~ 13.0"),
            FilterDataModel(filter: "13.1 ~ 13.3"),
            FilterDataModel(filter: "13.4 ~ 13.6"),
            FilterDataModel(filter: "13.7 ~ 13.9"),
            FilterDataModel(filter: "14.0 이상")
        ])
    }
    
    func registerXib() {
        let nib = UINib(nibName: FilterCVC.identifier, bundle: nil)
        diameterCollectionView.register(nib, forCellWithReuseIdentifier: FilterCVC.identifier)
    }
    
    func setCollectionView() {
        diameterCollectionView.delegate = self
        diameterCollectionView.dataSource = self

        diameterCollectionView.allowsMultipleSelection = true
    }
}

// MARK: - Action Methods

extension DiameterFilterView {
    func setButton() {
        let allSelectAction = UIAction { _ in
            if !self.isAllSelected {
                self.isAllSelected = true
                self.selectButton.tintColor = .omMainOrange
                self.diameterCollectionView.selectAll(animated: true)
            } else {
                self.isAllSelected = false
                self.selectButton.tintColor = .omFourthGray
                self.diameterCollectionView.deselectAll(animated: true)
            }
        }
        selectButton.addAction(allSelectAction, for: .touchUpInside)
    }
}

// MARK: - UI CollectionViewDataSource

extension DiameterFilterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lensDiameterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCVC.identifier, for: indexPath) as? FilterCVC else {
            return UICollectionViewCell()
        }
        cell.initCell(filter: lensDiameterList[indexPath.row].filter)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DiameterFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        let cellWidth = (width - 50) / 2
        let cellHeight = (height - 24 - 40) / 3
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}

// MARK: - Notification

extension DiameterFilterView {
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(postData), name: NSNotification.Name("touchUpSearchButton"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetData), name: NSNotification.Name("touchUpDiameterReset"), object: nil)
    }
    
    @objc
    func postData(_ notification: Notification) {
        lensDiameter = []
        
        guard let lensDiameterList = diameterCollectionView.indexPathsForSelectedItems else {
            return
        }
        if lensDiameterList.contains([0,0]) {
            lensDiameter.append("12.6 이하")
        }
        if lensDiameterList.contains([0,1]) {
            lensDiameter.append("12.7 ~ 13.0")
        }
        if lensDiameterList.contains([0,2]) {
            lensDiameter.append("13.1 ~ 13.3")
        }
        if lensDiameterList.contains([0,3]) {
            lensDiameter.append("13.4 ~ 13.6")
        }
        if lensDiameterList.contains([0,4]) {
            lensDiameter.append("13.7 ~ 13.9")
        }
        if lensDiameterList.contains([0,5]) {
            lensDiameter.append("14.0 이상")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("postDiameterList"), object: lensDiameter)
    }
    
    @objc
    func resetData(_ notification: Notification) {
        selectButton.tintColor = .omFourthGray
        
        lensDiameter = []
        
        diameterCollectionView.deselectAll(animated: true)
        
        NotificationCenter.default.post(name: NSNotification.Name("resetDiameterList"), object: lensDiameter)
    }
    
}

