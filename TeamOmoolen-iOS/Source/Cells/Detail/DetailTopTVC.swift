//
//  DetailTopTVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/08.
//

import UIKit

class DetailTopTVC: UITableViewCell {
    static let identifier = "DetailTopTVC"

    // MARK: - UI Components
    
    @IBOutlet weak var modelImageView: UIImageView!
    @IBOutlet weak var lensImageView: UIImageView!
    
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var lensLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var dividerView: UIView!
    
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var lensDiameterLabel: UILabel!
    
    @IBOutlet weak var cycleLabel: UILabel!
    @IBOutlet weak var lensCycleLabel: UILabel!
    
    @IBOutlet weak var textureLabel: UILabel!
    @IBOutlet weak var lensTextureLabel: UILabel!
    
    @IBOutlet weak var functionLabel: UILabel!
    @IBOutlet weak var lensFunctionLabel: UILabel!
    
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var lensColorListCollectionView: UICollectionView!
    
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var compareButton: UIButton!
    
    // MARK: - Local Variabels
    
    private var colorList = [String]()
    var delegate: ViewModalProtocol?
    
    // MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
        registerXib()
        setCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension DetailTopTVC {
    func setUI() {
        // MARK: - Label UI
        
        // 동적 라벨
        brandLabel.text = "브랜드명"
        brandLabel.textColor = .omThirdGray
        brandLabel.font = UIFont(name: "NotoSansCJKKR-Medium", size: 14)
        
        lensLabel.text = "렌즈명"
        lensLabel.textColor = .omMainBlack
        lensLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 20)
        
        priceLabel.text = "가격"
        priceLabel.textColor = .omMainBlack
        priceLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)
        
        dividerView.backgroundColor = .omFifthGray
        
        lensDiameterLabel.text = "렌즈직경"
        lensDiameterLabel.textColor = .omThirdGray
        lensDiameterLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        
        lensCycleLabel.text = "렌즈주기"
        lensCycleLabel.textColor = .omThirdGray
        lensCycleLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        
        lensTextureLabel.text = "렌즈재질"
        lensTextureLabel.textColor = .omThirdGray
        lensTextureLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        
        lensFunctionLabel.text = "렌즈기능"
        lensFunctionLabel.textColor = .omThirdGray
        lensFunctionLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        
        // 정적 라벨
        diameterLabel.text = "직경"
        diameterLabel.textColor = .omMainBlack
        diameterLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 14)
        
        cycleLabel.text = "주기"
        cycleLabel.textColor = .omMainBlack
        cycleLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 14)
        
        textureLabel.text = "재질"
        textureLabel.textColor = .omMainBlack
        textureLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 14)
        
        functionLabel.text = "기능"
        functionLabel.textColor = .omMainBlack
        functionLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 14)
        
        colorLabel.text = "컬러"
        colorLabel.textColor = .omMainBlack
        colorLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 14)
        
        
        // MARK: - Button UI
        
        myButton.backgroundColor = .omFifthGray
        myButton.tintColor = .omThirdGray
        myButton.setTitle("찜하기", for: .normal)
        myButton.layer.cornerRadius = 10
        myButton.layer.masksToBounds = true
        
        compareButton.backgroundColor = .omFifthGray
        compareButton.tintColor = .omThirdGray
        compareButton.setTitle("보관함 비교", for: .normal)
        compareButton.layer.cornerRadius = 10
        compareButton.layer.masksToBounds = true
    }
    
    func initCell(imageList: [String], brand: String, lens: String, price: Int, diameter: Double, minCycle: Int, maxCycle:Int, texture: String, function: String, colorList: [String]) {
        // kingfisher
        let modelURL = URL(string: imageList[0])
        modelImageView.kf.setImage(with: modelURL)
        
        let lensURL = URL(string: imageList[0])
        lensImageView.kf.setImage(with: lensURL)
        
        brandLabel.text = brand
        lensLabel.text = lens
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        priceLabel.text = "\(formatter.string(from: NSNumber(value: price))!)원"
        
        lensDiameterLabel.text = "\(diameter)mm"
        
        var cycleData = ""
        if minCycle == maxCycle {
            if minCycle < 7 { cycleData = "\(minCycle)Day" }
            else if minCycle < 30 { cycleData = "\(minCycle/7)Week" }
            else { cycleData = "\(minCycle/30)Month" }
        } else if maxCycle < 7 {
            cycleData = "\(minCycle)~\(maxCycle)Days"
        } else if maxCycle < 30 {
            cycleData = "\(minCycle/7)~\(maxCycle/7)Weeks"
        } else if maxCycle > 30 {
            if minCycle/30 >= 6 { cycleData = "6months+" }
            else {cycleData = "\(minCycle/30)~\(maxCycle/30)Months"}
        }
        lensCycleLabel.text = "\(cycleData)"
        
        lensTextureLabel.text = texture
        
        lensFunctionLabel.text = function
        
        self.colorList = colorList
    }
    
    func registerXib() {
        let nib = UINib(nibName: ColorListCVC.identifier, bundle: nil)
        lensColorListCollectionView.register(nib, forCellWithReuseIdentifier: ColorListCVC.identifier)
    }
    
    func setCollectionView() {
        lensColorListCollectionView.delegate = self
        lensColorListCollectionView.dataSource = self
    }
}

extension DetailTopTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

extension DetailTopTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorListCVC.identifier, for: indexPath) as? ColorListCVC else {
            return UICollectionViewCell()
        }
        cell.initCell(color: colorList[indexPath.row])
        return cell
    }
    
    
}
