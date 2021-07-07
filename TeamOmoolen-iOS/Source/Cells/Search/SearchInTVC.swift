//
//  SearchInTVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/06.
//
import Foundation
import UIKit
import RealmSwift

class SearchInTVC: UITableViewCell {

    static let identifier = "SearchInTVC"
    
    //Mark: - IB Outlets
    @IBOutlet weak var searchHistoryTableView: UITableView!
    
    //Mark: - Variables
    var enteredText: String?
    var realm: Realm?
    var firstRecentSearch: String!
    var secondRecentSearch: String!
    var thirdRecentSearch: String!

    
    //Mark: - Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        realm = try? Realm()
        registerXib()
        setSearchHistoryTable()
       // setSearchWords()
        checkNotification()
        checkSearchHistory()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Mark: - Methods
    func registerXib() {
        let SearchInNib = UINib(nibName: SearchInTVC.identifier, bundle: nil)
        
        let SearchWordNib = UINib(nibName: SearchWordTVC.identifier, bundle: nil)
        let NoRecentNib = UINib(nibName: NoRecentTVC.identifier, bundle: nil)
        let AllClearNib = UINib(nibName: AllClearTVC.identifier, bundle: nil)
        
        searchHistoryTableView.register(SearchWordNib, forCellReuseIdentifier: SearchWordTVC.identifier)
        searchHistoryTableView.register(NoRecentNib, forCellReuseIdentifier: NoRecentTVC.identifier)
        searchHistoryTableView.register(AllClearNib, forCellReuseIdentifier: AllClearTVC.identifier)

        
    }
    
    func setSearchHistoryTable() {
        searchHistoryTableView.delegate = self
        searchHistoryTableView.dataSource = self
        searchHistoryTableView.separatorStyle = .none
    }
   
    func checkNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(searchEntered), name: NSNotification.Name("search"), object: nil)
    }
    
    @objc func searchEntered(notification: NSNotification) {
        let enteredText = notification.object as! String
        
        
        if enteredText.isEmpty {
            //Alert 보내주기?
            print("검색어를 입력해 주세요")
        }
        //검색어 목록 배열로 전환
        let savedWords = realm?.objects(RecentSearch.self)
        let Results: Results<RecentSearch> = (savedWords)!
        let resultArray: [RecentSearch] = Results.toArray()
        let count = resultArray.count
        
        do {
            try realm!.write {
                let searchWord = RecentSearch()
                searchWord.word = enteredText
                if (count == 0) {
                    //처음 입력 받았을때
                    realm?.add(searchWord)
                    print("검색어를 입력해 주세요")
                }
                else if (count >= 3 && (resultArray[count-1].word == enteredText || resultArray[count-2].word == enteredText || resultArray[count-3].word == enteredText)) {
                    //같은게 이미 db에 존재한다면
                    print("db 추가할 필요 없음")
                } else {
                    realm?.add(searchWord)
                    print(realm?.objects(RecentSearch.self))
                }
            }
        } catch {
            print("문제")
        }
    }
    
    func inputData(database: RecentSearch) -> RecentSearch {
        if let text = enteredText {
            database.word = text
        }
        return database
    }
    
    func checkSearchHistory(){
        let savedWords = realm?.objects(RecentSearch.self)
        let Results: Results<RecentSearch> = (savedWords)!
        let resultArray: [RecentSearch] = Results.toArray()
        let count = resultArray.count
        if (savedWords?.isEmpty == true) {
            //저장된 검색어가 아예 없는 경우
        } else if (savedWords?.count == 1) {
            //검색어 하나만 존재
            firstRecentSearch = resultArray[0].word
            //NotificationCenter.default.post(name: NSNotification.Name("OneSearch"), object: firstRecentSearch)
            
        } else if (savedWords?.count == 2) {
            //검색어 두개 존재 stack view 3개 적용
            firstRecentSearch = resultArray[0].word
            secondRecentSearch = resultArray[1].word
            let myWords = [firstRecentSearch, secondRecentSearch]
            //NotificationCenter.default.post(name: NSNotification.Name("TwoSearch"), object: firstRecentSearch)
            
        } else {
            //realm에서 끝에 세 개 가져오기 -
            firstRecentSearch = resultArray[count-1].word
            secondRecentSearch = resultArray[count-2].word
            thirdRecentSearch = resultArray[count-3].word
            //let myWords = [firstRecentSearch,]
        }
    }
}

