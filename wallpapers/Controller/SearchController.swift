//
//  SearchController.swift
//  wallpapers
//
//  Created by Николай on 02.02.2022.
//

import UIKit

class SearchController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var inputSearch: UITextField!
    
    weak var delegate: MainViewControllerDelegate?
    private var tags: [Tag] = []
    
    private var cellWidth: Int = 0
    private var cellHeight: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setUI()
    }
    
    private func setUI() {
        
        cellWidth = Int(collectionView.frame.size.width)
        cellHeight = Config.searchCellHeight
    
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 4
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        collectionView.collectionViewLayout = layout
        collectionView.register(TagViewCell.nib(), forCellWithReuseIdentifier: TagViewCell.identifier)
    }
    
    @IBAction func searchEditing(_ sender: Any) {
        
        let q = inputSearch.text ?? ""

        Backend.tagSearch(q: q) { tags in
        
            //print(products)
            self.tags = tags
            
            //Страница на стадии заполнения
            if(self.tags.isEmpty) {
                self.tags.insert(Tag(), at: 0)
            }
            
            self.collectionView.reloadData()
        }
    }
    
}

extension SearchController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        Storage.setTag(tag: tags[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(tags[indexPath.row].id > 0) {
                
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagViewCell.identifier, for: indexPath) as! TagViewCell
            cell.configure(tag: tags[indexPath.row])
            return cell
                    
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelViewCell.identifier, for: indexPath) as! LabelViewCell
            cell.configure(text: Config.contentEmpty)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}
