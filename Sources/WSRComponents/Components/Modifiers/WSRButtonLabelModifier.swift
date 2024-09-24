//
//  WSRButtonLabelModifier.swift
//  WSR
//
//  Created by William S. Rena on 9/24/24.
//

import SwiftUI

public struct WSRButtonLabelModifier: ViewModifier {
    
    var bgColor: Color
    var fgColor: Color
    var font: Font? = nil
    
    public func body(content: Content) -> some View {
        content
            .font(getFont())
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(bgColor)
            .foregroundColor(fgColor)
            .cornerRadius(10)
    }
    
    private func getFont() -> Font {
        if let font2 = font {
            return font2
        }
        return .footnote
    }
}

struct WSRButtonLabelModifierView: View {
    var body: some View {
        Button(action: {
            
        },
               label: {
            Text("Lorem ipsum dolor".uppercased())
                .wsr_ButtonLabel(bgColor: .black, fgColor: .red, font: .footnote.bold())
        })
        .padding(.bottom)
    }
}

struct WSRButtonLabelModifierView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            WSRButtonLabelModifierView()
        }
        .padding(10)
    }
}
