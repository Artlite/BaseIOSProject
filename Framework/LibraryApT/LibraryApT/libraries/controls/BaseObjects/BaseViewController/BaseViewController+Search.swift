//
//  BaseViewController+Search.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 5/5/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

extension BaseViewController {
   
    /**
     Method which provide the action when search button closed
     
     - parameter searchBar: search button
     */
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.hideKeyboard();
        searchBar.text = "";
        self.onSearchEvent(event: SearchEvent.CANCEL, text:  searchBar.text);
    }
    
    /**
     Method which provide the action when search button is clicked
     
     - parameter searchBar: search bar
     */
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.onSearchEvent(event: SearchEvent.SEARCH, text:  searchBar.text);
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            self.onSearchEvent(event: SearchEvent.CANCEL, text:  searchBar.text);

        }
    }
    
}
