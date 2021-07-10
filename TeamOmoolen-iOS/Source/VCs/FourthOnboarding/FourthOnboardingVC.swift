//
//  FourthOnboardingVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/02.
//

import UIKit
import SnapKit
import Moya

class FourthOnboardingVC: UIViewController {

    // MARK: - UI Components
    @IBOutlet weak var customNavigationBarViewHeight: NSLayoutConstraint!
    @IBOutlet weak var progressBarLeftAnchor: NSLayoutConstraint!
    @IBOutlet weak var indexLabelLeftAnchor: NSLayoutConstraint!
    @IBOutlet weak var indexLabelRightAnchor: NSLayoutConstraint!
    @IBOutlet weak var guideLabel1TopAnchor: NSLayoutConstraint!
    @IBOutlet weak var guideLabel1LeftAnchor: NSLayoutConstraint!
    @IBOutlet weak var guideLabel1BottomAnchor: NSLayoutConstraint!
    @IBOutlet weak var brandSelectTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var brandSelectLeftAnchor: NSLayoutConstraint!
    @IBOutlet weak var brandSelectRightAnchor: NSLayoutConstraint!
    @IBOutlet weak var guideLabel3TopAnchor: NSLayoutConstraint!
    
    @IBOutlet weak var customNavigationBarView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var icToggleImageView: UIImageView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var guideLabel1: UILabel!
    @IBOutlet weak var guideLabel2: UILabel!
    @IBOutlet weak var guideLabel3: UILabel!
    
    @IBOutlet weak var nextButtonBottomAnchor: NSLayoutConstraint!
    
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var brandSelectView: UIView!
    @IBOutlet weak var brandSelectLabel: UILabel!
    
    @IBOutlet weak var lensTextView: UITextView!
    
    @IBOutlet weak var purposeListCollectionView: UICollectionView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    private lazy var listView: UIView = {
        let view = UIView()
        view.backgroundColor = .omWhite
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.applyShadow(color: .black, alpha: 0.14, x: 2, y: 2, blur: 7, spread: 0)
        return view
    }()
    
    let brandListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .omWhite
        