extension Results {
    func toArray() -> Array<Element> {
        return self.map{$0}
    }
}

extension SearchInTVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (realm?.objects(RecentSearch.self).count == 0) {
            switch indexPath.section {
            case 0:
                return 80 //최근검색어 없음
            
            case 1:
                return 48 //전체삭제
        
            default:
                return 50 //나중에 변경
            }
        } else if (realm?.objects(RecentSearch.self).count == 1) {
            switch indexPath.section {
            case 0:
                return 50 //단어 1
            case 1:
                return 48 //전체삭제
            default:
                return 50
            }
        } else if (realm?.objects(RecentSearch.self).count == 2) {
            switch indexPath.section {
            case 0:
                return 50 //단어 1
            case 1:
                return 50 //단어 2
            case 2:
                return 48 //전체삭제
            default:
                return 50
            }
        } else {
            //검색어 세개 다 꽉 찬 경우
            switch indexPath.section {
            case 0:
                return 50
            case 1:
                return 50
            case 2:
                return 50
            case 3:
                return 48
            default:
                return 50
            }
        }
    }
}


extension SearchInTVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //검색어 저장된 게 없음
        if (realm?.objects(RecentSearch.self).count == 0){
            return 2
        } else if (realm?.objects(RecentSearch.self).count == 1){
            return 2
        } else if (realm?.objects(RecentSearch.self).count == 2){
            return 3
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (realm?.objects(RecentSearch.self).count == 0) {
            switch indexPath.section {
            case 0: //최근검색어 없음
                guard let cell = tableView.dequeueReusableCell(withIdentifier:  NoRecentTVC.identifier, for: indexPath) as? NoRecentTVC else {
                    return UITableViewCell()
                }
                return cell
            case 1: //전체삭제 버튼
                guard let cell = tableView.dequeueReusableCell(withIdentifier:  AllClearTVC.identifier, for: indexPath) as? AllClearTVC else {
                    return UITableViewCell()
                }
                return cell
            default:
                return UITableViewCell()
            }
        } else if (realm?.objects(RecentSearch.self).count == 1) {
            switch indexPath.section {
            case 0: //단어 1
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchWordTVC.identifier, for: indexPath) as? SearchWordTVC else {
                    return UITableViewCell()
                }
                return cell
            case 1: //전체삭제 버튼
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AllClearTVC.identifier, for: indexPath) as? AllClearTVC else {
                    return UITableViewCell()
                }
                return cell
            default:
                return UITableViewCell()
            }
        } else if (realm?.objects(RecentSearch.self).count == 2){
            switch indexPath.section {
            case 0: //단어 1
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchWordTVC.identifier, for: indexPath) as? SearchWordTVC else {
                    return UITableViewCell()
                }
                return cell

            case 1: //단어 2
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchWordTVC.identifier, for: indexPath) as? SearchWordTVC else {
                    return UITableViewCell()
                }
                return cell
            
            case 2: //전체삭제
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AllClearTVC.identifier, for: indexPath) as? AllClearTVC else {
                    return UITableViewCell()
                }
                return cell
            default:
                return UITableViewCell()
            }
        } //3개 이상일 경우
            switch indexPath.section {
            case 0: //단어 1
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchWordTVC.identifier, for: indexPath) as? SearchWordTVC else {
                    return UITableViewCell()
                }
                cell.searchLabel.text = firstRecentSearch
                return cell
            
            case 1: //단어 2
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchWordTVC.identifier, for: indexPath) as? SearchWordTVC else {
                    return UITableViewCell()
                }
                cell.searchLabel.text = secondRecentSearch
                return cell
                
            case 2: //단어 3
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchWordTVC.identifier, for: indexPath) as? SearchWordTVC else {
                    return UITableViewCell()
                }
                cell.searchLabel.text = thirdRecentSearch
                return cell
                
            case 3: //전체삭제
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AllClearTVC.identifier, for: indexPath) as? SearchWordTVC else {
                return UITableViewCell()
                }
                return cell
            default:
                return UITableViewCell()
            }
        }
}
