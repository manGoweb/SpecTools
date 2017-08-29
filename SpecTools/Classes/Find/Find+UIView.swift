//
//  Find+UIView.swift
//  Pods
//
//  Created by Ondrej Rafaj on 25/08/2017.
//
//

import Foundation
import UIKit


// MARK: - Elements spec protocols

protocol SpecText { var text: String? { get set } }
protocol SpecTextNonOptional { var text: String! { get set } }
protocol SpecAttributedText { var attributedText: NSAttributedString? { get set } }
protocol SpecAttributedTextNonOptional { var attributedText: NSAttributedString! { get set } }
protocol SpecPlaceholder { var placeholder: String? { get set } }
protocol SpecPrompt { var prompt: String? { get set } }

extension UILabel: SpecText, SpecAttributedText { }
extension UITextField: SpecText, SpecAttributedText, SpecPlaceholder { }
extension UISearchBar: SpecText, SpecPlaceholder, SpecPrompt { }
extension UITextView: SpecTextNonOptional, SpecAttributedTextNonOptional { }


// MARK: - Traverser

extension SpecFind where T: UIView {
    
    // MARK: Public traversers
    
    public func first(labelWithText text: String, exactMatch: Bool = true, visualize: SpecVisualize = .none) -> UILabel? {
        let result: UILabel? = first(elementWithText: text, exactMatch: exactMatch, visualize: visualize) as? UILabel
        handle(result: result, forElementNamed: "Label", text: text, visualize: visualize)
        return result
    }
    
    public func first(textFieldWithText text: String, exactMatch: Bool = true, visualize: SpecVisualize = .none) -> UITextField? {
        let result: UITextField? = first(elementWithText: text, exactMatch: exactMatch, visualize: visualize) as? UITextField
        handle(result: result, forElementNamed: "Text field", text: text, visualize: visualize)
        return result
    }
    
    public func first(searchBarWithText text: String, exactMatch: Bool = true, visualize: SpecVisualize = .none) -> UISearchBar? {
        let result: UISearchBar? = first(elementWithText: text, exactMatch: exactMatch, visualize: visualize) as? UISearchBar
        handle(result: result, forElementNamed: "Search bar", text: text, visualize: visualize)
        return result
    }
    
    public func first(textViewWithText text: String, exactMatch: Bool = true, visualize: SpecVisualize = .none) -> UITextView? {
        let result: UITextView? = first(elementWithText: text, exactMatch: exactMatch, visualize: visualize) as? UITextView
        handle(result: result, forElementNamed: "Text view", text: text, visualize: visualize)
        return result
    }
    
    public func first(tableViewCellWithText text: String, exactMatch: Bool = true, visualize: SpecVisualize = .none) -> UITableViewCell? {
        return first(elementOfType: UITableViewCell.self, withText: text, exactMatch: exactMatch, visualize: visualize)
    }
    
    public func first(buttonWithText text: String, exactMatch: Bool = true, visualize: SpecVisualize = .none) -> UIButton? {
        return first(elementOfType: UIButton.self, withText: text, exactMatch: exactMatch, visualize: visualize)
    }
    
    public func first(tableSectionHeaderFooterViewWithText text: String, exactMatch: Bool = true, visualize: SpecVisualize = .none) -> UITableViewHeaderFooterView? {
        return first(elementOfType: UITableViewHeaderFooterView.self, withText: text, exactMatch: exactMatch, visualize: visualize)
    }
    
    public func first(tableHeaderFooterViewWithText text: String, exactMatch: Bool = true, visualize: SpecVisualize = .none) -> UIView? {
        guard let results = element.spec.find.all(elementsOfType: UITableView.self, visualize: visualize) else {
            handle(elementOfType: UITableView.self, text: text, visualize: visualize)
            return nil
        }
        
        for tableView: UITableView in results {
            if tableView.tableHeaderView != nil {
                if let _ = tableView.tableHeaderView!.spec.find.first(elementWithText: text, exactMatch: exactMatch) {
                    return tableView.tableHeaderView
                }
            }
            if tableView.tableFooterView != nil {
                if let _ = tableView.tableFooterView!.spec.find.first(elementWithText: text, exactMatch: exactMatch) {
                    return tableView.tableFooterView
                }
            }
        }
        return nil
    }
    
