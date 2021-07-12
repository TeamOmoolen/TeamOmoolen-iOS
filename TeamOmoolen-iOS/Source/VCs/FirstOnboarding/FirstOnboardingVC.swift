//
//  FirstOnboardingVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/06/30.
//

import UIKit

class FirstOnboardingVC: UIViewController {
    var gender = ""
    var age = ""
    
    // MARK: - UIComponents
    @IBOutlet weak var customNavigationBarViewHeight: NSLayoutConstraint!
    @IBOutlet weak var progressBarLeftAnchor: NSLayoutConstraint!
    @IBOutlet weak var indexLeftAnchor: NSLayoutConstraint!
    @IBOutlet weak var indexRightAnchor: NSLayoutConstraint!
    @IBOutlet weak var guideLabel1LeftAnchor: NSLayoutConstraint!
    @IBOutlet weak var guideLabel1BottomAnchor: NSLayoutConstraint!
    @IBOutlet weak var guideLabel1TopAnchor: NSLayoutConstraint!
    @IBOutlet weak var genderListCollectionViewTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var genderListCollectionViewLeftAnchor: NSLayoutConstraint!
    @IBOutlet weak var genderListCollectionViewRightAnchor: NSLayoutConstraint!
    @IBOutlet weak var guideLable3TopAnchor: NSLayoutConstraint!
    @IBOutlet weak var nextButtonBottomAnchor: NSLayoutConstraint!
    @IBOutlet weak var genderListCollectionViewRatio: NSLayoutConstraint!
    
    
    
    
    @IBOutlet weak var customNavigationBarView: UIView!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var guideLabel1: UILabel!
    @IBOutlet weak var guideLabel2: UILabel!
    @IBOutlet weak var guideLabel3: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var genderListCollectionView: UICollectionView!
    @IBOutlet weak var ageListCollectionView: UICollectionView!
    
    // MARK: - Local Variables
    
    private var genderList : [GenderDataModel] = []
    private var ageList : [AgeDataModel] = []
    
    private var isGenderSelected = false
    private var isAgeSelected = false
    
    private var navigationBar = UIView()
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setPhoneResolution()
        setNavigationController()
        setList()
        setCollectionViewDelegate()
        registerXib()
    }
    
    // MARK: - @IBAction Methods
    @IBAction func pushToSecondOnboarding(_ sender: Any) {
        guard let nextVC = UIStoryboard(name: Const.Storyboard.Name.SecondOnboarding, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.SecondOnboarding) as? SecondOnboardingVC else {
            return
        }
        if genderListCollectionView.indexPathsForSelectedItems! == [[0,0]] {
            gender = "여성"
        } else {
            gender = "남성"
        }
        
        if ageListCollectionView.indexPathsForSelectedItems! == [[0,0]] {
            age = "10대"
        } else if ageListCollectionView.indexPathsForSelectedItems! == [[0,1]] {
            age = "20대"
        } else if ageListCollectionView.indexPathsForSelectedItems! == [[0,2]] {
            age = "30대"
        } else {
            age = "40대 이상"
        }
        nextVC.gender = gender
        nextVC.age = age
        print("gender: \(gender) , age: \(age)")
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

// MARK: - Custom Methods

extension FirstOnboardingVC {
    func setNavigationController() {
        self.navigationController?.navigationBar.isHidden = true
        
        setupNavigationBar(customNavigationBarView: customNavigationBarView, title: "맞춤 정보 설정")
    }
    
    func setPhoneResolution(){
        if UIDevice.current.isiPhoneSE2 {
            customNavigationBarViewHeight.constant = 50
            
            progressBarLeftAnchor.constant = 16
            indexLeftAnchor.constant = 9
            indexRightAnchor.constant = 18
            
            guideLabel1TopAnchor.constant = 29
            guideLabel1LeftAnchor.constant = 16
            guideLabel1BottomAnchor.constant = 6
            
            guideLabel1.font = UIFont(name: "NotoSansCJKKR-Bold", size: 16)
            
            genderListCollectionViewTopAnchor.constant = 15
            genderListCollectionViewLeftAnchor.constant = 11
            genderListCollectionViewRightAnchor.constant = 11
            
            guideLable3TopAnchor.constant = 31
            guideLabel3.font = UIFont(name: "NotoSansCJKKR-Bold", size: 16)

            nextButtonBottomAnchor.constant = 28

            
//            genderListCollectionViewRatio = 352:140
        }
    }
    
    func setUI() {
        view.backgroundColor = .omAlmostwhite
        genderListCollectionView.backgroundColor = .omAlmostwhite
        ageListCollectionView.backgroundColor = .omAlmostwhite
        
        progressView.progress = 0
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.updateProgressViewWithAnimation()
        }

        progressView.tintColor = .systemOrange
        
        progressLabel.text = "1/4"
        progressLabel.font = UIFont(name: "Roboto-Regular", size: 12)
        progressLabel.textColor = .omThirdGray
        
        guideLabel1.text = "성별을 알려주세요!"
        guideLabel1.textColor = .omMainBlack
        guideLabel1.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)
        
        guideLabel2.text = "연령과 성별에 따라 많이 찾는 렌즈를 추천해드릴게요!"
        guideLabel2.textColor = .omFourthGray
        guideLabel2.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        
        guideLabel3.text = "나이를 알려주세요!"
        guideLabel3.textColor = .omMainBlack
        guideLabel3.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)
        
        nextButton.backgroundColor = .omFourthGray
        nextButton.setTitle("다음", for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "NotoSansCJKKR-Regular", size: 18)
        nextButton.tintColor = .omWhite
        nextButton.isUserInteractionEnabled = false
        
        nextButton.layer.cornerRadius = 10
        nextButton.layer.masksToBounds = true
    }
    
    func setList() {
        genderList.append(contentsOf: [
            GenderDataModel(genderImage: "imgFemaleOnboarding", gender: "여성"),
            GenderDataModel(genderImage: "imgMaleOnboarding", gender: "남성")
        ])
        
        ageList.append(contentsOf: [
            AgeDataModel(age: "10대"),
            AgeDataModel(age: "20대"),
            AgeDataModel(age: "30대"),
            AgeDataModel(age: "40대 이상")
        ])
    }
    
    func registerXib() {
        let genderNib = UINib(nibName: GenderCVC.identifier, bundle: nil)
        genderListCollectionView.register(genderNib, forCellWithReuseIdentifier: GenderCVC.identifier)
        
        let ageNib = UINib(nibName: AgeCVC.identifier, bundle: nil)
        ageListCollectionView.register(ageNib, forCellWithReuseIdentifier: AgeCVC.identifier)
    }
    
    func setCollectionViewDelegate() {
        genderListCollectionView.delegate = self
        genderListCollectionView.dataSource = self
        
        ageListCollectionView.delegate = self
        ageListCollectionView.dataSource = self
    }
}

