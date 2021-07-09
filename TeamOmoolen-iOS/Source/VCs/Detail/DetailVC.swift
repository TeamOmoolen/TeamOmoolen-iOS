//
//  DetailVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/08.
//

import UIKit

class DetailVC: UIViewController {
    
    // MARK: - UI Components
    
    @IBOutlet weak var detailTableView: UITableView!
    
    private lazy var writeButton: UIButton = {
        let button = UIButton()
        button.layer.shadowRadius = 2
        button.setImage(UIImage(named: "icWrite"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 48,
                                                     weight: .light,
                                                     scale: .large),
                                               forImageIn: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        registerXib()
        setTableView()
    }
}

extension DetailVC {
    func setUI() {
        view.addSubview(writeButton)
        
        writeButton.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(688)
//            make.top.equalToSuperview().offset(629)
        }
    }
    
    func registerXib() {
        let topNib = UINib(nibName: DetailTopTVC.identifier, bundle: nil)
        detailTableView.register(topNib, forCellReuseIdentifier: DetailTopTVC.identifier)
        
        let reviewNib = UINib(nibName: ReviewTVC.identifier, bundle: nil)
        detailTableView.register(reviewNib, forCellReuseIdentifier: ReviewTVC.identifier)
        
        let similarNib = UINib(nibName: DetailSimilarTVC.identifier, bundle: nil)
        detailTableView.register(similarNib, forCellReuseIdentifier: DetailSimilarTVC.identifier)
        
        let newNib = UINib(nibName: DetailNewTVC.identifier, bundle: nil)
        detailTableView.register(newNib, forCellReuseIdentifier: DetailNewTVC.identifier)
    }
    
    func setTableView() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        detailTableView.separatorStyle = .none
    }
}

extension DetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 838
        case 1:
            return 1315
        case 2:
            return 756
        case 3:
            return 650
        default:
            return UITableView.automaticDimension
        }
    }
}

extension DetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTopTVC.identifier) as? DetailTopTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTVC.identifier) as? ReviewTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailSimilarTVC.identifier) as? DetailSimilarTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailNewTVC.identifier) as? DetailNewTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
}
