//
//  CarouselView.swift
//  RSSchool_T10_GameCounter
//
//  Created by Liza Kryshkovskaya on 28.08.21.
//

import UIKit

protocol CarouselViewDelegate {
    func currentPageDidChange(to page: Int)
}

class CarouselView: UIView, UICollectionViewDelegateFlowLayout {

    struct CarouselData {
        let name: String
        var points: Int?
        var rank = 0
    }
        
    // MARK: - Subviews
        
    private lazy var carouselCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.dataSource = self
        collection.delegate = self
        collection.register(CarouselCell.self, forCellWithReuseIdentifier: "Cell")
        collection.backgroundColor = .clear
        return collection
    }()
        
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .white
        return pageControl
    }()
    
    
    // MARK: - Properties
        
    private var pages: Int
    private var delegate: CarouselViewDelegate?
    private var carouselData = [CarouselData]()
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            delegate?.currentPageDidChange(to: currentPage)
        }
    }
            
    init(pages: Int, delegate: CarouselViewDelegate?) {
        self.pages = pages
        self.delegate = delegate
        super.init(frame: .zero)
        
        backgroundColor = .clear
        setupCollectionView()
        setupPageControl()
    }
    
    func setupCollectionView() {
        let cellPadding = (frame.width - 300) / 2
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: 255, height: 300)
        carouselLayout.sectionInset = .init(top: 0, left: cellPadding, bottom: 0, right: cellPadding)
        carouselLayout.minimumLineSpacing = cellPadding * 2
        carouselCollectionView.collectionViewLayout = carouselLayout
        
        addSubview(carouselCollectionView)
        carouselCollectionView.translatesAutoresizingMaskIntoConstraints = false
        carouselCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        carouselCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        carouselCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        carouselCollectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
        
    func setupPageControl() {
        addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pageControl.widthAnchor.constraint(equalToConstant: 150).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 24).isActive = true
        pageControl.numberOfPages = pages
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource
extension CarouselView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CarouselCell
        let name = carouselData[indexPath.row].name
        
//        let rank = carouselData[indexPath.row].rank
        cell.configure(name: name)
        return cell
    }
    
    public func changePoints(player: Int, points: Int) {
        let indexPath = IndexPath.init(row: player, section: 0)
        let cell = carouselCollectionView.cellForItem(at: indexPath) as! CarouselCell
        cell.setPoints(points: points)
        
    }
}

// MARK: - UICollectionView Delegate
extension CarouselView: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        currentPage = getCurrentPage()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
}

// MARK: - Public
extension CarouselView {
    
    public func configureView(with data: [CarouselData]) {
        let cellPadding = (frame.width - 255) / 2
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: 255, height: 300)
        carouselLayout.sectionInset = .init(top: 0, left: cellPadding, bottom: 0, right: cellPadding)
        carouselLayout.minimumLineSpacing = cellPadding * 2
        carouselCollectionView.collectionViewLayout = carouselLayout
        
        carouselData = data
        carouselCollectionView.reloadData()
    }
    
    public func setPages(pages: Int) {
        self.pages = pages
        pageControl.numberOfPages = pages
    }
    
    public func getCurentPage() -> Int{
        return pageControl.currentPage
    }
    
    public func nextPage() {
        var indexPath = IndexPath()
        if currentPage == carouselData.count {
            indexPath = IndexPath(row: 0, section: 0)
        } else {
            indexPath = IndexPath(row: currentPage + 1, section: 0)
        }
        carouselCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        currentPage = getCurrentPage()
    }
    
    public func previousPage() {
        var indexPath = IndexPath()
        if currentPage == 0 {
            indexPath = IndexPath(row: carouselData.count - 1, section: 0)
        } else {
            indexPath = IndexPath(row: currentPage - 1, section: 0)
        }
        carouselCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        currentPage = getCurrentPage()
    }
}

// MARKK: - Helpers
private extension CarouselView {
    func getCurrentPage() -> Int {
        
        let visibleRect = CGRect(origin: carouselCollectionView.contentOffset, size: carouselCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = carouselCollectionView.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }
        
        return currentPage
    }
}
