//
//  ScanOptionButton.swift
//  VinylShelf
//
//  Created by ddudkin on 1. 5. 2026..
//

import SwiftUI

struct AddOptionButton: View {
    enum ButtonType {
        case search
        case scan
        case cancel
        
        var imageName: String {
            switch self {
            case .search:
                return "text.magnifyingglass"
            case .scan:
                return "barcode.viewfinder"
            case .cancel:
                return "xmark"
                
            }
        }
        
        var title: String {
            switch self {
            case .search:
                return Texts.addBottomSheetSearch
            case .scan:
                return Texts.addBottomSheetScan
            case .cancel:
                return Texts.cancel
            }
        }
        
        var desctiption: String? {
            switch self {
            case .search:
                return Texts.addBottomSheetSearchDescription
            case .scan:
                return Texts.addBottomSheetScanDescription
            case .cancel:
                return nil
            }
        }
    }
    
    let buttonType: ButtonType
    let action: EmptyClosure
    
    init(buttonType: ButtonType, action: @escaping EmptyClosure) {
        self.buttonType = buttonType
        self.action = action
    }
    
    var body: some View {
        VStack {
            Button(action: action) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: buttonType.imageName)
                            .font(.title2)
                            .foregroundStyle(.black)
                        
                        Text(buttonType.title)
                            .font(.title2)
                            .foregroundStyle(.black)
                        
//                        Spacer()
                    }
                    
                    if let description = buttonType.desctiption {
                        Text(description)
                            .foregroundStyle(.gray)
                    }
                    
                    RoundedRectangle(cornerRadius: 8)
                        .frame(height: 1)
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}

#Preview {
    AddOptionButton(buttonType: .scan) {
        print("action")
    }
}
