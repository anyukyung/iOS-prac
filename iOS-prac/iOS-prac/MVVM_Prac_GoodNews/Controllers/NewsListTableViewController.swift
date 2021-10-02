//
//  NewsListTableViewController.swift
//  iOS-prac
//
//  Created by kong on 2021/10/02.
//

import UIKit

//ViewController에서는 단순히 ViewModel에서 전달하는 데이터를 화면에 전달해주기만 할 것이다.

class NewsListTableViewController: UITableViewController {
    
    //뷰모델에서 데이터 받아오기 위해서 선언
    private var articleListVM : ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    //난 걍 URL관련 처리도 서비스안에서 하는게 어떨까 싶엇는데 이분은 왜 여기다 하셧을까?! ㅋ.ㅋ 그치않아? 어떻게생각해
    //무튼 서비스에서 겟아티클 한다음에 테이블뷰 리로드 해주는 함수!
    private func setup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=e9b514c39c5f456db8ed4ecb693b0040")!
        WebService().getArticles(url: url) { //1
            (articles) in
            
            if let articles = articles {
                self.articleListVM = ArticleListViewModel(articles: articles) //2
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    //신기한게 테이블뷰 섹션수도 따로 모델에 빼서한거! 갠찬은거 같은데 나중에 수정하기에는 또 귀찮을 것 같기도하고
    //근데 적응하면 괜찮지 않을까 싶어..
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleListVM.numberOfRowsInSection(section)
    }
    
    
    //셀 등록하구 셀 안에 들어가는 요소들도 전부 뷰모델에서 받아와서 변경!
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell
        else {fatalError("no matched articleTableViewCell identifier")}
        
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row) //3
        cell.descriptionLabel?.text = articleVM.description
        cell.titleLabel?.text = articleVM.title
        return cell
    }
    
}