// MARK: - Action Methods

extension FirstOnboardingVC {
    func updateProgressViewWithAnimation() {
        UIView.animate(withDuration: 0.5) {
            if self.progressView.progress != 0.25 {
                self.progressView.setProgress(0.25, animated: true)
            }
        }
    }
}

// MARK: - UICollectionView Delegate
extension FirstOnboardingVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if genderListCollectionView.indexPathsForSelectedItems?.isEmpty == false && ageListCollectionView.indexPathsForSelectedItems?.isEmpty == false {
            nextButton.backgroundColor = .omMainOrange
            nextButton.isUserInteractionEnabled = true
        } else {
            nextButton.backgroundColor = .omFourthGray
            nextButton.isUserInteractionEnabled = false
        }
    }
}

// MARK: - UICollectionView DataSource

extension FirstOnboardingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case genderListCollectionView:
            return genderList.count
        case ageListCollectionView:
            return ageList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case genderListCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenderCVC.identifier, for: indexPath) as? GenderCVC else {
                return UICollectionViewCell()
            }
            cell.layer.applyShadow(color: .black, alpha: 0.14, x: 2, y: 2, blur: 7, spread: 0)
            cell.contentView.layer.cornerRadius = 10
            cell.contentView.layer.masksToBounds = true
            cell.initCell(genderImageName: genderList[indexPath.row].genderImage, gender: genderList[indexPath.row].gender)
            return cell
        case ageListCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AgeCVC.identifier, for: indexPath) as? AgeCVC else {
                return UICollectionViewCell()
            }
            cell.layer.applyShadow(color: .black, alpha: 0.14, x: 2, y: 2, blur: 7, spread: 0)
            cell.contentView.layer.cornerRadius = 10
            cell.contentView.layer.masksToBounds = true
            cell.initCell(age: ageList[indexPath.row].age)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionView DelegateFlowLayout

extension FirstOnboardingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == genderListCollectionView {
            if UIDevice.current.isiPhoneSE2 {
                let width = collectionView.frame.width
                let height = collectionView.frame.height
                let cellWidth = (width - 23) / 2
                return CGSize(width: cellWidth, height: height - 10)
            } else {
                let width = collectionView.frame.width
                let height = collectionView.frame.height
                let cellWidth = (width - 19) / 2
                return CGSize(width: cellWidth, height: height - 10)
            }
        } else {
            if UIDevice.current.isiPhoneSE2 {
                let width = collectionView.frame.width
                let height = collectionView.frame.height
                let cellWidth = (width - 19) / 2
                let cellHeight = (height - 20) / 2
                return CGSize(width: cellWidth, height: cellHeight)
            } else {
                let width = collectionView.frame.width
                let height = collectionView.frame.height
                let cellWidth = (width - 19) / 2
                let cellHeight = (height - 20) / 2
                return CGSize(width: cellWidth, height: cellHeight)
            }
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
