//
//  BooksViewController.swift
//  TakeItEasy2
//
//  Created by Liban Abdinur on 6/10/22.
//

import UIKit
import PDFKit


class BooksViewController: UIViewController, UICollectionViewDataSource, UISearchControllerDelegate,UISearchBarDelegate, UISearchResultsUpdating {
    
    
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    @IBOutlet weak var CollectionViewA: UICollectionView!
    
    
    @IBOutlet weak var CollectionViewB: UICollectionView!
    
    
    @IBOutlet weak var CollectionViewC: UICollectionView!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Books"

        // Do any additional setup after loading the view.
    }
    
    var filtered:[String] = []
    var searchActive: Bool = false
    let searchController = UISearchController(searchResultsController: nil)
    
    var GeneralBooks = ["The Great Gatsby","Catcher In the Rye","The Kite Runner"]
    var technicalBooks = ["learning python fast","learning web design", "PhotoShop-book"]
    var cookBooks = ["thai-cookbook","italian-cookbook","french-cookbook"]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
        if collectionView == self.CollectionViewA{

            return GeneralBooks.count
        }
        else if collectionView == self.CollectionViewB{
            return technicalBooks.count
        }
        else if collectionView == self.CollectionViewC{
            return cookBooks.count
        }
        return 0
    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchActive = false
