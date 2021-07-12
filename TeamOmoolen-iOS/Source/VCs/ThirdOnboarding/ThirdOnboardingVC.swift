//
//  ThirdOnboardingVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/06/30.
//

import UIKit

class ThirdOnboardingVC: UIViewController {
    
    //Mark: - Properties
    private var functionList: [FunctionDataModel] = []
    private var timeList: [TimeDataModel] = []
    var gender = ""
    var age = ""
    var lensKind = [String]()
    var lensColor = [String]()
    var lensFunction = ""
    var lensPeriod = ""
    
    // MARK: - IBOutlet Properties
    @IBOutlet weak var customNavigationBarViewHeight: NSLayoutConstraint!
    @IBOutlet weak var progressBarLeftAnchor: NSLayoutConstraint!
    @IBOutlet weak var indexLeftAnchor: NSLayoutConstraint!
    @IBOutlet weak var indexRightAnchor: NSLayoutConstraint!
    @IBOutlet weak var FunctionMainLabelTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var FunctionMainLabelLeftAnchor: NSLayoutConstraint!
    @IBOutlet weak var FunctionMainLabelBottomAnchor: NSLayoutConstraint!
    @IBOutlet weak var functionListCollectionViewTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var functionListCollectionViewLeftAnchor: NSLayoutConstraint!
    @IBOutlet weak var functionListCollectionViewRightAnchor: NSLayoutConstraint!
    @IBOutlet weak var functionListCollectionViewBottomAnchor: NSLayoutConstraint!
    
    @IBOutlet weak var nextButtonBottomAnchor: NSLayoutConstraint!
    
    @IBOutlet weak var customNavigationBarView: UIView!
    @IBOutlet var baseView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var functionMainLabel: UILabel!
    @IBOutlet weak var functionSubLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var functionCollectionView: UICollectionView!
        
    @IBOutlet weak var timeCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - IBAction Properties
    @IBAction func nextButtonClicked(_ sender: Any) {
        guard let nextVC = UIStoryboard(name: Const.Storyboard.Name.FourthOnboarding, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.FourthOnboarding) as? FourthOnboardingVC else {
            return
        }
        
        if functionCollectionView.indexPathsForSelectedItems! == [[0,0]] {
            lensFunction = "근시"
        } else if functionCollectionView.indexPathsForSelectedItems! == [[0,1]] {
            lensFunction = "난시"
        } else if functionCollectionView.indexPathsForSelectedItems! == [[0,2]] {
            lensFunction = "다초점"
        } else {
            lensFunction = "없음"
        }
        
        if timeCollectionView.indexPathsForSelectedItems! == [[0,0]] {
            lensPeriod = "원데이"
        } else if timeCollectionView.indexPathsForSelectedItems! == [[0,1]] {
            lensPeriod = "2~6 days"
        } else if timeCollectionView.indexPathsForSelectedItems! == [[0,2]] {
            lensPeriod = "1 week"
        } else if timeCollectionView.indexPathsForSelectedItems! == [[0,3]] {
            lensPeriod = "2 weeks"
        } else if timeCollectionView.indexPathsForSelectedItems! == [[0,4]] {
            lensPeriod = "1 month"
        } else if timeCollectionView.indexPathsForSelectedItems! == [[0,5]] {
            lensPeriod = "2~3 months"
        } else if timeCollectionView.indexPathsForSelectedItems! == [[0,6]] {
            lensPeriod = "4~6 months"
        } else if timeCollectionView.indexPathsForSelectedItems! == [[0,7]] {
            lensPeriod = "6 months +"
        } else {
            lensPeriod = "없음"
        }

        
        nextVC.age = age
        nextVC.gender = gender
        nextVC.lensKind = lensKind
        nextVC.lensColor = lensColor
        nextVC.lensFunction = lensFunction
        nextVC.lensPeriod = lensPeriod
        print("gender: \(gender) , age: \(age), lensKind: \(lensKind), lensColor: \(lensColor), lensFunction: \(lensFunction), lensPeriod: \(lensPeriod)")
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //Mark: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setPhoneResolution()
        setNavigationBar()
        setCollectionViewDelegate()
        registerCell()
        setFunctionList()
        setTimeList()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.updateProgressViewWithAnimation()
        }
        
    }
    //Mark: - Methods
    func setUI(){
        baseView.backgroundColor = .omAlmostwhite
        
        progressView.progress = 0.5
        progressView.progressTintColor = .omMainOrange
        
        
        progressLabel.text = "3/4"
        progressLabel.textColor = .omThirdGray
        progressLabel.font = UIFont(name: "Roboto-Regular", size: 12)

        
        functionMainLabel.text = "어떤 기능의 렌즈가 필요하세요?"
        functionMainLabel.textColor = .omMainBlack
        functionMainLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)
        
        functionCollectionView.backgroundColor = .omAlmostwhite
        functionSubLabel.text = "기능을 선택하시면 필요에 맞게 렌즈를 추천해드릴게요!"
        functionSubLabel.textColor = .omFourthGray
        functionSubLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)

        
        timeCollectionView.backgroundColor = .omAlmostwhite
        timeLabel.text = "어떤 주기의 렌즈를 찾으시나요?"
        timeLabel.textColor = .omMainBlack
        timeLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)

                
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "NotoSansCJKKR-Regular", size: 18)
        nextButton.tintColor = .omWhite
        nextButton.backgroundColor = .omFourthGray
        nextButton.layer.cornerRadius = 10
        nextButton.isUserInteractionEnabled = false
        
    }
    
    func setPhoneResolution() {
        if UIDevice.current.isiPhoneSE2{
            
            customNavigationBarViewHeight.constant = 50
            
            functionMainLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 16)
            
            timeLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 16)
            
            progressBarLeftAnchor.constant = 16
            indexRightAnchor.constant = 18
            indexLeftAnchor.constant = 9
            
            FunctionMainLabelTopAnchor.constant = 29
            FunctionMainLabelLeftAnchor.constant = 16
            FunctionMainLabelBottomAnchor.constant = 6
            
            functionListCollectionViewTopAnchor.constant = 15
            functionListCollectionViewLeftAnchor.constant = 11
            functionListCollectionViewRightAnchor.constant = 11
            functionListCollectionViewBottomAnchor.constant = 31
            
            
            nextButtonBottomAnchor.constant = 28        }
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        setupNavigationBar(customNavigationBarView: customNavigationBarView, title: "맞춤 정보 설정")
    }
    
    func setCollectionViewDelegate() {
        
        functionCollectionView.delegate = self
        functionCollectionView.dataSource = self
        
        timeCollectionView.delegate = self
        timeCollectionView.dataSource = self
        
    }
    
    func registerCell() {
        let functionNib = UINib(nibName: "FunctionCVC", bundle: nil)
        functionCollectionView.register(functionNib, forCellWithReuseIdentifier: "FunctionCVC")
        
        let timeNib = UINib(nibName: "TimeCVC", bundle: nil)
        timeCollectionView.register(timeNib, forCellWithReuseIdentifier: "TimeCVC")
        
    }
    
    func setFunctionList() {
        functionList.append(contentsOf: [FunctionDataModel(functionName: "근시"),
                                         FunctionDataModel(functionName: "난시"),
                                         FunctionDataModel(functionName: "다초점"),
                                         FunctionDataModel(functionName: "없음")
        ])
        
    }
    
    func setTimeList() {
        timeList.append(contentsOf: [TimeDataModel(timeType: "원데이"), TimeDataModel(timeType: "2~6 days"), TimeDataModel(timeType: "1 week"),TimeDataModel(timeType:"2 weeks"), TimeDataModel(timeType:"1 month"), TimeDataModel(timeType: "2~3 months"), TimeDataModel(timeType:"4~6  months"), TimeDataModel(timeType: "6 months + "), TimeDataModel(timeType: "없음")
        ])
        
    }
    
    func updateProgressViewWithAnimation(){
        UIView.animate(withDuration: 0.5) {
            if self.progressView.progress != 0.75 {
                self.progressView.setProgress(0.75, animated: true)
            }
        }
    }

  

}

