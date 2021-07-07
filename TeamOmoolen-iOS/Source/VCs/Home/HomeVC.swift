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
    @IBOutlet weak var searchTextField: UITextField!
    
    
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
        
        view.addSubview(categoryView)
        view.addSubview(topButton)
        
        categoryView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(121)
            make.top.equalTo(homeHeaderView.snp.bottom).offset(5)
        }
        
        topButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.trailing.equalToSuperview().inset(25)
            make.bottom.equalToSuperview().inset(-100)
        }
        
        logoImageView.image = UIImage(named: "abc")
        
        searchTextField.borderStyle = .roundedRect
        searchTextField.layer.borderColor = UIColor.omMainOrange.cgColor
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.cornerRadius = 5
        searchTextField.layer.masksToBounds = true
        searchTextField.placeholder = "오늘 무슨 렌즈 끼지?"
    }
    
    func setList() {
        
    }
    
    func registerXib() {
        let recommedNib = UINib(nibName: RecommendTVC.identifier, bundle: nil)
        homeTableView.register(recommedNib, forCellReuseIdentifier: RecommendTVC.identifier)
        
        let oneMinNib = UINib(nibName: OneMinTVC.identifier, bundle: nil)
        homeTableView.register(oneMinNib, forCellReuseIdentifier: OneMinTVC.identifier)
        
        let seasonNib = UINib(nibName: SeasonTVC.identifier, bundle: nil)
        homeTableView.register(seasonNib, forCellReuseIdentifier: SeasonTVC.identifier)
        
        let newLensNib = UINib(nibName: NewLensTVC.identifier, bundle: nil)
        homeTableView.register(newLensNib, forCellReuseIdentifier: NewLensTVC.identifier)
        
        let timeRecommendNib = UINib(nibName: TimeRecommendTVC.identifier, bundle: nil)
        homeTableView.register(timeRecommendNib, forCellReuseIdentifier: TimeRecommendTVC.identifier)
        
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
//            response.
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
}

// MARK: - UITableView Delegate

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 371
        case 1:
            return 551
        case 2:
            return 1083
        case 3:
            return 180
        case 4:
            return 807
        case 5:
            return 780
        case 6:
            return 230
        default:
            return UITableView.automaticDimension
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 10 {
            topButton.isHidden = false
            
            categoryView.snp.updateConstraints { make in
                make.height.equalTo(60)
            }
            
            tableViewTopConstraint.constant = 60
            
            topButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(100)
            }
        } else {
            topButton.isHidden = true
            
            categoryView.snp.updateConstraints { make in
                make.height.equalTo(121)
            }
            
            tableViewTopConstraint.constant = 121
            
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
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  RecommendTVC.identifier, for: indexPath) as? RecommendTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  OneMinTVC.identifier, for: indexPath) as? OneMinTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  SeasonTVC.identifier, for: indexPath) as? SeasonTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 3:
            return UITableViewCell()
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  NewLensTVC.identifier, for: indexPath) as? NewLensTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  TimeRecommendTVC.identifier, for: indexPath) as? TimeRecommendTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 6:
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
