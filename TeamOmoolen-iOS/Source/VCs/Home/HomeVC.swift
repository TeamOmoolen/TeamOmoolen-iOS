//
//  HomeVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/03.
//

import UIKit
import SnapKit
import Moya

class HomeVC: UIViewController {
    
    // MARK: - UI Components
   
    @IBOutlet weak var homeHeaderView: UIView!
    @IBOutlet weak var homeTableView: UITableView!
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchIcon: UIImageView!
    @IBOutlet weak var searchLabel: UILabel!
    
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    private lazy var topButton: UIButton = {
        let button = UIButton()
        button.layer.shadowColor  = UIColor.gray.cgColor
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 2
        button.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 20,
                                                     weight: .light,
                                                     scale: .large),
                                               forImageIn: .normal)
        button.addTarget(self, action: #selector(touchUpTop), for: .touchUpInside)
        return button
    }()
    
    private lazy var categoryView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    
    // MARK: - Local Variables
    private var homeList = HomeResponse(username: "", findRecomendationByUser: [FindRecomendationByUser(id: 0, name: "", imageList: [""], category: "", color: 0, price: 0, brand: "", releaseDate: "", diameter: 0, changeCycle: 0, pieces: 0, otherColorList: [0])], guides: [Guide(id: 0, question: "", answer: "")], recommendationBySeason: [FindRecomendationByUser(id: 0, name: "", imageList: [""], category: "", color: 0, price: 0, brand: "", releaseDate: "", diameter: 0, changeCycle: 0, pieces: 0, otherColorList: [0])], deadlineEvent: [Event(id: 0, title: "", content: "", image: "")], newLens: NewLens1(brand1: [FindRecomendationByUser(id: 0, name: "", imageList: [""], category: "", color: 0, price: 0, brand: "", releaseDate: "", diameter: 0, changeCycle: 0, pieces: 0, otherColorList: [0])], brand2: [FindRecomendationByUser(id: 0, name: "", imageList: [""], category: "", color: 0, price: 0, brand: "", releaseDate: "", diameter: 0, changeCycle: 0, pieces: 0, otherColorList: [0])], brand3: [FindRecomendationByUser(id: 0, name: "", imageList: [""], category: "", color: 0, price: 0, brand: "", releaseDate: "", diameter: 0, changeCycle: 0, pieces: 0, otherColorList: [0])]) , recommendationBySituation: [FindRecomendationByUser(id: 0, name: "", imageList: [""], category: "", color: 0, price: 0, brand: "", releaseDate: "", diameter: 0, changeCycle: 0, pieces: 0, otherColorList: [0])], lastestEvent: [Event(id: 0, title: "", content: "", image: "")])
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setList()
        setNotificationLoginErr()
        registerXib()
        setHomeTableView()
        getHomeWithAPI()
    }
}

// MARK:- Custom Methods

extension HomeVC {
    func setUI() {
        view.backgroundColor = .omAlmostwhite
        
        homeHeaderView.backgroundColor = .white
        homeTableView.backgroundColor = .white
        
//        view.addSubview(categoryView)
        view.addSubview(topButton)
        
//        categoryView.snp.makeConstraints { make in
//            make.width.equalToSuperview()
//            make.height.equalTo(121)
//            make.top.equalTo(homeHeaderView.snp.bottom).offset(5)
//        }
        
        topButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.trailing.equalToSuperview().inset(25)
            make.bottom.equalToSuperview().inset(-100)
        }
        
        logoImageView.image = UIImage(named: "abc")
        
        searchView.layer.borderColor = UIColor.omMainOrange.cgColor
        searchView.layer.borderWidth = 1
        searchView.layer.cornerRadius = 8
        searchView.layer.masksToBounds = true
        
        searchIcon.image = UIImage(named: "abc")
        searchLabel.text = "오늘은 무슨 렌즈끼지?"
        searchLabel.textColor = .omFourthGray
        searchLabel.font = UIFont(name: "NotoSansCJKKR-Medium", size: 13)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpSearchView))
        searchView.addGestureRecognizer(tapGesture)
    }
    
    func setList() {
        
    }
    
    func registerXib() {
        let categoryNib = UINib(nibName: CategoryTVC.identifier, bundle: nil)
        homeTableView.register(categoryNib, forCellReuseIdentifier: CategoryTVC.identifier)
        
        let recommedNib = UINib(nibName: RecommendTVC.identifier, bundle: nil)
        homeTableView.register(recommedNib, forCellReuseIdentifier: RecommendTVC.identifier)
        
        let oneMinNib = UINib(nibName: OneMinTVC.identifier, bundle: nil)
        homeTableView.register(oneMinNib, forCellReuseIdentifier: OneMinTVC.identifier)
        
        let seasonNib = UINib(nibName: SeasonTVC.identifier, bundle: nil)
        homeTableView.register(seasonNib, forCellReuseIdentifier: SeasonTVC.identifier)
        
        let newLensNib = UINib(nibName: NewLensTVC.identifier, bundle: nil)
        homeTableView.register(newLensNib, forCellReuseIdentifier: NewLensTVC.identifier)
        
        let timeRecommendNib = UINib(nibName: SituationTVC.identifier, bundle: nil)
        homeTableView.register(timeRecommendNib, forCellReuseIdentifier: SituationTVC.identifier)
        
        let lastBannerNib = UINib(nibName: LastBannerTVC.identifier, bundle: nil)
        homeTableView.register(lastBannerNib, forCellReuseIdentifier: LastBannerTVC.identifier)
    }
    
    func setHomeTableView() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        homeTableView.separatorStyle = .none
    }
    
    func getHomeWithAPI() {
        OnboardingAPI.shared.getHomeWithAPI() { response in
            self.homeList = response
            print(self.homeList)
        }
    }
}

// MARK: - Action Methods
extension HomeVC {
    @objc
    func touchUpTop() {
        let topIndex = IndexPath(row: 0, section: 0)
        homeTableView.scrollToRow(at: topIndex, at: .top, animated: true)
    }
    
    @objc
    func touchUpSearchView(_ sender: UITapGestureRecognizer) {
        print("SearchVC로 이동")
        searchLabel.isHidden = true
    }
}

// MARK: - UITableView Delegate

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 121
        case 1:
            return 371
        case 2:
            return 551
        case 3:
            return 1083
        case 4:
            return 180
        case 5:
            return 807
        case 6:
            return 1085
        case 7:
            return 230
        default:
            return UITableView.automaticDimension
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 10 {
            topButton.isHidden = false
            
//            categoryView.snp.updateConstraints { make in
//                make.height.equalTo(60)
//            }
//
//            tableViewTopConstraint.constant = 60
            
            topButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(100)
            }
        } else {
            topButton.isHidden = true
            
//            categoryView.snp.updateConstraints { make in
//                make.height.equalTo(121)
//            }
//            
//            tableViewTopConstraint.constant = 121
            
            topButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(-100)
            }
        }
        
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - UITableView DataSource

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  CategoryTVC.identifier, for: indexPath) as? CategoryTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  RecommendTVC.identifier, for: indexPath) as? RecommendTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  OneMinTVC.identifier, for: indexPath) as? OneMinTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  SeasonTVC.identifier, for: indexPath) as? SeasonTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 4:
            return UITableViewCell()
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  NewLensTVC.identifier, for: indexPath) as? NewLensTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 6:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  SituationTVC.identifier, for: indexPath) as? SituationTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 7:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  LastBannerTVC.identifier, for: indexPath) as? LastBannerTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
}