        return collection
    }()
    
    private lazy var selectButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .omFourthGray
        button.setTitle("선택 완료", for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansCJKKR-Regular", size: 18)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    // MARK: - Local Variables
    var gender = ""
    var age = ""
    var lensKind = [String]()
    var lensColor = [String]()
    var lensFunction = ""
    var lensPeriod = ""
    var lensBrand = ""
    var lensName = ""
    var lensWhen = ""
    var onboardingDataModel: OnBoardingDataModel?
    
    private var brandList: [LensBrandDataModel] = []
    private var purposeList: [PurposeDataModel] = []
    
    private var isBrandSelected = false
    private var isPurposeSelected = false
    
    private var isPresentListView: Bool = false
    private var listViewHeight: NSLayoutConstraint!
    
    private var selectedBrandName = "브랜드를 선택해주세요!"
    
    // MARK: - View Life Cycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        progressView.progress = 0.75
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setPhoneResolution()
        setNavigationBar()
        setBrandListView()
        setList()
        setCollectionViewDelegate()
        registerXib()
        setNotification()
    }
    
    @IBAction func pushToHome(_ sender: Any) {
        lensName = lensTextView.text
        
        if purposeListCollectionView.indexPathsForSelectedItems! == [[0,0]] {
            lensBrand = "오렌즈"
        } else if purposeListCollectionView.indexPathsForSelectedItems! == [[0,1]] {
            lensBrand = "렌즈미"
        } else if purposeListCollectionView.indexPathsForSelectedItems! == [[0,2]] {
            lensBrand = "렌즈베리"
        } else if purposeListCollectionView.indexPathsForSelectedItems! == [[0,3]] {
            lensBrand = "앤365"
        } else if purposeListCollectionView.indexPathsForSelectedItems! == [[0,4]] {
            lensBrand = "렌즈타운"
        } else if purposeListCollectionView.indexPathsForSelectedItems! == [[0,5]] {
            lensBrand = "다비치"
        } else if purposeListCollectionView.indexPathsForSelectedItems! == [[0,6]] {
            lensBrand = "아이돌렌즈"
        } else if purposeListCollectionView.indexPathsForSelectedItems! == [[0,7]] {
            lensBrand = "렌즈나인"
        } else if purposeListCollectionView.indexPathsForSelectedItems! == [[0,8]] {
            lensBrand = "렌즈디바"
        } else if purposeListCollectionView.indexPathsForSelectedItems! == [[0,9]] {
            lensBrand = "아큐브"
        } else if purposeListCollectionView.indexPathsForSelectedItems! == [[0,10]] {
            lensBrand = "바슈롬"
        } else if purposeListCollectionView.indexPathsForSelectedItems! == [[0,11]] {
            lensBrand = "클라렌"
        } else if purposeListCollectionView.indexPathsForSelectedItems! == [[0,12]] {
            lensBrand = "알콘"
        } else if purposeListCollectionView.indexPathsForSelectedItems! == [[0,13]] {
            lensBrand = "뉴바이오"
        } else if purposeListCollectionView.indexPathsForSelectedItems! == [[0,14]] {
            lensBrand = "프레쉬콘"
        } else if purposeListCollectionView.indexPathsForSelectedItems! == [[0,15]] {
            lensBrand = "쿠퍼비전"
        } else {
            lensBrand = "그 외"
        }
        
        if purposeListCollectionView.indexPathsForSelectedItems! == [[0,0]] {
            lensWhen = "운동"
        } else if purposeListCollectionView.indexPathsForSelectedItems! == [[0,1]] {
            lensWhen = "특별한 날"
        } else if purposeListCollectionView.indexPathsForSelectedItems! == [[0,2]] {
            lensWhen = "여행"
        } else {
            lensWhen = "기타"
        }

        let param = OnboardingRequest(gender, age, lensKind, lensColor, lensFunction, lensPeriod, lensBrand, lensName, lensWhen, "001628.1f39bf3727b44f1f8a6615166ae3b718.0924")
        
        print(param)
        
        OnboardingAPI.shared.postOnboarding(param: param) { response in
            print("data: \(response.success)")
            if response.success {
                print("postOnboardingWithAPI: post success")
                guard let homeVC = UIStoryboard(name: Const.Storyboard.Name.Home, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Home) as? HomeVC else {
                    return
                }
                homeVC.modalPresentationStyle = .fullScreen
                homeVC.modalTransitionStyle = .crossDissolve
                self.navigationController?.pushViewController(homeVC, animated: true)
            } else {
                print("postOnboardingWithAPI: post Fail")
                guard let loginVC = UIStoryboard(name: Const.Storyboard.Name.Login, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Login) as? LoginVC else {
                    return
                }
                loginVC.modalPresentationStyle = .fullScreen
                loginVC.modalTransitionStyle = .crossDissolve
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
        }
    }
    
}

// MARK: - Custom Methods

