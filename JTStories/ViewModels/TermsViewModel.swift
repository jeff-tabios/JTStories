//
//  TermsViewModel.swift
//  JTStories
//
//  Created by Jeff Tabios on 01/08/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation

protocol TermsList{
    var maxItems: Int {get}
    var terms: [String] {get set}
    var count: Int { get }
    mutating func save(term: String)
    func getTerm(_ index: Int)->String
    func getTerms()->[String]
}

extension TermsList {
    var maxItems: Int {
        return 10
    }
    
    var count: Int {
        return terms.count
    }
    
    mutating func save(term: String){
        if !terms.contains(term) {
            if terms.count >= maxItems {
                terms.removeFirst()
            }
            terms.append(term)
        }
    }
    
    func getTerm(_ index: Int)->String {
        return terms[index]
    }
    
    func getTerms() -> [String] {
        return terms.reversed()
    }
}

struct TermsViewModel: TermsList {
    var terms: [String]
}