//        self.dismiss(animated: true,completion: nil)
//    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar, name: [String]) -> [String] {
        
        
        var store: [String] = []
        
        if !searchBar.text!.isEmpty{

        
            
            for d in name {
        
                if d.contains(searchBar.text!){
                    
                    store.append(d)
                    print(d)
                }
                
                
                
            }
            return store
            
            
    
            
        }
        
        else
        {
            
            for d in name{
                store.append(d)
            }
            
            
            return store
        }
    
        
    }
    @IBAction func ClickSearch(_ sender: Any) {
        searchBarSearchButtonClicked(SearchBar, name: GeneralBooks)

        
        
        
    }
    
    
    
    
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchActive = true
//        CollectionViewA.reloadData()
//    }
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchActive = true
//        CollectionViewA.reloadData()
//    }
//
//    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
//        if !searchActive{
//            searchActive = true
//            CollectionViewA.reloadData()
//        }
//        searchController.searchBar.resignFirstResponder()
    //}
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        searchBarSearchButtonClicked(SearchBar, name:GeneralBooks)
        
        
        var cell1 = MyCollectionViewCell()
    
        
        if collectionView == self.CollectionViewA{
            
            searchBarSearchButtonClicked(SearchBar, name:GeneralBooks)
            cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! MyCollectionViewCell
            cell1.backgroundColor = .green
            cell1.nameA.text = GeneralBooks[indexPath.row]
            
            return cell1
            
        }
        else if collectionView == self.CollectionViewB{
            var cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! MyCollectionViewCell
            cell2.backgroundColor = .blue
            cell2.nameB.text = technicalBooks[indexPath.row]
            cell2.backgroundView?.backgroundColor = .black
            
            return cell2
            
        }
        else  {
            var cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! MyCollectionViewCell
            cell3.backgroundColor = .orange
            cell3.nameC.text = cookBooks[indexPath.row]
            
            return cell3
        
        }
        
        return cell1
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row{
            
        case 0:
            
            if collectionView == self.CollectionViewA{
                let storyObject = UIStoryboard(name: "Main", bundle: nil)
                let pdfScreenVC = storyObject.instantiateViewController(withIdentifier: "pdfscreen") as! ThePDFViewController
                pdfScreenVC.pdfName = GeneralBooks[indexPath.row]
                present(pdfScreenVC, animated: true, completion: nil)
                
            }else if collectionView == self.CollectionViewB{
                
                let storyObject1 = UIStoryboard(name: "Main", bundle: nil)
                let pdfScreenVC1 = storyObject1.instantiateViewController(withIdentifier: "pdfscreen") as! ThePDFViewController
                pdfScreenVC1.pdfName = technicalBooks[indexPath.row]
                present(pdfScreenVC1, animated: true, completion: nil)
                
            }else if collectionView == self.CollectionViewC{
                let storyObject2 = UIStoryboard(name: "Main", bundle: nil)
                let pdfScreenVC2 = storyObject2.instantiateViewController(withIdentifier: "pdfscreen") as! ThePDFViewController
                pdfScreenVC2.pdfName = cookBooks[indexPath.row]
                present(pdfScreenVC2, animated: true, completion: nil)            }
            
            
        case 1:
            
            if collectionView == self.CollectionViewA{
                let storyObject = UIStoryboard(name: "Main", bundle: nil)
                let pdfScreenVC = storyObject.instantiateViewController(withIdentifier: "pdfscreen") as! ThePDFViewController
                pdfScreenVC.pdfName = GeneralBooks[indexPath.row]
                present(pdfScreenVC, animated: true, completion: nil)
                
            }else if collectionView == self.CollectionViewB{
                
                let storyObject1 = UIStoryboard(name: "Main", bundle: nil)
                let pdfScreenVC1 = storyObject1.instantiateViewController(withIdentifier: "pdfscreen") as! ThePDFViewController
                pdfScreenVC1.pdfName = technicalBooks[indexPath.row]
                present(pdfScreenVC1, animated: true, completion: nil)
                
            }else if collectionView == self.CollectionViewC{
                let storyObject2 = UIStoryboard(name: "Main", bundle: nil)
                let pdfScreenVC2 = storyObject2.instantiateViewController(withIdentifier: "pdfscreen") as! ThePDFViewController
                pdfScreenVC2.pdfName = cookBooks[indexPath.row]
                present(pdfScreenVC2, animated: true, completion: nil)
            }
                
       case 2:
                
                if collectionView == self.CollectionViewA{
                    let storyObject = UIStoryboard(name: "Main", bundle: nil)
                    let pdfScreenVC = storyObject.instantiateViewController(withIdentifier: "pdfscreen") as! ThePDFViewController
                    pdfScreenVC.pdfName = GeneralBooks[indexPath.row]
                    present(pdfScreenVC, animated: true, completion: nil)
                    
                }else if collectionView == self.CollectionViewB{
                    
                    let storyObject1 = UIStoryboard(name: "Main", bundle: nil)
                    let pdfScreenVC1 = storyObject1.instantiateViewController(withIdentifier: "pdfscreen") as! ThePDFViewController
                    pdfScreenVC1.pdfName = technicalBooks[indexPath.row]
                    present(pdfScreenVC1, animated: true, completion: nil)
                    
                }else if collectionView == self.CollectionViewC{
                    let storyObject2 = UIStoryboard(name: "Main", bundle: nil)
                    let pdfScreenVC2 = storyObject2.instantiateViewController(withIdentifier: "pdfscreen") as! ThePDFViewController
                    pdfScreenVC2.pdfName = cookBooks[indexPath.row]
                    present(pdfScreenVC2, animated: true, completion: nil)
                }
            
        case 3:
            if collectionView == self.CollectionViewA{
                let storyObject = UIStoryboard(name: "Main", bundle: nil)
                let pdfScreenVC = storyObject.instantiateViewController(withIdentifier: "pdfscreen") as! ThePDFViewController
                pdfScreenVC.pdfName = GeneralBooks[indexPath.row]
                present(pdfScreenVC, animated: true, completion: nil)
                
            }else if collectionView == self.CollectionViewB{
                
                let storyObject1 = UIStoryboard(name: "Main", bundle: nil)
                let pdfScreenVC1 = storyObject1.instantiateViewController(withIdentifier: "pdfscreen") as! ThePDFViewController
                pdfScreenVC1.pdfName = technicalBooks[indexPath.row]
                present(pdfScreenVC1, animated: true, completion: nil)
                
            }else if collectionView == self.CollectionViewC{
                let storyObject2 = UIStoryboard(name: "Main", bundle: nil)
                let pdfScreenVC2 = storyObject2.instantiateViewController(withIdentifier: "pdfscreen") as! ThePDFViewController
                pdfScreenVC2.pdfName = cookBooks[indexPath.row]
                present(pdfScreenVC2, animated: true, completion: nil)
            }
            
    default:
            print("")
            
            
            
            
        }
        
        
        
    }

    
    

    

}
