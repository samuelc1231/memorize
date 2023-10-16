//
//  ContentView.swift
//  Memory Card
//
//  Created by Samuel Cheng on 2023/9/16.
//

import SwiftUI


struct ContentView: View {
    
    @State var selectedTheme = "Animals"
    
    let themes: [String: [String]] = [
        "Animals": ["🐶", "🐱", "🐭", "🐹", "🐰", "🐶", "🐱", "🐭", "🐹", "🐰"],
        "Nature": ["🌲", "🌲", "🌿", "🌿", "🌻", "🌻", "🌞", "🌞", "🌸", "🌸"],
        "Flags": ["🇺🇸", "🇬🇧", "🇫🇷", "🇩🇪", "🇨🇦", "🇺🇸", "🇬🇧", "🇫🇷", "🇩🇪", "🇨🇦"]
    ]
    
    let themeImages: [String: String] = [
        "Animals": "pawprint.circle.fill",
        "Nature": "leaf.fill",
        "Flags": "flag.fill"
    ]

    var selectedEmojis : [String] {
        themes[selectedTheme] ?? []
    }
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themeButtons
        }
        .padding()
    }
    
    var cards: some View {
        
        let shuffledEmojis = selectedEmojis.shuffled()

        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))]) {
            ForEach(0..<selectedEmojis.count, id: \.self) { index in
                CardView(content: shuffledEmojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var themeButtons: some View {
        HStack {
            ForEach(Array(themes.keys.sorted()), id: \.self) { theme in
                themeButton(switchTo: theme)
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    func themeButton(switchTo theme: String) -> some View {
        Button {
            selectedTheme = theme
        } label: {
            VStack {
                if let imageName = themeImages[theme] {
                    Image(systemName: imageName)
                } else {
                    // Handle the case where the image name is missing or nil
                    // You can provide a default image or an error message here
                }
                Text(theme)
            }
        }
    }

    
//    var cardCountAdjusters: some View {
//        HStack{
//            cardRemover
//            Spacer()
//            cardAdder
//        }
//        .imageScale(.large)
//        .font(.title2)
//    }
    
//    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
//        Button (action: {
//            cardCount += offset
//        }, label: {
//            Image(systemName: symbol)
//        })
//        .disabled(cardCount + offset < 1 || cardCount + offset > selectedEmojis.count)
//    }
//    
//    var cardRemover: some View {
//        cardCountAdjuster(by: -1, symbol: "rectangle.stack.fill.badge.minus")
//    }
//    
//    var cardAdder: some View {
//        cardCountAdjuster(by: 1, symbol: "rectangle.stack.fill.badge.plus")
//    }
}

struct CardView : View {
    let content : String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.system(size: 42))
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
