//
//  ZokratesLexer.swift
//  SourceEditor
//
//  Created by Ronald "Danger" Mannak on 3/20/19.
//  Copyright © 2019 Silver Fox. All rights reserved.
//

import Foundation
import SavannaKit
import SourceEditor

public class ZokratesLexer: SourceCodeRegexLexer {
    
    public init() {
        
    }
    
    lazy var generators: [TokenGenerator] = {
        
        var generators = [TokenGenerator?]()
        
        // Functions
        
        generators.append(regexGenerator("(?<=(\\s|\\[|,|:))\\d+", tokenType: .number))
        
        generators.append(regexGenerator("\\.\\w+", tokenType: .identifier))
        
        let keywords = "import def return for in endfor if fi as".components(separatedBy: " ")
        
        generators.append(keywordGenerator(keywords, tokenType: .keyword))
        
        let stdlibIdentifiers = "field bool private".components(separatedBy: " ")
        
        generators.append(keywordGenerator(stdlibIdentifiers, tokenType: .identifier))
        
        let stdlibFunctions = "sha256 and isbool not or xor main".components(separatedBy: " ")
        
        generators.append(keywordGenerator(stdlibFunctions, tokenType: .keyword))
        
        // Comment
        generators.append(regexGenerator("//(.*)", tokenType: .comment))
        
        // String literal
        generators.append(regexGenerator("(\"|@\")[^\"\\n]*(@\"|\")", tokenType: .string))
        
        // Editor placeholder
        var editorPlaceholderPattern = "(<#)[^\"\\n]*"
        editorPlaceholderPattern += "(#>)"
        generators.append(regexGenerator(editorPlaceholderPattern, tokenType: .editorPlaceholder))
        
        return generators.compactMap( { $0 })
    }()
    
    public func generators(source: String) -> [TokenGenerator] {
        return generators
    }
    
}
