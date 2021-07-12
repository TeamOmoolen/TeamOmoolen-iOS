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
    var lensDiameter = [Int]()
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

extension DiameterFilterView {
    func setUI() {
        filterLabel.text = "직경"
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
    @objc
    func touchUpAllSelect(_ sender: UITapGestureRecognizer) {
        if !self.isAllSelected {
            self.isAllSelected = true
            self.selectButton.tintColor = .omMainOrange
            self.selectImage.image = UIImage(named: "icFilterPressed")
            self.diameterCollectionView.selectAll(animated: true)
        } else {
            self.isAllSelected = false
            self.selectButton.tintColor = .omFourthGray
            self.selectImage.image = UIImage(named: "icFilterNormal")
            self.diameterCollectionView.deselectAll(animated: true)
        }
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
        lensDiameter = [0, 0, 0, 0, 0, 0]
        
        guard let lensDiameterList = diameterCollectionView.indexPathsForSelectedItems else {
            return
        }
        if lensDiameterList.contains([0,0]) {
            lensDiameter[0] = 1
        }
        if lensDiameterList.contains([0,1]) {
            lensDiameter[1] = 1
        }
        if lensDiameterList.contains([0,2]) {
            lensDiameter[2] = 1
        }
        if lensDiameterList.contains([0,3]) {
            lensDiameter[3] = 1
        }
        if lensDiameterList.contains([0,4]) {
            lensDiameter[4] = 1
        }
        if lensDiameterList.contains([0,5]) {
            lensDiameter[5] = 1
        }
        
        if lensDiameter == [0, 0, 0, 0, 0, 0] {
            lensDiameter = [1, 1, 1, 1, 1, 1]
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("postDiameterList"), object: lensDiameter)
    }
    
    @objc
    func resetData(_ notification: Notification) {
        lensDiameter = []
        
        diameterCollectionView.deselectAll(animated: true)
        
        NotificationCenter.default.post(name: NSNotification.Name("resetDiameterList"), object: lensDiameter)
    }
    
}