    public func first(elementWithText text: String, exactMatch: Bool = true, visualize: SpecVisualize = .none) -> UIView? {
        if visualize != .none {
            print("- \(Visualize.description(element, nil, visualize))")
        }
        
        let result: UIView? = first(elementWithText: text, exactMatch: exactMatch, visualize: visualize, level: 0)
        handle(result: result, forElementNamed: "Element", text: text, visualize: visualize)
        
        if visualize != .none && result != nil  {
            print("Element with text \"\(text)\" has been found\n\n")
        }
        
        return result
    }
    
    public func first<E>(elementOfType type: E.Type, withText text: String, exactMatch: Bool = true, visualize: SpecVisualize = .none) -> E? {
        if visualize != .none {
            print("- \(Visualize.description(element, nil, visualize))")
        }
        
        guard let results = all(elementsOfType: E.self, visualize: visualize, level: 0) else {
            handle(elementOfType: E.self, text: text, visualize: visualize)
            return nil
        }
        guard let element: E = recurse(results: results, withText: text, exactMatch: exactMatch) else {
            handle(elementOfType: E.self, text: text, visualize: visualize)
            return nil
        }
        
        print("\(String(describing: type)) has been found\n\n")
        
        return element
    }
    
    public func firstTableView(visualize: SpecVisualize = .none) -> UITableView? {
        return first(elementOfType: UITableView.self, visualize: visualize)
    }
    
    public func firstScrollView(visualize: SpecVisualize = .none) -> UIScrollView? {
        return first(elementOfType: UIScrollView.self, visualize: visualize)
    }
    
    public func firstTableHeaderFooterView(visualize: SpecVisualize = .none) -> UITableViewHeaderFooterView? {
        return first(elementOfType: UITableViewHeaderFooterView.self, visualize: visualize)
    }
    
    public func first<E>(elementOfType type: E.Type, visualize: SpecVisualize = .none) -> E? {
        guard let results = element.spec.find.all(elementsOfType: E.self, visualize: visualize, level: 0) else {
            handle(elementOfType: E.self, visualize: visualize)
            return nil
        }
        
        print("\(String(describing: type)) has been found\n\n")
        
        return results.first
    }
    
    public func all<T>(elementsOfType type: T.Type, visualize: SpecVisualize) -> [T]? {
        if visualize != .none {
            print("- \(Visualize.description(element, nil, visualize))")
        }
        
        var elements: [T]? = nil
        
        for subview: UIView in element.subviews {
            if subview is T {
                if elements == nil {
                    elements = []
                }
                elements!.append(subview as! T)
            }
            else if let subElements = subview.spec.find.all(elementsOfType: type, visualize: visualize) {
                if elements == nil {
                    elements = []
                }
                elements?.append(contentsOf: subElements)
            }
        }
        
        return elements
    }
    
    // MARK: Text retrieval
    
    public func anyText(preferablyMatching text: String? = nil) -> String? {
        var textFound: String? = nil
        
        // Label
        if let e: UILabel = element as? UILabel {
            textFound = anyText(fromLabel: e, preferablyMatching: text ?? "")
        }
        
        // Text field
        if let e: UITextField = element as? UITextField {
            textFound = anyText(fromTextField: e, preferablyMatching: text ?? "")
        }
        
        // Search bar
        if let e: UISearchBar = element as? UISearchBar {
            textFound = anyText(fromSearchBar: e, preferablyMatching: text ?? "")
        }
        
        // Text view
        if let e: UITextView = element as? UITextView {
            textFound = anyText(fromTextView: e, preferablyMatching: text ?? "")
        }
        
        return textFound
    }
    
    // MARK: Private helpers
    
    private func anyText(fromLabel element: UILabel, preferablyMatching text: String) -> String? {
        var textFound: String? = nil
        
        if let tf: String = get(text: element) {
            textFound = tf
        }
        if textFound != text {
            if let tf: String = get(attributedText: element) {
                textFound = tf
            }
        }
        
        return textFound
    }
    
    private func anyText(fromTextField element: UITextField, preferablyMatching text: String) -> String? {
        var textFound: String? = nil
        
        if let tf: String = get(text: element) {
            textFound = tf
        }
        if textFound != text {
            if let tf: String = get(attributedText: element) {
                textFound = tf
            }
            if textFound != text {
                if let tf: String = get(placeholder: element) {
                    textFound = tf
                }
            }
        }
        
        return textFound
    }
    
