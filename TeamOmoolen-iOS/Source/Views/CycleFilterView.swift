//
//  CycleFilterView.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/08.
//

import UIKit

class CycleFilterView: UIView {
    
    // MARK: - UI Components
    
    @IBOutlet weak var filterLabel: UILabel!
    
    @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var selectButton: UIButton!
    
    @IBOutlet weak var cycleCollectionView: UICollectionView!
    
    
    // MARK: - Local Variables
    
    private var lensCycleList = [FilterDataModel]()
    var lensCycle = [Int]()
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

extension CycleFilterView {
    func setUI() {
        filterLabel.text = "주기"
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
        lensCycleList.append(contentsOf:[
            FilterDataModel(filter: "1 day"),
            FilterDataModel(filter: "2 ~ 6 days"),
            FilterDataModel(filter: "1 week"),
            FilterDataModel(filter: "1 month"),
            FilterDataModel(filter: "2 ~ 3 months"),
            FilterDataModel(filter: "3 ~ 6 months"),
            FilterDataModel(filter: "6 months")
        ])
    }
    
    func registerXib() {
        let nib = UINib(nibName: FilterCVC.identifier, bundle: nil)
        cycleCollectionView.register(nib, forCellWithReuseIdentifier: FilterCVC.identifier)
    }
    
    func setCollectionView() {
        cycleCollectionView.delegate = self
        cycleCollectionView.dataSource = self

        cycleCollectionView.allowsMultipleSelection = true
    }
}

// MARK: - Action Methods

extension CycleFilterView {
    @objc
    func touchUpAllSelect(_ sender: UITapGestureRecognizer) {
        if !self.isAllSelected {
            self.isAllSelected = true
            self.selectButton.tintColor = .omMainOrange
            self.selectImage.image = UIImage(named: "icFilterPressed")
            self.cycleCollectionView.selectAll(animated: true)
        } else {
            self.isAllSelected = false
            self.selectButton.tintColor = .omFourthGray
            self.selectImage.image = UIImage(named: "icFilterNormal")
            self.cycleCollectionView.deselectAll(animated: true)
        }
    }
}

// MARK: - UI CollectionViewDataSource

extension CycleFilterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lensCycleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCVC.identifier, for: indexPath) as? FilterCVC else {
            return UICollectionViewCell()
        }
        cell.initCell(filter: lensCycleList[indexPath.row].filter)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CycleFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        let cellWidth = (width - 50) / 2
        let cellHeight = (height - 36 - 40) / 4
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

extension CycleFilterView {
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(postData), name: NSNotification.Name("touchUpSearchButton"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetData), name: NSNotification.Name("touchUpCycleReset"), object: nil)
    }
    
    @objc
    func postData(_ notification: Notification) {
        lensCycle = []
        
        guard let lensCycleList = cycleCollectionView.indexPathsForSelectedItems else {
            return
        }
        if lensCycleList.contains([0,0]) {
            lensCycle.append(0)
        }
        if lensCycleList.contains([0,1]) {
            lensCycle.append(1)
        }
        if lensCycleList.contains([0,2]) {
            lensCycle.append(2)
        }
        if lensCycleList.contains([0,3]) {
            lensCycle.append(3)
        }
        if lensCycleList.contains([0,4]) {
            lensCycle.append(4)
        }
        if lensCycleList.contains([0,5]) {
            lensCycle.append(5)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("postCycleList"), object: lensCycle)
    }
    
    @objc
    func resetData(_ notification: Notification) {
        selectButton.tintColor = .omFourthGray
        selectImage.image = UIImage(named: "icFilterNormal")
        
        lensCycle = []
        
        cycleCollectionView.deselectAll(animated: true)
        
        NotificationCenter.default.post(name: NSNotification.Name("resetCycleList"), object: lensCycle)
    }
    
}


