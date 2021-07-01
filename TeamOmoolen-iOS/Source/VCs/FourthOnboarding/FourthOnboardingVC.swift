//
//  FourthOnboardingVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/02.
//

import UIKit
import SnapKit

class FourthOnboardingVC: UIViewController {

    // MARK: - UI Components
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var guideLabel1: UILabel!
    @IBOutlet weak var guideLabel2: UILabel!
    @IBOutlet weak var guideLabel3: UILabel!
    
    @IBOutlet weak var brandSelectView: UIView!
    @IBOutlet weak var brandSelectLabel: UILabel!
    
    @IBOutlet weak var lensTextView: UITextView!
    
    @IBOutlet weak var purposeListCollectionView: UICollectionView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    // MARK: - Local Variables
    
    private var brandList: [LensBrandDataModel] = []
    private var purposeList: [PurposeDataModel] = []
    
    private var isBrandSelected = false
    private var isLensNameSelected = false
    
    
    // MARK: - View Life Cycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        progressView.progress = 0.75
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationController()
        setUI()
        
        setList()
        
        setCollectionViewDelegate()
        registerXib()
    }
}

// MARK: - Custom Methods

extension FourthOnboardingVC {
    func setNavigationController() {
        
    }
    
    func setUI() {
        view.backgroundColor = .omAlmostwhite
        purposeListCollectionView.backgroundColor = .omAlmostwhite
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateProgressViewWithAnimation), userInfo: nil, repeats: true)
        progressView.tintColor = .omMainOrange
        progressView.tintColor = .systemOrange
        
        progressLabel.text = "4/4"
        progressLabel.font = UIFont(name: "Roboto-Regular", size: 12)
        progressLabel.textColor = .omThirdGray
        
        guideLabel1.text = "가장 잘 맞았던 렌즈를 입력해주세요!"
        guideLabel1.textColor = .omMainBlack
        guideLabel1.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)
        
        guideLabel2.text = "눈에 딱 맞는 렌즈를 추천해드릴거에요!"
        guideLabel2.textColor = .omFourthGray
        guideLabel2.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        
        guideLabel3.text = "렌즈를 주로 언제 착용하시나요?"
        guideLabel3.textColor = .omMainBlack
        guideLabel3.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)
        
        brandSelectView.backgroundColor = .omWhite
        brandSelectView.layer.cornerRadius = 10
        brandSelectView.layer.masksToBounds = true
        brandSelectView.layer.applyShadow(color: .black, alpha: 0.14, x: 2, y: 2, blur: 7, spread: 0)
        
        brandSelectLabel.text = "브랜드를 선택해주세요!"
        brandSelectLabel.textColor = .omThirdGray
        brandSelectLabel.font = UIFont(name: "NotoSansCJKKR-DemiLight", size: 15)
        
        lensTextView.layer.cornerRadius = 10
        lensTextView.layer.masksToBounds = true
        lensTextView.layer.applyShadow(color: .black, alpha: 0.14, x: 2, y: 2, blur: 7, spread: 0)
        
        lensTextView.backgroundColor = .omAlmostwhite
        lensTextView.text = "렌즈명을 입력해주세요"
        lensTextView.font = UIFont(name: "NotoSansCJKKR-DemiLight", size: 15)
        lensTextView.textColor = .omThirdGray
        
        nextButton.backgroundColor = .omFourthGray
        nextButton.tintColor = .white
        nextButton.setTitle("오무렌 시작하기", for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "NotoSansCJKKR-Regular", size: 18)
        nextButton.tintColor = .omWhite
        nextButton.isEnabled = false
        
        nextButton.layer.cornerRadius = 10
        nextButton.layer.masksToBounds = true
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
            LensBrandDataModel(brandLogoImage: "abc", brandName: "클라렌")
        ])
        
        purposeList.append(contentsOf: [
            PurposeDataModel(purpose: "운동"),
            PurposeDataModel(purpose: "일상생활"),
            PurposeDataModel(purpose: "특별한 날"),
            PurposeDataModel(purpose: "여행"),
            PurposeDataModel(purpose: "기타")
        ])
    }
    
    func registerXib() {
        
        let purposeNib = UINib(nibName: PurposeCVC.identifier, bundle: nil)
        purposeListCollectionView.register(purposeNib, forCellWithReuseIdentifier: PurposeCVC.identifier)
    }
    
    func setCollectionViewDelegate() {
        purposeListCollectionView.delegate = self
        purposeListCollectionView.dataSource = self
    }
}

// MARK: - Action Methods

extension FourthOnboardingVC {
    @objc
    func updateProgressViewWithAnimation() {
        UIView.animate(withDuration: 0.3) {
            if self.progressView.progress != 1 {
                self.progressView.setProgress(1, animated: true)
            }
        }
    }
}


// MARK: - UICollectionView DataSource

extension FourthOnboardingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case purposeListCollectionView:
            return purposeList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case purposeListCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PurposeCVC.identifier, for: indexPath) as? PurposeCVC else {
                return UICollectionViewCell()
            }
            cell.layer.applyShadow(color: .black, alpha: 0.14, x: 2, y: 2, blur: 7, spread: 0)
            cell.contentView.layer.cornerRadius = 10
            cell.contentView.layer.masksToBounds = true
            cell.initCell(purpose: purposeList[indexPath.row].purpose)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
}
// MARK: - UICollectionView DelegateFlowLayout

extension FourthOnboardingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == purposeListCollectionView {
            let width = collectionView.frame.width
            let height = collectionView.frame.height
            let cellWidth = (width - 19) / 2
            let cellHeight = (height - 30) / 3
            return CGSize(width: cellWidth, height: cellHeight)
        } else {
            return CGSize(width: 50, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