    private func anyText(fromSearchBar element: UISearchBar, preferablyMatching text: String) -> String? {
        var textFound: String? = nil
        
        if let tf: String = get(text: element) {
            textFound = tf
        }
        if textFound != text {
            if let tf: String = get(placeholder: element) {
                textFound = tf
            }
            if textFound != text {
                if let tf: String = get(prompt: element) {
                    textFound = tf
                }
            }
        }
        
        return textFound
    }
    
    private func anyText(fromTextView element: UITextView, preferablyMatching text: String) -> String? {
        var textFound: String? = nil
        
        if let tf: String = get(text: element) {
            textFound = tf
        }
        if textFound != text {
            if let tf: String = get(attributedText: element) {
                textFound = tf
            }
        }
        
        return textFound
    }
    
    private func recurse<E>(results: [E], withText text: String, exactMatch: Bool) -> E? {
        let visualize: SpecVisualize = .none
        if results.count > 0 {
            for r: E in results {
                let e: UIView = r as! UIView
                if let _ = e.spec.find.first(elementWithText: text, visualize: visualize) {
                    return r
                }
            }
        }
        
        return nil
    }
    
    private func handle<T>(elementOfType: T.Type, text: String, visualize: SpecVisualize) {
        if visualize != .none {
            let className = String(describing: type(of: T.self))
            print("\(className) with text \"\(text)\" has not been found\n\n")
        }
    }
    
    private func handle<T>(elementOfType: T.Type, visualize: SpecVisualize) {
        if visualize != .none {
            let className = String(describing: type(of: T.self))
            print("\(className) has not been found\n\n")
        }
    }
    
    private func handle(result: UIView?, forElementNamed name: String, text: String, visualize: SpecVisualize) {
        if visualize != .none {
            if result == nil {
                print("\(name) with text \"\(text)\" has not been found\n\n")
            }
        }
    }
    
    private func first(elementWithText text: String, exactMatch: Bool, visualize: SpecVisualize, level: Int) -> UIView? {
        if visualize != .none && level == 0 {
            print("\nTraverse search for element with text \"\(text)\" has started")
        }
        
        for subview: UIView in element.subviews {
            let textFound: String? = subview.spec.find.anyText(preferablyMatching: text)
            
            if visualize != .none {
                let item: String = "\(spaces(forLevel: level))\(Visualize.description(subview, textFound, visualize))"
                print(item)
            }
            
            if exactMatch == true {
                if textFound == text {
                    return subview
                }
            }
            else {
                if textFound?.contains(text) ?? false {
                    return subview
                }
            }
            
            if let element = subview.spec.find.first(elementWithText: text, exactMatch: exactMatch, visualize: visualize, level: (level + 1)) {
                return element
            }
        }
        return nil
    }
    
    private func all<T>(elementsOfType type: T.Type, visualize: SpecVisualize, level: Int) -> [T]? {
        if visualize != .none && level == 0 {
            print("\nTraverse search for element of type \"\(String(describing:type))\" has started")
        }
        
        var elements: [T]? = nil
        for subview: UIView in element.subviews {
            if visualize != .none {
                let subviewText: String? = subview.spec.find.anyText(preferablyMatching: "")
                let item: String = "\(spaces(forLevel: level))\(Visualize.description(subview, subviewText, visualize))"
                print(item)
            }
            
            if subview is T {
                if elements == nil {
                    elements = []
                }
                elements?.append(subview as! T)
            }
            
            if let subElements = subview.spec.find.all(elementsOfType: type, visualize: visualize, level: (level + 1)) {
                if elements == nil {
                    elements = []
                }
                elements?.append(contentsOf: subElements)
            }
        }
        return elements
    }
    
    func get<T>(text element: T) -> String? where T: SpecText {
        return element.text
    }
    
    func get<T>(text element: T) -> String? where T: SpecTextNonOptional {
        return element.text
    }
    
    func get<T>(attributedText element: T) -> String? where T: SpecAttributedText {
        return element.attributedText?.string
    }
    
    func get<T>(attributedText element: T) -> String? where T: SpecAttributedTextNonOptional {
        return element.attributedText?.string
    }
    
    func get<T>(placeholder element: T) -> String? where T: SpecPlaceholder {
        return element.placeholder
    }
    
    func get<T>(prompt element: T) -> String? where T: SpecPrompt{
        return element.prompt
    }
    
    private func spaces(forLevel level: Int) -> String {
        var output = ""
        for _ in 0...level {
            output += "  "
        }
        output += " - "
        return output
    }
    
}
