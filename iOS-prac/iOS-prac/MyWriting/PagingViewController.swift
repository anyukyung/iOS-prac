//
//  PagingViewController.swift
//  iOS-prac
//
//  Created by kong on 2021/07/01.
//
import UIKit
import SnapKit

enum menuStatus: Int {
    case profile = 0
    case job = 1
    case weather = 2
}

class PagingViewController : UIViewController {
    
    private lazy var pagingCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white

        collectionView.register(PagingCollectionViewCell.self, forCellWithReuseIdentifier: PagingCollectionViewCell.identifier)
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .right)

        collectionView.delegate = self
        collectionView.dataSource = self

        return collectionView
    }()

    private var menuIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue

        return view
    }()

    private lazy var pageCollectionView: UICollectionView = {
        
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .right)

        collectionView.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: PageCollectionViewCell.identifier)

        collectionView.delegate = self
        collectionView.dataSource = self

        return collectionView
    }()

    var selectedIdx = 0
    var label = UILabel()
    var indicatorLayoutConstraint : [NSLayoutConstraint] = []

    let menu = ["글", "리워드", "휴지통"]
    let subViewControllers: [UIViewController] = [FirstViewController(), SecondViewController(), ThirdViewController()]
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
        setConstraint()
    }

    func setCollectionView() {
        collectionView(pagingCollectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
    }

    func setConstraint() {
        let views: [UIView] = [pagingCollectionView, menuIndicatorView, pageCollectionView]
        views.forEach { v in
            view.addSubview(v)
        }

        let labelSize = calcLabelSize(text: menu[0])
        pagingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(labelSize.height + 20)
        }

        menuIndicatorView.snp.makeConstraints { make in

            make.top.equalTo(pagingCollectionView.snp.bottom)
            make.width.equalTo(labelSize.width + 30)
            make.height.equalTo(5)
            //make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            print("이건 셋 컨스트레인ㅌ")

        }

        pageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(menuIndicatorView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    func wrapAndGetCell(viewColtroller: UIViewController, cell: PageCollectionViewCell) -> PageCollectionViewCell {
        viewColtroller.view.tag = PageCollectionViewCell.SUBVIEW_TAG
        cell.contentView.addSubview(viewColtroller.view)

        /// 다른 UIViewController, PageViewController 등의 컨테이너 뷰컨에서 다른 UIViewController가 추가, 삭제된 후에 호출된다.
        /// 인자로 부모 뷰컨을 넣어서 호출해줌..
        /// 자식 뷰컨이 부모 뷰컨으로부터 추가, 삭제되는 상황에 반응할 수 있도록.
        viewColtroller.didMove(toParent: self)
        return cell
    }

    func calcLabelSize(text: String) -> CGSize {
        label.text = text
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.sizeToFit()

        return label.bounds.size
    }

    func scrollToMenu(to index: Int) {
        pageCollectionView.selectItem(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .right)
    }
}

extension PagingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == pagingCollectionView {
            return 20
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == pagingCollectionView {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        }
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = menu[indexPath.row]
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.sizeToFit()

        if collectionView == pagingCollectionView {
            return CGSize(width: label.bounds.width + 30, height: label.bounds.height + 20)
        }
        let height = UIScreen.main.bounds.height - (pagingCollectionView.contentSize.height + 5)
        return CGSize(width: UIScreen.main.bounds.width, height: height)
    }
}

extension PagingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == pageCollectionView {
            return menu.count
        }
        return subViewControllers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case pagingCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PagingCollectionViewCell.identifier, for: indexPath) as? PagingCollectionViewCell else { return UICollectionViewCell() }

            if indexPath.row == 0 {
                cell.isSelected = true
                pagingCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init())
            } else {
                cell.isSelected = false
            }

            cell.setCell(menu: menu[indexPath.row])
            return cell
        case pageCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCollectionViewCell.identifier, for: indexPath) as? PageCollectionViewCell
            else { return UICollectionViewCell() }
            let sectionVC = subViewControllers[indexPath.row]

            return wrapAndGetCell(viewColtroller: sectionVC, cell: cell)
        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == pagingCollectionView {
            
            pageCollectionView.isPagingEnabled = false
            pageCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            pageCollectionView.isPagingEnabled = true
            
            self.view.addSubview(menuIndicatorView)
            
            guard let cell = pagingCollectionView.cellForItem(at: indexPath) as? PagingCollectionViewCell else {
                return }
            print("이건 디드셀렉트아이템 바깥 구문")
            NSLayoutConstraint.deactivate(indicatorLayoutConstraint)
                                          
            menuIndicatorView.translatesAutoresizingMaskIntoConstraints = false
            indicatorLayoutConstraint = [ menuIndicatorView.leadingAnchor.constraint(equalTo:
                                                                                        cell.leadingAnchor),
                                          menuIndicatorView.trailingAnchor.constraint(equalTo:
                                                                                        cell.trailingAnchor),
                                          menuIndicatorView.topAnchor.constraint(equalTo: cell.bottomAnchor)]
            
            NSLayoutConstraint.activate(indicatorLayoutConstraint)
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded() }
            
            pageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

            
        }
    }
    
}

extension PagingViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print(scrollView.contentOffset.x)
        
        if scrollView.contentOffset.x > 375 {
            
        }
        //..menu.indicatorLeadingConstarint.constant = scrollView.contentOffset.x / 3
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let idx = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
        scrollToMenu(to: idx)
        print("ㅜㅇ왕부왕ㅂ우보앙")
    }
}
