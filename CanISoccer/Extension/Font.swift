//
//  Font.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/09/29.
//

import SwiftUI

enum NotoSansKR: String {
    case black900 = "NotoSansKR-Black"
    case bold700 = "NotoSansKR-Bold"
    case light300 = "NotoSansKR-Light"
    case medium500 = "NotoSansKR-Medium"
}

extension View {
    func customFont(_ font: NotoSansKR, size: CGFloat) -> some View {
        return self.font(.custom(font.rawValue, size: size))
    }
}
