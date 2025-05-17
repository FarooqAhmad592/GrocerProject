//
//  HomeViewModel.swift
//  GrocerProject
//
//  Created by Farooq Ahmad on 17/05/2025.
//

import Foundation

protocol HomeViewModelProtocol {
   
    var banners: [String] { get }
    var categories: [String] { get }
    var products: [(name: String, image: String)] { get }
    var selectedCategory: String? { get set }
    func fetchData() async
    func filterProducts(by category: String)
}

class HomeViewModel: HomeViewModelProtocol {
    
    var banners: [String] = []
    var categories: [String] = []
    var products: [(name: String, image: String)] = []
    var selectedCategory: String?
    private var allProducts: [String: [(name: String, image: String)]] = [:]

    func fetchData() async {
        
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        banners = ["banner1", "banner2", "banner3"]
        categories = ["Shoes", "Clothing", "Electronics", "Books", "Beauty", "Toys", "Home", "Sports"]

        allProducts = [
            "Shoes": (1...10).map { ("Shoes \($0)", "shoes") },
            "Clothing": (1...10).map { ("Clothing \($0)", "clothing") },
            "Electronics": (1...10).map { ("Electronics \($0)", "electronicse") },
            "Books": (1...10).map { ("Books \($0)", "books") },
            "Beauty": (1...10).map { ("Beauty \($0)", "beauty") },
            "Toys": (1...10).map { ("Toys \($0)", "toys") },
            "Home": (1...10).map { ("Home \($0)", "home") },
            "Sports": (1...10).map { ("Sports \($0)", "sports") },
        ]

        if let firstCategory = categories.first {
            selectedCategory = firstCategory
            products = allProducts[firstCategory] ?? []
        }
    }

    func filterProducts(by category: String) {
        selectedCategory = category
        products = allProducts[category] ?? []
    }
}