extension FourthOnboardingVC {
    func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        setupNavigationBar(customNavigationBarView: customNavigationBarView)
    }
    
    func setBrandListView() {
        view.addSubview(listView)
        listView.addSubview(selectButton)
        listView.addSubview(brandListCollectionView)
        
        listView.snp.makeConstraints { make in
            make.top.equalTo(brandSelectView.snp.bottom).offset(8)
            make.leading.trailing.equalTo(brandSelectView)
            make.height.equalTo(1)
        }
        listView.isHidden = true
        
        brandListCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(13)
            make.top.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
        selectButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(13)
            make.top.equalTo(brandListCollectionView.snp.bottom).offset(10)
            make.height.equalTo(54)
        }
        selectButton.isEnabled = false
        selectButton.isHidden = true
        selectButton.addTarget(self, action: #selector(touchUpSelectButton(_:)), for: .touchUpInside)
        selectButton.addTarget(self, action: #selector(touchUpBrandSelectView(_:)), for: .touchUpInside)
        
        let brandTapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpBrandSelectView(_:)))
        brandSelectView.addGestureRecognizer(brandTapGesture)
    }
    
    func setPhoneResolution() {
        if UIDevice.current.isiPhoneSE2{
            
            customNavigationBarViewHeight.constant = 50
            
            guideLabel1.font = UIFont(name: "NotoSansCJKKR-Bold", size: 16)
            
            guideLabel3.font = UIFont(name: "NotoSansCJKKR-Bold", size: 16)
            
            progressBarLeftAnchor.constant = 16
            indexLabelRightAnchor.constant = 18
            indexLabelLeftAnchor.constant = 9
            
            guideLabel1TopAnchor.constant = 29
            guideLabel1LeftAnchor.constant = 16
            guideLabel1BottomAnchor.constant = 6
            
            brandSelectTopAnchor.constant = 15
            brandSelectLeftAnchor.constant = 11
            brandSelectRightAnchor.constant = 11
            
            guideLabel3TopAnchor.constant = 5
            
            nextButtonBottomAnchor.constant = 28
        }
    }
    
    
    func setUI() {
        
        view.backgroundColor = .omAlmostwhite
        purposeListCollectionView.backgroundColor = .omAlmostwhite
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.updateProgressViewWithAnimation()
        }
        
        progressView.tintColor = .omMainOrange
        
        progressLabel.text = "4/4"
        progressLabel.font = UIFont(name: "Roboto-Regular", size: 12)
        progressLabel.textColor = .omThirdGray
        
        guideLabel1.text = "가장 잘 맞았던 렌즈를 입력해주세요!"
        guideLabel1.textColor = .omMainBlack
        guideLabel1.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)
        
        guideLabel2.text = "눈에 딱 맞는 렌즈를 추천해드릴거에요!"
        guideLabel2.textColor = .omFourthGray
        guideLabel2.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        
        warningLabel.text = "* 렌즈 정보를 입력하지 않았습니다."
        warningLabel.font = UIFont(name: "NotoSansCJKKR-Medium", size: 10)
        warningLabel.textColor = .omMainRed
        warningLabel.isHidden = true
        
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
        lensTextView.isEditable = false
        
        lensTextView.backgroundColor = .omAlmostwhite
        lensTextView.font = UIFont(name: "NotoSansCJKKR-DemiLight", size: 15)
        lensTextView.textColor = .omThirdGray
        lensTextView.text = "렌즈명을 입력해주세요"
        lensTextView.delegate = self
        lensTextView.textContainerInset = UIEdgeInsets(top: 15, left: 20, bottom: 14, right: 5)
        
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
            LensBrandDataModel(brandLogoImage: "imgEtcLogoOnboardingNormal", brandName: "그 외")
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
        let brandNib = UINib(nibName: LensBrandCVC.identifier, bundle: nil)
        brandListCollectionView.register(brandNib, forCellWithReuseIdentifier: LensBrandCVC.identifier)
        
        let purposeNib = UINib(nibName: PurposeCVC.identifier, bundle: nil)
        purposeListCollectionView.register(purposeNib, forCellWithReuseIdentifier: PurposeCVC.identifier)
    }
    
    func setCollectionViewDelegate() {
        purposeListCollectionView.delegate = self
        purposeListCollectionView.dataSource = self
        
        brandListCollectionView.delegate = self
        brandListCollectionView.dataSource = self
    }
}

// MARK: - Action Methods

extension FourthOnboardingVC {
    func updateProgressViewWithAnimation() {
        UIView.animate(withDuration: 0.3) {
            if self.progressView.progress != 1 {
                self.progressView.setProgress(1, animated: true)
            }
        }
    }
    