//Mark: - Extensions
//Mark: - UICollectionViewDataSource

extension ThirdOnboardingVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)->Int {
        
        if collectionView == functionCollectionView {
            return functionList.count
        } else if collectionView == timeCollectionView {
            return timeList.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == functionCollectionView {
            guard let functionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FunctionCVC", for: indexPath) as? FunctionCVC else {
                return UICollectionViewCell()
            }
            functionCell.layer.applyShadow(color: .black, alpha: 0.14, x: 2, y: 2, blur: 7, spread: 0)
            
            functionCell.backgroundColor = .white
            functionCell.setData(functionName: functionList[indexPath.row].functionName)
            
            functionCell.layer.cornerRadius = 7
            functionCell.contentView.layer.cornerRadius = 20
            functionCell.contentView.layer.masksToBounds = true
            
            return functionCell
            
        } else if collectionView == timeCollectionView {
            guard let timeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCVC", for: indexPath) as? TimeCVC else {
                return UICollectionViewCell()
            }
            timeCell.layer.applyShadow(color: .black, alpha: 0.14, x: 2, y: 2, blur: 7, spread: 0)
            timeCell.backgroundColor = .white
            timeCell.setData(timeType: timeList[indexPath.row].timeType)
            timeCell.layer.cornerRadius = 10
            timeCell.contentView.layer.cornerRadius = 20
            timeCell.contentView.layer.masksToBounds = true
            
            return timeCell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension ThirdOnboardingVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if functionCollectionView.indexPathsForSelectedItems?.isEmpty == false && timeCollectionView.indexPathsForSelectedItems?.isEmpty == false {
                        
            nextButton.backgroundColor = .omMainOrange
            nextButton.isUserInteractionEnabled = true
            
            
        } else {
            nextButton.backgroundColor = .omFourthGray
            nextButton.isUserInteractionEnabled = false
        }
    }
}


//Mark: - UICollectionViewDelegate

extension ThirdOnboardingVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == functionCollectionView {
            return CGSize(width: (collectionView.frame.width - 19) / 2, height: (collectionView.frame.height - 22) / 2)
        } else {
            return CGSize(width: (collectionView.frame.width - 30) / 3, height: (collectionView.frame.height - 34) / 3)
        }

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == functionCollectionView {
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        } else {
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == functionCollectionView {
            return 12
        } else {
            return 12
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == functionCollectionView {
            return 9
        } else {
            return 10
        }
    }
    
}
