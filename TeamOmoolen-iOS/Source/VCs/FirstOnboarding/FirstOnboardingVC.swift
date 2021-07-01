//
//  FirstOnboardingVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/06/30.
//

import UIKit

class FirstOnboardingVC: UIViewController {

    // MARK: - UIComponents
    
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
    
    // MARK: - View Life Cycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        progressView.progress = 0
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

extension FirstOnboardingVC {
    func setNavigationController() {
        
    }
    
    func setUI() {
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateProgressViewWithAnimation), userInfo: nil, repeats: true)
        progressView.tintColor = .systemOrange
        
        progressLabel.text = "1/4"
        progressLabel.textColor = . darkGray
        
        guideLabel1.text = "성별을 알려주세요!"
        guideLabel1.font = UIFont.boldSystemFont(ofSize: 17)
        
        guideLabel2.text = "연령과 성별에 따라 많이 찾는 렌즈를 추천해드릴게요!"
        guideLabel2.textColor = .lightGray
        
        guideLabel3.text = "나이를 알려주세요!"
        guideLabel3.font = UIFont.boldSystemFont(ofSize: 17)
        
        nextButton.backgroundColor = .lightGray
        nextButton.tintColor = .white
        nextButton.setTitle("다음", for: .normal)
    }
    
    func setList() {
        genderList.append(contentsOf: [
            GenderDataModel(genderImage: "abc", gender: "여자"),
            GenderDataModel(genderImage: "abc", gender: "남자")
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
    @objc func updateProgressViewWithAnimation() {
        UIView.animate(withDuration: 0.3) {
            if self.progressView.progress != 0.25 {
                self.progressView.setProgress(0.25, animated: true)
            }
        }
    }
}

// MARK: - UICollectionView Delegate
extension FirstOnboardingVC: UICollectionViewDelegate {
    
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
            cell.initCell(genderImageName: genderList[indexPath.row].genderImage, gender: genderList[indexPath.row].gender)
            return cell
        case ageListCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AgeCVC.identifier, for: indexPath) as? AgeCVC else {
                return UICollectionViewCell()
            }
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
            return CGSize(width: 160, height: 160)
        } else {
            return CGSize(width: 200, height: 60)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == genderListCollectionView {
            return 11
        } else {
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == genderListCollectionView {
            return 11
        } else {
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}
