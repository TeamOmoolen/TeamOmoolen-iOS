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
    
//    private var lensCycleList = [LensCycleDataModel]()
    var lensCycle = [String]()
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
//        setCollectionView()
        
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
    }
    
    func setList() {
        
    }
    
    func registerXib() {
        
    }
    
//    func setCollectionView() {
//        cycleCollectionView.delegate = self
//        cycleCollectionView.dataSource = self
//
//        cycleCollectionView.allowsMultipleSelection = true
//    }
}

// MARK: - Action Methods

extension CycleFilterView {
    func setButton() {
        let allSelectAction = UIAction { _ in
            if !self.isAllSelected {
                self.isAllSelected = true
                self.selectButton.tintColor = .omMainOrange
                self.cycleCollectionView.selectAll(animated: true)
            } else {
                self.isAllSelected = false
                self.selectButton.tintColor = .omFourthGray
                self.cycleCollectionView.deselectAll(animated: true)
            }
        }
        selectButton.addAction(allSelectAction, for: .touchUpInside)
    }
}

// MARK: - UI CollectionViewDataSource

extension CycleFilterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CycleFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        let cellWidth = (width - 47) / 2
        let cellHeight = (height - 100) / 6
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
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
        
        // list에 담기
        
        NotificationCenter.default.post(name: NSNotification.Name("postCycleList"), object: lensCycle)
    }
    
    @objc
    func resetData(_ notification: Notification) {
        selectButton.tintColor = .omFourthGray
        
        lensCycle = []
        
        cycleCollectionView.deselectAll(animated: true)
        
        NotificationCenter.default.post(name: NSNotification.Name("resetCycleList"), object: lensCycle)
    }
    
}