    @objc
    func touchUpBrandSelectView(_ sender: UITapGestureRecognizer) {
        if isPresentListView {
            isPresentListView = false

            self.listView.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
            self.brandListCollectionView.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
            
            UIView.animate(withDuration: 0.5) {
                self.selectButton.isHidden = true
                self.view.layoutIfNeeded()
            }
        } else {
            isPresentListView = true
            listView.isHidden = false
            
            self.listView.snp.updateConstraints { make in
                make.height.equalTo(435)
            }
            self.brandListCollectionView.snp.updateConstraints { make in
                make.leading.trailing.equalToSuperview().inset(13)
                make.top.equalToSuperview().inset(16)
                make.height.equalTo(330)
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            }) { _ in
                self.selectButton.isHidden = false
            }
            isPresentListView = true
        }
    }
    
    @objc
    func touchUpSelectButton(_ sender: UIButton) {
        brandSelectView.layer.borderWidth = 1
        brandSelectView.layer.borderColor = UIColor.omMainOrange.cgColor
        brandSelectLabel.textColor = .omMainOrange
        brandSelectLabel.font = UIFont(name: "NotoSansCJKKR-Medium", size: 15)
        brandSelectLabel.text = selectedBrandName
        icToggleImageView.image = UIImage(named: "icToggle")
        
        //렌즈입력 텍스트필드 활성화
        icToggleImageView.image = UIImage(named: "icToggleBrandselectPressed")
        lensTextView.isEditable = true
    }
}

// MARK: - Notification

extension FourthOnboardingVC {
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(buttonActive), name: NSNotification.Name("buttonActive"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(buttonInActive), name: NSNotification.Name("buttonInActive"), object: nil)
    }
    
    @objc
    private func buttonActive(_ notification: Notification) {
        if isBrandSelected && isPurposeSelected {
            if lensTextView.text != "" && lensTextView.text != "렌즈명을 입력해주세요" {
                nextButton.isEnabled = true
                nextButton.backgroundColor = .omMainOrange
            } else {
                print("렌즈명도 입력해주셔야 합니다.")
            }
        }
    }
    
    @objc
    private func buttonInActive() {
        nextButton.isEnabled = false
        nextButton.backgroundColor = .omFourthGray
    }
}

// MARK: - UITextView Delegate

extension FourthOnboardingVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if lensTextView.textColor == .omThirdGray {
            lensTextView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            lensTextView.text = ""
            lensTextView.layer.borderWidth = 0
            NotificationCenter.default.post(name: NSNotification.Name("buttonInActive"), object: lensTextView.text)
            print("렌즈명 입력해라.")
            warningLabel.isHidden = false
        } else {
            lensTextView.textColor = .omMainOrange
            lensTextView.font = UIFont(name: "NotoSansCJKKR-Medium", size: 15)
            lensTextView.layer.borderWidth = 1
            lensTextView.layer.borderColor = UIColor.omMainOrange.cgColor
            warningLabel.isHidden = true
            NotificationCenter.default.post(name: NSNotification.Name("buttonActive"), object: lensTextView.text)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
}

// MARK: - UICollectionView Delegate

extension FourthOnboardingVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == brandListCollectionView {
            isBrandSelected = true
            selectButton.isEnabled = true
            selectButton.backgroundColor = .omMainOrange
            selectedBrandName = brandList[indexPath.row].brandName
            
            NotificationCenter.default.post(name: NSNotification.Name("buttonActive"), object: isBrandSelected)
        }
        if collectionView == purposeListCollectionView {
            isPurposeSelected = true
            
            NotificationCenter.default.post(name: NSNotification.Name("buttonActive"), object: isPurposeSelected)
        }
    }
}

// MARK: - UICollectionView DataSource

extension FourthOnboardingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case purposeListCollectionView:
            return purposeList.count
        case brandListCollectionView:
            return brandList.count
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
        case brandListCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LensBrandCVC.identifier, for: indexPath) as? LensBrandCVC else {
                return UICollectionViewCell()
            }
            cell.initCell(brandLogoImage: brandList[indexPath.row].brandLogoImage, brandName: brandList[indexPath.row].brandName)
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
            return CGSize(width: 100, height: 74)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == brandListCollectionView {
            return 4
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == brandListCollectionView {
            return 4
        }
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == brandListCollectionView {
            return .zero
        }
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
